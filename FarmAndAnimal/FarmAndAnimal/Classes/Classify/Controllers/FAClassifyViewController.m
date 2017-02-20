//
//  FAClassifyViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/3.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassifyViewController.h"
#import "FACoTitleReusableView.h"
#import "FAClassifyCoCell.h"

#import "FAClassifyAllItemModel.h"
#import "FAClassifySubAllItemModel.h"

#define kClassifyTableCellId        @"kClassifyTableCellId"
#define kClassifyCollectionCellId   @"kClassifyCollectionCellId"

#define kClassifyReusabaleViewId   @"kClassifyReusabaleViewId"

#define kTableViewWidth 100 *kAppScale
#define kCollectionWidth SCREEN_WIDTH - kTableViewWidth - 4
#define kSelectedBtnHeight 50 *kAppScale

@interface FAClassifyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *selectedAllBtn;
@property (nonatomic, strong) NSMutableArray *tableDataSource;
// collectionView 点击某个cell临时切换的数据源
//@property (nonatomic, strong) NSMutableArray *collectionDataSource;

// collectionView 点击某个cell临时切换的数据源
@property(nonatomic,strong)FAClassifyAllItemModel *collectionDataSourceModel;

// 所有的collectionView 需要的数据源
@property(nonatomic,strong)NSMutableArray *allDataSource;

@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

// 点击的第几个TableViewCell
@property(nonatomic,assign)NSInteger tableSelectedRow;

@end

