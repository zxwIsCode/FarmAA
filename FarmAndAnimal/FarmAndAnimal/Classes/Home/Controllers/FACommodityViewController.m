//
//  FACommodityViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FACommodityViewController.h"
#import "MJRefresh.h"
#import "FACommotidyModel.h"
#import "NHBussinessCollectionViewCell.h"
#import "FAEnterCommodityViewController.h"
#import "FASearchBarViewController.h"
#import "FAShoppingViewController.h"
#import "FASectionView.h"
@interface FACommodityViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,FASectionViewDelegate>{
 
    /*
     销量
     */

    NSInteger _currentSellingIndex;
    /*
     价格
     */
    NSInteger _currentPriceIndex;
   
    MJRefreshNormalHeader *_header;
    MJRefreshAutoNormalFooter *_footer;
    NSInteger  _loadPage;
    //搜索关键词
    NSString * _searchString;
}
/*
 商家列表数组
 */
@property(nonatomic,strong)NSMutableArray *infoArray;
/*
 智能排序
 */
@property(nonatomic,strong)NSMutableArray *orderData;
/*
 附近距离
 */
@property(nonatomic,strong)NSMutableArray *nearData;
/*
 商家分类
 */
@property(nonatomic,strong)NSMutableArray *commodiyData;

@property (nonatomic,strong) FASectionView *sectionView;

@property (nonatomic,strong) UICollectionView *momentCollectionView;
@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@end

@implementation FACommodityViewController
@synthesize classid;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initNavBar];
    [self getListRequest:2];
    [self initMJRefresh];
    [self.view addSubview:self.sectionView];
}
-(void)initData{
    _loadPage = 1;
    _searchString = @"";
    _currentSellingIndex = 2;
    _currentPriceIndex = 2;
}
-(void)initNavBar{
    UIButton *  tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setAdjustsImageWhenHighlighted:NO];
    tempBtn.frame = CGRectMake(0, 0, 38, 38);
    [tempBtn setImage:ImageNamed(@"icon_gouwuche") forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(enterShopping) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.navigationItem.titleView = self.searchBar;
}

-(void)initMJRefresh{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    _header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.momentCollectionView.mj_header = _header;
    
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    _footer.triggerAutomaticallyRefreshPercent = 0.2;
    _footer.automaticallyChangeAlpha = YES;
    // 隐藏刷新状态的文字
    _footer.refreshingTitleHidden = YES;
    
    // 设置footer
    self.momentCollectionView.mj_footer = _footer;
}
#pragma mark   点击事件
-(void)enterShopping{
    FAShoppingViewController * shoppingVC = [[FAShoppingViewController alloc] init];
    [self.navigationController pushViewController:shoppingVC animated:YES];
}
#pragma mark   下拉刷新数据
- (void)loadNewData
{
    self.momentCollectionView.userInteractionEnabled = NO;
    _loadPage = 1;
    [self getListRequest:1];
}

#pragma mark   上拉加载更多数据
- (void)loadMoreData
{
    self.momentCollectionView.userInteractionEnabled = NO;
    _loadPage ++;
    [self getListRequest:2];
}
-(void)getListRequest:(NSInteger)currentType{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kGood_GetGoodListData;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:self.classid forKey:@"classid"];
    [params setValue:_searchString forKey:@"search"];
    [params setValue:@(_currentSellingIndex) forKey:@"sale"];
    [params setValue:@(_currentPriceIndex) forKey:@"unit"];

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
                [_infoArray removeAllObjects];
            }

            NSArray *reqponseArray =(NSArray *)result.data;
            for (NSDictionary *dictionary in reqponseArray) {
                FACommotidyModel *model = [FACommotidyModel updatWithDic:dictionary];
                [ws.infoArray addObject:model];
            }
            [ws.view addSubview:ws.momentCollectionView];
        }else {  // 失败的情况
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [self endTransition];
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}
-(void)endTransition{
    self.momentCollectionView.userInteractionEnabled = YES;
    [_header endRefreshing];
    [_footer endRefreshing];
}
#pragma mark -
#pragma mark - －－－－－CollectionViewDelegate&Datasource－－－－－
//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _infoArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NHBussinessCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"NHBussinessCollectionViewCell" forIndexPath:indexPath];
    FACommotidyModel * commotidyModel = [self.infoArray objectAtIndex:indexPath.row];
  
    cell.commodityNameLabel.text = commotidyModel.gname;
    cell.priceLabel.text  = [NSString stringWithFormat:@"¥%@",commotidyModel.gp];
    cell.wholePriceLabel.text = [NSString stringWithFormat:@"%@积分",commotidyModel.intlpay];
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:commotidyModel.gpo] placeholderImage:nil];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FACommotidyModel * commotidyModel = [self.infoArray objectAtIndex:indexPath.row];
    FAEnterCommodityViewController * enterCommodityVC = [[FAEnterCommodityViewController alloc] init];
    enterCommodityVC.commodityModel = commotidyModel;
    [self.navigationController pushViewController:enterCommodityVC animated:YES];
}
#pragma mark -- UICollectionViewDelegate
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(SCREEN_WIDTH/2-1, 250);
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
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    FASearchBarViewController * searchVC = [[FASearchBarViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}
#pragma mark    FASectionView delegate
- (void)chooseSection:(NSInteger)section upAndDown:(NSInteger)upDown{
    switch (section) {
        case 100:
        {
            _currentSellingIndex = upDown;
            _currentPriceIndex = upDown;
        }
            break;
        case 101:
        {
            _currentSellingIndex = upDown;
        }
            break;
        case 102:
        {
            _currentPriceIndex = upDown;
        }
            break;
        default:
            break;
    }
    [self getListRequest:1];
}
#pragma mark    初始化
-(UICollectionView *)momentCollectionView{
    if (!_momentCollectionView) {
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 1.0f;
        
        _momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,45, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_BarHeight-NavigationBar_HEIGHT) collectionViewLayout:layout];
        _momentCollectionView.delegate = self;
        _momentCollectionView.dataSource =self;
        _momentCollectionView.backgroundColor = [UIColor whiteColor];
        [_momentCollectionView registerNib:[UINib nibWithNibName:@"NHBussinessCollectionViewCell"  bundle:nil]forCellWithReuseIdentifier:@"NHBussinessCollectionViewCell"];
        [_momentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _momentCollectionView;
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0,20, SCREEN_WIDTH-40, NavigationBar_HEIGHT)];
        [_searchBar setPlaceholder:@"搜索商品名称"];
        [_searchBar setBackgroundColor:RGBCOLOR(251, 58, 47)];
        [_searchBar setBarTintColor:RGBCOLOR(251, 58, 47)];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        [_searchBar setReturnKeyType:UIReturnKeySearch];
    }
    return _searchBar;
}
-(FASectionView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[FASectionView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, NavigationBar_HEIGHT)];
        _sectionView.delegate = self;
        _sectionView.backgroundColor = [UIColor whiteColor];
    }
    return _sectionView;
}
-(NSMutableArray *)infoArray{
    if (!_infoArray) {
        _infoArray = [[NSMutableArray alloc] init];
    }
    return _infoArray;
}
-(NSMutableArray *)orderData{
    if (!_orderData) {
        _orderData = [[NSMutableArray alloc] init];
    }
    return _orderData;
}
-(NSMutableArray *)nearData{
    if (!_nearData) {
        _nearData = [[NSMutableArray alloc] init];
    }
    return _nearData;
}
-(NSMutableArray *)commodiyData{
    if (!_commodiyData) {
        _commodiyData = [[NSMutableArray alloc] init];
    }
    return _commodiyData;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
