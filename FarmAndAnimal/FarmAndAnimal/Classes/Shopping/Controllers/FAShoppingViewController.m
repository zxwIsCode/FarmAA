//
//  FAShoppingViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/3.
//  Copyright © 2017年 DaviD. All rights reserved.
//  

#import "FAShoppingViewController.h"
#import "FAShoppingSectionModel.h"
#import "FAShoppingItemModel.h"
#import "FAShoppingTableCell.h"
#import "FAShoppingHeaderView.h"

#import "FAShoppingSelectedManager.h"
#import "FAShoppingDownView.h"
#import "FAShopingFirmOrderViewController.h"
#import "FAShoppingBuyNowViewController.h"
#import "FAShoppingJoinShopCarViewController.h"

#import "FACommotidyModel.h"


#define kTableViewHeight SCREEN_HEIGHT -TabBar_HEIGHT -NavigationBar_BarHeight-kSelectedAllSuperViewHeight

#define kShoppingMainCellId @"kShoppingMainCellId"

#define kRightItemEditeBtn  @"编辑"
#define kRightItemFinishBtn @"完成"



@interface FAShoppingViewController ()<UITableViewDelegate,UITableViewDataSource>


// 所有的数据源
@property(nonatomic,strong)NSMutableArray *allDataSource;
// 分区Title的数据源
@property(nonatomic,strong)NSMutableArray *sectionTitleArr;
// 购物车的数据管理类
@property(nonatomic,strong)FAShoppingSelectedManager *shoppingManager;

@property(nonatomic,strong)UITableView *tableView;
// 右上角的按钮
@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)FAShoppingDownView *normalDownView;

// 下面downModel 的公共数据源
@property(nonatomic,strong)FAShoppingDownModel *downModel;

// 是否是编辑模式
@property(nonatomic,assign)BOOL isSelected;

#pragma mark - Test
// 临时展示的假数据
@property(nonatomic,strong)FACommotidyModel *itemModel;

@end

@implementation FAShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSelected =NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.normalDownView];
    
    // 界面传值Block处理大集中
    WS(ws);
    self.normalDownView.downViewBlock =^(UIButton *btn) {
        if (btn.tag ==10) {
            DDLog(@"点击了全选按钮");
            // 暂时走到确认订单的地方
//            FAShopingFirmOrderViewController *firmOrder =[[FAShopingFirmOrderViewController alloc]init];
//            [ws.navigationController pushViewController:firmOrder animated:YES];
//            // 注意：以下2个属性必须绑定在一起即：
//            //FAShoppingKindMore：allDataSource
//            //FAShoppingKindSingle:itemModel
//            if (ws.isSelected) {
//                firmOrder.shoppingKind =FAShoppingKindSingle;
//                firmOrder.itemModel =ws.itemModel;
//            }else {
//                firmOrder.shoppingKind =FAShoppingKindMore;
//                // 不要与当前的数据源有关联
//                firmOrder.allDataSource =[ws.allDataSource mutableCopy];
//            }
            if (btn.selected) {
                [ws.shoppingManager getAllSelectedData];
            }else {
                [ws.shoppingManager getAllPhotos];
            }
            [ws.tableView reloadData];
            
        }else {
            if (ws.isSelected) {
                DDLog(@"点击了删除按钮");
                // 暂时走到加入购物车的地方
                FAShoppingJoinShopCarViewController *joinShopCarVC =[[FAShoppingJoinShopCarViewController alloc]init];
                joinShopCarVC.commotidyModel =ws.itemModel;
                [ws.navigationController pushViewController:joinShopCarVC animated:YES];


            }else {
                DDLog(@"点击了结算按钮");
                FAShoppingBuyNowViewController *buyNowVC =[[FAShoppingBuyNowViewController alloc]init];
                buyNowVC.commotidyModel =ws.itemModel;
                [ws.navigationController pushViewController:buyNowVC animated:YES];
                
//                FAShopingFirmOrderViewController *firmOrderVC =[[FAShopingFirmOrderViewController alloc]init];
//                [ws.navigationController pushViewController:firmOrderVC animated:YES];
            }
        }
    };
    
    self.shoppingManager.selectedManagerBlock = ^(NSMutableArray *allDataArr ,BOOL isSuccess){
        if (isSuccess) {
            ws.allDataSource =allDataArr;
            [ws.tableView reloadData];

            
            // 立即购买展示的假数据
            if (ws.allDataSource.count) {
                FAShoppingSectionModel *shoppingSection =ws.allDataSource[0];
                NSArray *allShoppingArr =shoppingSection.allItemArray;
                if (allShoppingArr.count) {
                    ws.itemModel =allShoppingArr[0];
                }
                
            }
        }
        
    };
    

    
