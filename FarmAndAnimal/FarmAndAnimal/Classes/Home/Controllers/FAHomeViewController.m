//
//  CMHomeViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "FAHomeViewController.h"
#import "EVMainHeader.h"
#import "FACommotidyModel.h"
#import "NHBussinessCollectionViewCell.h"
#import "FACommodityViewController.h"
#import "YLInfiniteScrollView.h"
#import "FASearchBarViewController.h"
#import "FAHTMLBaseViewController.h"
#import "FAEnterCommodityViewController.h"
#import "FAHeaderSecCollectionReusableView.h"
#import "FAShoppingDetailPhotoModel.h"

@interface FAHomeViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,YLInfiniteScrollViewDelegate,EVMainHeaderDelegate>
{
    CGFloat  _headerHeight ;
}
/*
 商家列表数组
 */
//热销数据
@property(nonatomic,strong)NSMutableArray *sellingArray;
//推荐数据
@property(nonatomic,strong)NSMutableArray *tuiJianArray;
//轮播图
@property(nonatomic,strong)NSMutableArray *imageArr;

//分类
@property(nonatomic,strong)NSMutableArray *itemArray;

@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UICollectionView *momentCollectionView;
@end

@implementation FAHomeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.view addSubview:self.momentCollectionView];
    [self getBanner];
    [self getItemRequest];
    [self getSellingRequest];
    [self getTuiJianRequest];
    [self initNavBar];
}

#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeAll;
}
-(void)initNavBar{
    
    UIButton *  leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setAdjustsImageWhenHighlighted:NO];
    leftBtn.frame = CGRectMake(0, 0, 38*kAppScale, 38*kAppScale);
    [leftBtn setImage:ImageNamed(@"icon_syjifen") forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(enterAboutUs) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIButton *  tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setAdjustsImageWhenHighlighted:NO];
    tempBtn.frame = CGRectMake(0, 0, 38*kAppScale, 38*kAppScale);
    [tempBtn setImage:ImageNamed(@"icon_syjifen") forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(enterJifen) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.navigationItem.titleView = self.searchBar;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // 去除黑线
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[[UIImage alloc] init]];

}

#pragma mark     request
-(void)getItemRequest{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_GET;
    requestModel.appendUrl = kHome_GetHomeClassify;
    WS(ws);
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            ws.itemArray = result.data;
            CGFloat orign =  75*kAppScale ;
            if ([ws.itemArray count]%5>0) {
                _headerHeight =[ws.itemArray count]%5*orign+kScrollHeight+TabBar_HEIGHT+10;
            }else{
                _headerHeight = orign+kScrollHeight+TabBar_HEIGHT+10;
            }
            [ws.momentCollectionView reloadData];
        }
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
    }
// 轮播图
-(void)getBanner{

    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_GET;
    requestModel.appendUrl = kHome_GetCarousel;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            NSArray *reqponseArray =(NSArray *)result.data;
            for (NSDictionary *dictionary in reqponseArray) {
                FAShoppingDetailPhotoModel *model = [FAShoppingDetailPhotoModel updatShoppingDetailPhotoModelWithDic:dictionary];
                [ws.imageArr addObject:model];
            }
             [ws.momentCollectionView reloadData];
        }
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
//获取热销列表
-(void)getSellingRequest
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetHotGoods;
    model.type = CMHttpType_GET;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    model.paramDic =params;
    WS(ws);
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"请求没有数据哦!"];
                return ;
            }
            NSArray *reqponseArray =(NSArray *)result.data;
            for (NSDictionary *dictionary in reqponseArray) {
                FACommotidyModel *model = [FACommotidyModel updatWithDic:dictionary];
                [ws.sellingArray addObject:model];
            }
            [ws.momentCollectionView reloadData];
        }else {  // 失败的情况
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}

//获取推荐列表
-(void)getTuiJianRequest
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetNewTJGoods;
    model.type = CMHttpType_GET;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    model.paramDic =params;
    WS(ws);
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"请求没有数据哦!"];
                return ;
            }
            NSArray *reqponseArray =(NSArray *)result.data;
            for (NSDictionary *dictionary in reqponseArray) {
                FACommotidyModel *model = [FACommotidyModel updatWithDic:dictionary];
                [ws.tuiJianArray addObject:model];
            }
            [ws.momentCollectionView reloadData];
        }else {  // 失败的情况
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}

#pragma mark     点击事件
//进入积分界面
-(void)enterJifen
{
    
}

