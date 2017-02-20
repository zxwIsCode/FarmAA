//
//  FAEnterCommodityViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAEnterCommodityViewController.h"
#import "FACommotidyModel.h"
#import "FABussinessViewController.h"
#import "NHBussinessCollectionViewCell.h"
#import "YLInfiniteScrollView.h"
#import "FAEnterCommodityViewController.h"
#import "FACommodityCollectionReusableView.h"
#import "EVbtnAndText.h"
#import "FAAllTalkViewController.h"
#import "FAShoppingJoinShopCarViewController.h"
#define kLabelFont 16 *kAppScale
#define  kHeaderHight  1150
@interface FAEnterCommodityViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,YLInfiniteScrollViewDelegate,FACommodityCollectionReusableViewDelegate>
{
    FAUserModel * _userModel ;
    NSString * _rateCount;
}

@property(nonatomic,strong)NSMutableArray *infoArray;
@property(nonatomic,strong)NSMutableArray *rateArray;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)UICollectionView *momentCollectionView;

@end

@implementation FAEnterCommodityViewController

- (void)viewDidLoad {
    self.title =  self.commodityModel.gname;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userModel = [FAUserTools UserAccount];
    _rateCount = @"";
    self.imageArr = self.commodityModel.gc;
   
    [self.view addSubview:self.momentCollectionView];
    
    [self getRequest];
    [self getRateRequest];
    [self creatBottomView];
    [self getGoodsHouseRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  创建视图
-(void)creatBottomView
{
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.momentCollectionView.frame), SCREEN_WIDTH, NavigationBar_HEIGHT)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    NSArray * iconArr = [NSArray arrayWithObjects:@"icon_kefua",@"icon_dianpu",@"icon_shoucang", nil];
    NSArray * selectArr = [NSArray arrayWithObjects:@"icon_kefua",@"icon_dianpua",@"icon_shoucanga", nil];
    NSArray * titleArr = [NSArray arrayWithObjects:@"客服",@"商铺",@"收藏",nil];
    
    for (int i = 0; i < selectArr.count; i ++) {
    UIButton * button = [CMCustomViewFactory createButton:CGRectMake(i * SCREEN_WIDTH/2/3,0,SCREEN_WIDTH/2/3, NavigationBar_HEIGHT) title:[titleArr objectAtIndex:i] normalImage:[UIImage imageNamed:[iconArr objectAtIndex:i]] selectImage:nil];
    [button setTag:i+10];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setImage:[UIImage imageNamed:[selectArr objectAtIndex:i]] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:[selectArr objectAtIndex:i]] forState:UIControlStateSelected];
    [button setTitleColor:RGB(175, 175, 175) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
        
    [self initButton:button];
        
    UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame),button.frame.origin.y,1,button.frame.size.height)];
    lineImg.backgroundColor = RGB(244, 245, 246);
    [bottomView addSubview:lineImg];
        
    }
    UIButton * addShoppingButton = [CMCustomViewFactory createButton:CGRectMake(SCREEN_WIDTH/2+3, 0, (SCREEN_WIDTH/2-3)/2, NavigationBar_HEIGHT) title:@"加入购物车" Image:nil];
    [addShoppingButton addTarget:self action:@selector(addShopping) forControlEvents:UIControlEventTouchUpInside];
    addShoppingButton.backgroundColor = UIColorFromHexValue(0xff9024);
    addShoppingButton.titleLabel.font = [UIFont systemFontOfSize:kLabelFont];
    [bottomView addSubview:addShoppingButton];
    
    UIButton * payButton = [CMCustomViewFactory createButton:CGRectMake(CGRectGetMaxX(addShoppingButton.frame), 0, (SCREEN_WIDTH/2-3)/2, NavigationBar_HEIGHT) title:@"立即购买" Image:nil];
    [payButton addTarget:self action:@selector(payForThis) forControlEvents:UIControlEventTouchUpInside];
    payButton.backgroundColor = UIColorFromHexValue(0xff3723);
    payButton.titleLabel.font = [UIFont systemFontOfSize:kLabelFont];
    [bottomView addSubview:payButton];
}
-(void)initButton:(UIButton*)btn{
    
    // 按钮图片和标题总高度
    CGFloat totalHeight = (btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn.imageView.frame.size.height), 0.0, 0.0, -btn.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn.imageView.frame.size.width, -(totalHeight - btn.titleLabel.frame.size.height),0.0)];
}
#pragma mark -  点击事件
-(void)btnAction:(id)sender
{
    UIButton * button = (UIButton *)sender;
    switch (button.tag) {
        case 10:
        {
            //客服
        }
            break;
        case 11:
        {
             //商铺
            FABussinessViewController * bussinessVC = [[FABussinessViewController alloc] init];
            bussinessVC.title =  @"商家详情";
            [self.navigationController pushViewController:bussinessVC animated:YES];
        }
            break;
        case 12:
        {
             //收藏
            [self selectGoodsHouseRequest];
        }
            break;
        default:
            break;
    }
}
//购物车
-(void)addShopping{
    FAShoppingJoinShopCarViewController * joinVC = [[FAShoppingJoinShopCarViewController alloc] init];
    joinVC.commotidyModel = self.commodityModel;
    [self.navigationController pushViewController:joinVC animated:YES];
}
//支付
-(void)payForThis
{
    
}
#pragma mark -  request
-(void)getRequest
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetNewTJGoods;
    model.type = CMHttpType_GET;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:_commodityModel.gcid forKey:@"classid"];
    [params setValue:_commodityModel.gid forKey:@"godsid"];
    model.paramDic =params;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"没有推荐的商品哦"];
                return ;
            }
            NSArray *reqponseArray =(NSArray *)result.data;
            for (NSDictionary *dictionary in reqponseArray) {
                FACommotidyModel *model = [FACommotidyModel updatWithDic:dictionary];
                [ws.infoArray addObject:model];
            }
            [ws.momentCollectionView reloadData];
        }else {  // 失败的情况
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}
// 获取是否已经收藏
-(void)getGoodsHouseRequest
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetGoodsHouse;
    model.type = CMHttpType_GET;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //    [params setValue:_userModel.userid forKey:@"userid"];
    [params setValue:@1 forKey:@"userid"];
    [params setValue:_commodityModel.gid forKey:@"godsid"];
    model.paramDic =params;
    WS(ws);
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        UIButton * collectionBtn = (UIButton *)[ws.view viewWithTag:12];
        if (result.state ==CMReponseCodeState_Success) {
            if ([[result.data objectForKey:@"state"] integerValue]==0) {
            collectionBtn.selected = NO;
            }else{
            collectionBtn.selected = YES;
            }
        }
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}
// 获取评价列表
-(void)getRateRequest
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetRate;
    model.type = CMHttpType_GET;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:@1 forKey:@"state"];
    [params setValue:_commodityModel.gid forKey:@"godsid"];
    model.paramDic =params;
    WS(ws);
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            self.rateArray = [result.data objectForKey:@"list"];
            _rateCount = [result.data objectForKey:@"num"];
           [ws.momentCollectionView reloadData];
        }
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}

