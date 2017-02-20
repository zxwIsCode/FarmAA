//
//  FABussinessViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FABussinessViewController.h"
#import "FABussinessCollectionReusableView.h"
#import "FACommotidyModel.h"
#import "NHBussinessCollectionViewCell.h"
#import "YLInfiniteScrollView.h"
#import "FAEnterCommodityViewController.h"
#import "MJRefresh.h"
#define  kHeaderHight  270
@interface FABussinessViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,YLInfiniteScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *infoArray;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property (nonatomic,strong) UICollectionView *momentCollectionView;
@end

@implementation FABussinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"猪饲料服务中心";
    [self getListRequest];
}
-(void)getListRequest{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetHotGoods;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:self.bid forKey:@"bid"];

    model.paramDic =params;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"没有数据哦!"];
                return ;
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
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
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
        FABussinessCollectionReusableView *cell = (FABussinessCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        //        YLInfiniteScrollView *scrollView = [[YLInfiniteScrollView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, kScrollHeight)];
        //        scrollView.delegate = self;
        //        scrollView.images = self.imageArr;
        //        [cell addSubview:scrollView];
        cell.bussinessName = @"  猪饲料服务中心";
        
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
    FACommotidyModel * commotidyModel = [self.infoArray objectAtIndex:indexPath.row];
    FAEnterCommodityViewController * enterCommodityVC = [[FAEnterCommodityViewController alloc] init];
    enterCommodityVC.commodityModel = commotidyModel;
    [self.navigationController pushViewController:enterCommodityVC animated:YES];
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
        
        _momentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_BarHeight) collectionViewLayout:layout];
        _momentCollectionView.delegate = self;
        _momentCollectionView.dataSource =self;
        _momentCollectionView.backgroundColor = [UIColor whiteColor];
        [_momentCollectionView registerNib:[UINib nibWithNibName:@"NHBussinessCollectionViewCell"  bundle:nil]forCellWithReuseIdentifier:@"NHBussinessCollectionViewCell"];
        [_momentCollectionView registerClass:[FABussinessCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_momentCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _momentCollectionView;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