@implementation FAClassifyViewController

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableSelectedRow =0;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.selectedAllBtn];
    [self.view addSubview:self.collectionView];
    // 模拟加载网络
    [[DisplayHelper shareDisplayHelper]showLoading:self.view noteText:@"加载中..."];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    });
    [self initAllDatas];

    
    
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.collectionView.backgroundColor =[UIColor whiteColor];
    self.tableView.backgroundColor = RGBACOLOR(240, 240, 240, 0.8);
    self.selectedAllBtn.frame =CGRectMake(kTableViewWidth+2, 2, kCollectionWidth, kSelectedBtnHeight);

    
}
#pragma mark - Private Methods
-(void)initAllDatas {
    // 开线程获得数据
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        self.tableDataSource =[@[@"家畜",@"家禽",@"兽药",@"宠物",@"动物"] mutableCopy];
//        
//        for (int j =0; j <self.tableDataSource.count; j ++) {
//            
//            NSMutableArray *sectionArr =[NSMutableArray array];
//            for (int index =0; index <self.tableDataSource.count; index ++) {
//                FAClassifySectionModel *sectionModel =[FAClassifySectionModel updateClassifySectionModelWithDic:nil];
//                sectionModel.sectionTitleStr =[NSString stringWithFormat:@"%@_%@_%d",self.tableDataSource[j],sectionModel.sectionTitleStr,index];
//                [sectionArr addObject:sectionModel];
//            }
//            [self.allDataSource addObject:sectionArr];
//
//        }
        
        CMHttpRequestModel *paramsModel =[[CMHttpRequestModel alloc]init];
        paramsModel.appendUrl =kClassify_GetGoodsTypeInfo;
        paramsModel.type =CMHttpType_GET;
        
        // 包装参数设置
        WS(ws);
        
        paramsModel.callback =^(CMHttpResponseModel *result, NSError *error) {
            
            if (result) {
                if (result.state == CMReponseCodeState_Success) {// 成功,做自己的逻辑
                    DDLog(@"%@",result.data);
                    if (result.alertMsg) {
                        [DisplayHelper displaySuccessAlert:result.alertMsg];
                    }else {
                        [DisplayHelper displaySuccessAlert:@"获取分类列表成功哦！"];
                    }
                    NSArray *infoArr =(NSArray *)result.data;
                    for (NSDictionary *infoDic in infoArr) {
                        FAClassifyAllItemModel *itemModel =[FAClassifyAllItemModel updateFAClassifyAllItemModelWithDic:infoDic];
                        [ws.allDataSource addObject:itemModel];
                        [ws.tableDataSource addObject:itemModel.bigGcname];

                    }
                    
                    // 刷新View，更新数据源
                    [[DisplayHelper shareDisplayHelper]hideLoading:self.view];
                    [self updataCoDataSource];
                    [self updateAllViews];
                    
                    
                }else {// 失败,弹框提示
                    
                    DDLog(@"%@",result.error);
                    if (result.alertMsg) {
                        [DisplayHelper displayWarningAlert:result.alertMsg];
                        
                    }else {
                        [DisplayHelper displayWarningAlert:@"请求成功,但没有数据哦!"];
                    }
                }
            }else {
                
                [DisplayHelper displayWarningAlert:@"网络异常，请稍后再试!"];
                
            }
            
        };
        [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:paramsModel];
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{// 主线程中更新UI
//            // 刷新View，更新数据源
//            [[DisplayHelper shareDisplayHelper]hideLoading:self.view];
//            [self updataCoDataSource];
//            [self updateAllViews];
//        });
//    });
}
// 刷新View，更新数据源
-(void)updateAllViews {
    
    [self.tableView reloadData];
    [self.collectionView reloadData];

}

-(void)updataCoDataSource {
    
    
    
    if (self.tableSelectedRow <self.allDataSource.count) {
        self.collectionDataSourceModel =self.allDataSource[self.tableSelectedRow] ;
    }
    [self.collectionView reloadData];
}
#pragma mark - Action Methods
// 点击了全部按钮
-(void)comeInDetailClick:(UIButton *)btn {
    self.selectedAllBtn.selected =!self.selectedAllBtn.selected;
    
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kClassifyTableCellId forIndexPath:indexPath];
    if (cell) {
//        cell.backgroundColor =[UIColor yellowColor];
        cell.textLabel.text =self.tableDataSource[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.tableSelectedRow = indexPath.row;
    
    // collectionView界面滑动到顶部效果
    self.collectionView.contentOffset =CGPointMake(0, 0);
    // 切换数据源刷新界面
    [self updataCoDataSource];
    
    
//    [self.collectionView scrollsToTop];
    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];

}

#pragma mark - UICollectionViewDelegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.collectionDataSourceModel.middleArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    FAClassifySubAllItemModel *subItemModel =self.collectionDataSourceModel.middleArr[section];
    return subItemModel.smallArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FAClassifyCoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kClassifyCollectionCellId forIndexPath:indexPath];
    if (cell) {
        FAClassifySubAllItemModel *subItemModel =self.collectionDataSourceModel.middleArr[indexPath.section];
        NSArray *allClassifyArr =subItemModel.smallArr;
        if (allClassifyArr.count) {
            cell.sub2Model =allClassifyArr[indexPath.item];
        }
        
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{

    FACoTitleReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:kClassifyReusabaleViewId
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {

        FAClassifySubAllItemModel *subItemModel =self.collectionDataSourceModel.middleArr[indexPath.section];
        view.sectionLable.text =subItemModel.middleGcname;
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kCollectionWidth, 44);
}

#pragma mark -  Setter & Getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kTableViewWidth, SCREEN_HEIGHT -TabBar_HEIGHT -NavigationBar_BarHeight)];
        _tableView.bounces =NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kClassifyTableCellId];
    }
    return _tableView;
}
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        
        self.flowLayout =[[UICollectionViewFlowLayout alloc]init];
        self.flowLayout.minimumInteritemSpacing =2*kAppScale;
        self.flowLayout.minimumLineSpacing =2*kAppScale;
        self.flowLayout.sectionInset =UIEdgeInsetsMake(8*kAppScale, 8*kAppScale, 8*kAppScale, 8*kAppScale);
        CGFloat itemWidth =(kCollectionWidth -8*kAppScale*2-2*kAppScale *2)/3.0;
        CGFloat itemHeight =44 *kAppScale;
        self.flowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 + kTableViewWidth, 2+kSelectedBtnHeight , kCollectionWidth, SCREEN_HEIGHT - TabBar_HEIGHT-NavigationBar_BarHeight - 4 -kSelectedBtnHeight) collectionViewLayout:self.flowLayout];

        _collectionView.dataSource =self;
        _collectionView.delegate =self;
//        _collectionView.bounces =NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //  设置cell
        [_collectionView registerClass:[FAClassifyCoCell class] forCellWithReuseIdentifier:kClassifyCollectionCellId];
        
        //  设置分区的title
        [_collectionView registerClass:[FACoTitleReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kClassifyReusabaleViewId];
    }
    
    return _collectionView;
}

-(UIButton *)selectedAllBtn {
    if (!_selectedAllBtn) {
        _selectedAllBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedAllBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_selectedAllBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_selectedAllBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [_selectedAllBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_selectedAllBtn addTarget:self action:@selector(comeInDetailClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _selectedAllBtn;
}
-(NSMutableArray *)tableDataSource {
    if (!_tableDataSource) {
        _tableDataSource =[NSMutableArray array];
    }
    return _tableDataSource;
}

-(FAClassifyAllItemModel *)collectionDataSourceModel {
    if (!_collectionDataSourceModel) {
        _collectionDataSourceModel =[[FAClassifyAllItemModel alloc]init];
    }
    return _collectionDataSourceModel;
}
-(NSMutableArray *)allDataSource {
    if (!_allDataSource) {
        _allDataSource =[NSMutableArray array];
    }
    return _allDataSource;
}

@end