//收藏、取消收藏
-(void)selectGoodsHouseRequest
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_SetGoodsHouse;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
//    [params setValue:_userModel.userid forKey:@"userid"];
    [params setValue:@1 forKey:@"userid"];
    [params setValue:_commodityModel.gid forKey:@"godsid"];
    model.paramDic =params;
    WS(ws);
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        UIButton * collectionBtn = (UIButton *)[ws.view viewWithTag:12];
        if (result.state ==CMReponseCodeState_Success) {
            if ([[result.data objectForKey:@"state"] integerValue]==0) {
                collectionBtn.selected = NO;
            }else{
                collectionBtn.selected = YES;
            }
        }else {  // 失败的情况
            
            [CMHttpStateTools showHtttpStateView:result.state];
        }
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}

#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeNoRightItem;
}
#pragma mark -  CollectionViewDelegate&Datasource
//section 的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.infoArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSString *CellIdentifier = @"footer";
        //从缓存中获取 Headercell
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = RGB(244, 245, 246);
        return cell;
    }else{
        NSString *CellIdentifier = @"header";
        //从缓存中获取 Headercell
        FACommodityCollectionReusableView *cell = (FACommodityCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = RGB(244, 245, 246);
        cell.delegate = self;
        
        YLInfiniteScrollView *scrollView = [[YLInfiniteScrollView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kScrollHeight)];
        scrollView.delegate = self;
        scrollView.images = self.imageArr;
        [cell addSubview:scrollView];
        
        cell.commodityName = _commodityModel.gname;
        cell.money =_commodityModel.gp;
        cell.saleNum = _commodityModel.sales;
        cell.uniprice = _commodityModel.intl;
        cell.talkcount = _rateCount;
        cell.webUrl = _commodityModel.godshtml;
        if (self.rateArray.count>0) {
        [cell setListArray:self.rateArray];
        [cell reloadRate];
        }
        return cell;
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
        CGSize size = {SCREEN_WIDTH, kHeaderHight};
        return size;
    }
    else
    {
        CGSize size = {SCREEN_WIDTH,TabBar_HEIGHT};
        return size;
    }
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
    FACommotidyModel * commotidy = [self.infoArray objectAtIndex:indexPath.row];
    FAEnterCommodityViewController * commodityVC = [[FAEnterCommodityViewController alloc] init];
    commodityVC.commodityModel = commotidy;
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
#pragma mark    FACommodityCollectionReusableViewDelegate

-(void)enterReadAllTalk{
    FAAllTalkViewController * allTalkVC = [[FAAllTalkViewController alloc] init];
    allTalkVC.title = @"全部评价";
    allTalkVC.gid = _commodityModel.gid;
    [self.navigationController pushViewController:allTalkVC animated:YES];
}
#pragma mark -  初始化
-(UICollectionView *)momentCollectionView{
    if (!_momentCollectionView) {
        //创建一个layout布局类
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 1.0f;
        
        _momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT-NavigationBar_BarHeight) collectionViewLayout:layout];
        _momentCollectionView.delegate = self;
        _momentCollectionView.dataSource =self;
        _momentCollectionView.backgroundColor = [UIColor whiteColor];
        [_momentCollectionView registerNib:[UINib nibWithNibName:@"NHBussinessCollectionViewCell"  bundle:nil]forCellWithReuseIdentifier:@"NHBussinessCollectionViewCell"];
        [_momentCollectionView registerClass:[FACommodityCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_momentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _momentCollectionView;
}
-(NSMutableArray *)rateArray{
    if (!_rateArray) {
        _rateArray = [[NSMutableArray alloc] init];
    }
    return _rateArray;
}
-(NSMutableArray *)infoArray{
    if (!_infoArray) {
        _infoArray = [[NSMutableArray alloc] init];
    }
    return _infoArray;
}
-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}
@end
