//
//  FAShopingFirmOrderViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShopingFirmOrderViewController.h"
#import "FAShoppingHeaderView.h"
#import "FAShoppingSectionModel.h"
#import "FAShoppingItemModel.h"
#import "FAShoppingFirmOrderTableCell.h"
#import "FAShoppingOrderFooterView.h"
#import "FAShoppingMinHeaderView.h"
#import "FAShoppingIntegtateView.h"

#import "FAShoppingFirmOrderDownView.h"
@interface FAShopingFirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)FAShoppingIntegtateView *integrateView;

@property(nonatomic,strong)FAShoppingFirmOrderDownView *commitOrderView;


@end

@implementation FAShopingFirmOrderViewController

- (void)viewDidLoad {
    if (self.shoppingKind ==FAShoppingKindMore) {
        self.title =@"全部订单";
    }else {
        self.title =@"单个订单";// 立即购买引发的
    }
    [super viewDidLoad];
    
    // tableView 和 积分之间的间隙
    CGFloat integrateTableSpacing =10 *kAppScale;
    
    CGFloat tableViewH =SCREEN_HEIGHT -kFirmOrderDownSuperViewHeight -NavigationBar_BarHeight - kShoppingIntegtateHeight -integrateTableSpacing;
    
    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, tableViewH);
    self.integrateView.frame =CGRectMake(0, CGRectGetMaxY(self.tableView.frame) +integrateTableSpacing, SCREEN_WIDTH, kShoppingIntegtateHeight);
    self.commitOrderView.frame =CGRectMake(0, CGRectGetMaxY(self.integrateView.frame), SCREEN_WIDTH, kFirmOrderDownSuperViewHeight);
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.integrateView];
    [self.view addSubview:self.commitOrderView];
    
    // 测试颜色
    self.integrateView.backgroundColor =[UIColor blueColor];
    self.commitOrderView.backgroundColor =[UIColor yellowColor];
    
    // Block 传递汇总
    WS(ws);
    self.commitOrderView.firmOrderDownBlock =^(NSInteger btnTag) {
        DDLog(@"点击了确认订单按钮");
    };
    
    
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
    
    FAShoppingFirmOrderTableCell *cell =[FAShoppingFirmOrderTableCell updateWithTableView:tableView];
    if (cell) {
        
        FAShoppingSectionModel *shoppingSection =self.allDataSource[indexPath.section];
        NSArray *allShoppingArr =shoppingSection.allItemArray;
        if (indexPath.section <self.allDataSource.count) {
            if (allShoppingArr.count) {
                // 编辑按钮和完成按钮的实现逻辑
                //                cell.isReviseCount =self.isSelected;
                cell.itemModel =allShoppingArr[indexPath.item];
            
            }
            

        }

        
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
    if (section ==0) {
        return kShoppingMinHeaderViewHeight;
    }
    return kShoppingHeaderViewHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return kShoppingOrderFooterViewHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section    {
    if (section ==0) {
        FAShoppingMinHeaderView *headerMinView =[FAShoppingMinHeaderView updateWithHeaderTableView:tableView];
        if (headerMinView) {
//            WS(ws);
            FAShoppingSectionModel *shoppingSection =self.allDataSource[section];
            headerMinView.sectionModel =shoppingSection;
            headerMinView.addressModel =self.addressModel;
            headerMinView.clickPlaceBlock =^(NSInteger tag) {
                DDLog(@"进入地址VC");
            };
           
        }
        return headerMinView;

    }else {
    
        FAShoppingHeaderView *headerView =[FAShoppingHeaderView updateWithHeaderTableView:tableView];
        if (headerView) {
            if (section <self.allDataSource.count) {
                FAShoppingSectionModel *shoppingSection =self.allDataSource[section];
                headerView.isSelected =NO;
                headerView.sectionModel =shoppingSection;
                // 当前类专用属性，目的是为了去掉购物车主界面中的选择按钮
                headerView.isHiddenSel =YES;
            }
            
        }
        return headerView;

    }
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FAShoppingOrderFooterView *footerView =[FAShoppingOrderFooterView updateWithFooterTableView:tableView];
    if (footerView) {
        if (section <self.allDataSource.count) {
            FAShoppingSectionModel *shoppingSection =self.allDataSource[section];
            footerView.sectionModel =shoppingSection;
   
        }
    }
    return footerView;
    
}

#pragma mark -  Setter & Getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
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

-(FAAddressModel *)addressModel {
    if (!_addressModel) {
        _addressModel =[[FAAddressModel alloc]init];
        _addressModel.address_id =@"22";
        _addressModel.consignee_address =@"河南省郑州市*************************";
        _addressModel.consignee_name =@"动力无限";
        _addressModel.consignee_phe =@"1378888888";
        _addressModel.flag =1;
        _addressModel.remarks =@"备注来来来";
    }
    return _addressModel;
}
-(FAShoppingIntegtateView *)integrateView {
    if (!_integrateView) {
        _integrateView =[FAShoppingIntegtateView IntegrateView];
    }
    return _integrateView;
}

-(FAShoppingFirmOrderDownView *)commitOrderView {
    if (!_commitOrderView) {
        _commitOrderView =[FAShoppingFirmOrderDownView FirmOrderDownView];
    }
    return _commitOrderView;
}

@end