//    self.sectionTitleArr =[@[@"胖子➕专用",@"廋子➕专用",@"人妖➕专用",@"🐖债➕专用",] mutableCopy];
    
   [self.shoppingManager requestAllItems];
   
    
   

    
//    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.normalDownView.backgroundColor =[UIColor redColor];
    
    DDLog(@"normalDownView = %@",NSStringFromCGRect(self.normalDownView.frame));
}
#pragma mark - 继承父类

-(CMNavType)getNavType {
    return CMNavTypeNoLeftItem;
}
//定制导航栏右边的按钮
- (void)customNavigationRighItem
{
    
    self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame =CGRectMake(Num_Zero, Num_Zero, Ten*6, Ten*3);
    [self.rightButton setTitle:kRightItemEditeBtn forState:UIControlStateNormal];
    self.rightButton.titleLabel.font =[UIFont systemFontOfSize:15 *kAppScale];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.rightButton setAdjustsImageWhenDisabled:NO];
    [self.rightButton addTarget:self action:@selector(navigationRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)navigationRightButtonClick:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:kRightItemEditeBtn]) {// 点击了编辑按钮
        [self.rightButton setTitle:kRightItemFinishBtn forState:UIControlStateNormal];
        self.isSelected =YES;
        // 包装model
        self.downModel.isHaveTotolPrice =NO;
        self.downModel.totolPriceStr =@"00";
        self.downModel.rightStr =@"删除";

    }else if ([button.titleLabel.text isEqualToString:kRightItemFinishBtn]) {// 点击了完成按钮
        [self.rightButton setTitle:kRightItemEditeBtn forState:UIControlStateNormal];
        self.isSelected =NO;
        // 包装model
        self.downModel.isHaveTotolPrice =YES;
        self.downModel.totolPriceStr =@"$180";
        self.downModel.rightStr =@"结算(2)";

    }
    // 更改下面的DownView的状态
    self.normalDownView.downModel =self.downModel;
    
    // 不管什么状态都还原为没有选择的情况
    [self.shoppingManager getAllPhotos];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.allDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FAShoppingSectionModel *sectionModel =self.allDataSource[section];
    return sectionModel.allItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FAShoppingTableCell *cell =[FAShoppingTableCell updateWithTableView:tableView];
    if (cell) {
        if (indexPath.section <self.allDataSource.count) {
            FAShoppingSectionModel *shoppingSection =self.allDataSource[indexPath.section];
            NSArray *allShoppingArr =shoppingSection.allItemArray;
            if (allShoppingArr.count) {
                // 编辑按钮和完成按钮的实现逻辑
                
                // cell 界面设置
                cell.isReviseCount =self.isSelected;
                // cell 传值所用
                cell.itemModel =allShoppingArr[indexPath.item];
            }

        }
        WS(ws);
        cell.tableCellBlock =^(FACommotidyModel *model){
            [ws.tableView reloadData];
        };

               cell.backgroundColor =[UIColor greenColor];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kShoppingCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kShoppingHeaderViewHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section    {
    FAShoppingHeaderView *headerView =[FAShoppingHeaderView updateWithHeaderTableView:tableView];
    if (headerView) {
        if (section <self.allDataSource.count) {
            FAShoppingSectionModel *shoppingSection =self.allDataSource[section];
            headerView.isSelected =self.isSelected;
            headerView.sectionModel =shoppingSection;
            
            WS(ws);
            headerView.headerViewBlock =^(FAShoppingSectionModel *model){
                NSInteger index =[ws.allDataSource indexOfObject:model];
                [ws.shoppingManager selectedSection:index];
                [ws.tableView reloadData];
            };
        }
    }
    return headerView;
}




#pragma mark -  Setter & Getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTableViewHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

-(NSMutableArray *)allDataSource {
    if (!_allDataSource) {
        _allDataSource =[NSMutableArray array];
    }
    return _allDataSource;
}
-(NSMutableArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr =[NSMutableArray array];
    }
    return _sectionTitleArr;
}
-(FAShoppingSelectedManager *)shoppingManager {
    if (!_shoppingManager) {
        _shoppingManager =[[FAShoppingSelectedManager alloc]init];
    }
    return _shoppingManager;
}
-(FAShoppingDownView *)normalDownView {
    if (!_normalDownView) {
        _normalDownView =[FAShoppingDownView NormalDownView];
        _normalDownView.frame =CGRectMake(0, kTableViewHeight, SCREEN_WIDTH, kSelectedAllSuperViewHeight);
    }
    return _normalDownView;
}
-(FAShoppingDownModel *)downModel {
    if (!_downModel) {
        _downModel =[[FAShoppingDownModel alloc]init];
    }
    return _downModel;
}

@end
