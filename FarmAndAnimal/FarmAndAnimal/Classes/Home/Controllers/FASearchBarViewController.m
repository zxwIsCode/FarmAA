//
//  FASearchBarViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FASearchBarViewController.h"
#import "FACommotidyModel.h"
#import "MJRefresh.h"
#import "NHBussinessCollectionViewCell.h"
#import "FAEnterCommodityViewController.h"
@interface FASearchBarViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,UICollectionViewDelegate,UICollectionViewDataSource>
{
    MJRefreshAutoNormalFooter *_footer;
    NSInteger  _loadPage;

}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic,strong) UICollectionView *momentCollectionView;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong,nonatomic) NSString  * searchString;
@end

@implementation FASearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loadPage = 1;
    self.navigationItem.titleView = self.searchController.searchBar;
    [self initMJRefresh];
}
#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeNoRightItem;
}
#pragma mark - MJ

-(void)initMJRefresh{
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    _footer.triggerAutomaticallyRefreshPercent = 0.2;
    _footer.automaticallyChangeAlpha = YES;
    // 隐藏刷新状态的文字
    _footer.refreshingTitleHidden = YES;
    
    // 设置footer
    self.momentCollectionView.mj_footer = _footer;
}
#pragma mark - Request

-(void)getListRequest:(NSInteger)currentType {
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kGood_GetGoodListData;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:self.searchString forKey:@"search"];
    [params setValue:[NSNumber numberWithInteger:_loadPage] forKey:@"page"];
    model.paramDic =params;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"没有数据哦!"];
                return ;
            }
            if (currentType == 1) {
                [ws.searchList removeAllObjects];
            }
            
            NSArray *reqponseArray =(NSArray *)result.data;
            for (NSDictionary *dictionary in reqponseArray) {
                FACommotidyModel *model = [FACommotidyModel updatWithDic:dictionary];
                [ws.searchList addObject:model];
            }
            [ws.view addSubview:ws.momentCollectionView];
        }else {  // 失败的情况
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}

#pragma mark -
#pragma mark －－－－－上拉加载更多数据－－－－－
- (void)loadMoreData
{
    self.momentCollectionView.userInteractionEnabled = NO;
    _loadPage ++;
    [self getListRequest:2];
}

#pragma mark    TableviewDelegate
//设置区域
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.searchList count];

}
//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
   
    return cell;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.searchString = [self.searchController.searchBar text];
    
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    if (![self.searchString isEqualToString:@""]) {
         [self getListRequest:1];
    }
}
#pragma mark -  CollectionViewDelegate&Datasource
//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.searchList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NHBussinessCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"NHBussinessCollectionViewCell" forIndexPath:indexPath];
    FACommotidyModel * commotidyModel = [self.searchList objectAtIndex:indexPath.row];

    cell.commodityNameLabel.text = commotidyModel.gname;
    cell.priceLabel.text  = [NSString stringWithFormat:@"¥%@",commotidyModel.gp];
    cell.wholePriceLabel.text = [NSString stringWithFormat:@"%@积分",commotidyModel.intlpay];
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:commotidyModel.gpo] placeholderImage:nil];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FACommotidyModel * commotidyModel = [self.searchList objectAtIndex:indexPath.row];
    FAEnterCommodityViewController * commodityVC = [[FAEnterCommodityViewController alloc] init];
    commodityVC.commodityModel = commotidyModel;
    [self.navigationController pushViewController:commodityVC animated:YES];
}
#pragma mark -- UICollectionViewDelegate
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(SCREEN_WIDTH/2-1, 225);
    return size;
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0,0);
}

//定义每个UICollectionView 的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}

#pragma mark    searchBar delegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    [_header beginRefreshing];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    [_header beginRefreshing];
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark    初始化
-(NSString *)searchString{
    if (!_searchString) {
        _searchString = [[NSString alloc] init];
    }
    return _searchString;
}
-(NSMutableArray *)searchList{
    if (!_searchList) {
        _searchList = [[NSMutableArray alloc] init];
    }
    return _searchList;
}
-(UICollectionView *)momentCollectionView{
    if (!_momentCollectionView) {
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 1.0f;
        
        _momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBar_HEIGHT-NavigationBar_BarHeight) collectionViewLayout:layout];
        _momentCollectionView.delegate = self;
        _momentCollectionView.dataSource =self;
        _momentCollectionView.backgroundColor = [UIColor whiteColor];
        [_momentCollectionView registerNib:[UINib nibWithNibName:@"NHBussinessCollectionViewCell"  bundle:nil]forCellWithReuseIdentifier:@"NHBussinessCollectionViewCell"];
    }
    return _momentCollectionView;
}

-(UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
         [_searchController.searchBar setPlaceholder:@"搜索商品名称"];
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.barTintColor = RGBCOLOR(251, 58, 47);
        [_searchController.searchBar setBackgroundColor:RGBCOLOR(251, 58, 47)];
        [_searchController.searchBar.layer setBorderColor:[UIColor clearColor].CGColor];
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH-40, NavigationBar_HEIGHT);
        _searchController.searchBar.delegate = self;
        [self.searchController becomeFirstResponder];
    }
    return _searchController;
}
@end