//进入关于我们
-(void)enterAboutUs
{
    FAHTMLBaseViewController * htmlVC = [[FAHTMLBaseViewController alloc] init];
    htmlVC.titleStr = @"关于我们";
    [htmlVC setUrl:@"http://app.xiudehao.net/guanyu.html"];
    [self.navigationController pushViewController:htmlVC animated:YES];
}

#pragma mark -  CollectionViewDelegate&Datasource
//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
      return self.tuiJianArray.count;
    }else{
      return self.sellingArray.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSString *CellIdentifier = @"footer";
        //从缓存中获取 Headercell
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = RGB(244, 245, 246);
        return cell;
    }else{
        if (indexPath.section == 0) {
            NSString *CellIdentifier = @"headerOne";
            //从缓存中获取 Headercell
            EVMainHeader *cell = (EVMainHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            YLInfiniteScrollView *YLScrollView = [[YLInfiniteScrollView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kScrollHeight)];
            YLScrollView.delegate = self;
            
            if (self.imageArr.count>0) {
            YLScrollView.images = self.imageArr;
            }
            
            [cell addSubview:YLScrollView];
            
            if (self.itemArray.count>0) {
            cell.itemArray = self.itemArray ;
            }
            
            [cell creatMainHeaderView];
            
            return cell ;
            
        }else{
           
            NSString *CellIdentifier = @"headerSec";
                
            FAHeaderSecCollectionReusableView *cell = (FAHeaderSecCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
            [cell creatOnlyButton];
            return cell ;
        }
    }
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    CGSize size = {SCREEN_WIDTH,10};
    return size;
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {SCREEN_WIDTH, _headerHeight};
        return size;
    }
    else
    {
        if (self.sellingArray.count>0) {
            CGSize size = {SCREEN_WIDTH,TabBar_HEIGHT};
            return size;
        }else{
            return CGSizeMake(0,0);
        }
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NHBussinessCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"NHBussinessCollectionViewCell" forIndexPath:indexPath];
    FACommotidyModel * commotidyModel = [[FACommotidyModel alloc] init];
    if (indexPath.section == 0) {
        if (self.tuiJianArray.count>0) {
             commotidyModel = [self.tuiJianArray objectAtIndex:indexPath.row];
        }
    }else{
        if (self.sellingArray.count>0) {
            commotidyModel = [self.sellingArray objectAtIndex:indexPath.row];
        }
    }
    cell.commodityNameLabel.text = commotidyModel.gname;
    cell.priceLabel.text  = [NSString stringWithFormat:@"¥%@",commotidyModel.gp];
    cell.wholePriceLabel.text = [NSString stringWithFormat:@"%@积分",commotidyModel.intlpay];
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:commotidyModel.gpo] placeholderImage:nil];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     FACommotidyModel * commotidyModel = [[FACommotidyModel alloc] init];
    if (indexPath.section == 0) {
        commotidyModel = [self.tuiJianArray objectAtIndex:indexPath.row];
    }else{
        commotidyModel = [self.sellingArray objectAtIndex:indexPath.row];
    }
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
#pragma mark -- EVMainHeaderDelegate
- (void)chooseCommodity:(NSString *)goodtype withGoodID:(NSString *)goodID
{
    FACommodityViewController * commodityVC = [[FACommodityViewController alloc] init];
    commodityVC.title = goodtype;
    commodityVC.classid = goodID;
    [self.navigationController pushViewController:commodityVC animated:YES];
}
#pragma mark    YLInfiniteScrollViewDelegate
- (void)scrollViewImageClick:(NSInteger)selectTag
{
//    debugMethod();
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
        [_momentCollectionView registerClass:[EVMainHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerOne"];
        [_momentCollectionView registerClass:[FAHeaderSecCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerSec"];
        [_momentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _momentCollectionView;
}

#pragma mark    searchBar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    FASearchBarViewController * searchVC = [[FASearchBarViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}

#pragma mark    初始化

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-40, NavigationBar_HEIGHT)];
        [_searchBar sizeToFit];
        [_searchBar setPlaceholder:@"搜索商品名称"];
        [_searchBar setBackgroundColor:RGBCOLOR(251, 58, 47)];
        [_searchBar setDelegate:self];
        [_searchBar setBarTintColor:RGBCOLOR(251, 58, 47)];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        [_searchBar setReturnKeyType:UIReturnKeySearch];
    }
    return _searchBar;
}
-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

-(NSMutableArray *)tuiJianArray{
    if (!_tuiJianArray) {
        _tuiJianArray = [[NSMutableArray alloc] init];
    }
    return _tuiJianArray;
}
-(NSMutableArray *)sellingArray{
    if (!_sellingArray) {
        _sellingArray = [[NSMutableArray alloc] init];
    }
    return _sellingArray;
}
-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
