//
//  FAPayKindViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAPayKindViewController.h"
#import "FAPayKindModel.h"

#import "FAPayKindTableCell.h"


@interface FAPayKindViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *payArr;

@property(nonatomic,strong)UIButton *yesPayBtn;

// 那个平台是选中状态
@property(nonatomic,assign)NSInteger indexKind;

@end

@implementation FAPayKindViewController

#pragma mark - Init

- (void)viewDidLoad {
    
    self.title =@"收银台";
    [super viewDidLoad];
    
    self.indexKind =0;
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self initAllPayKindDatas];
    
    CGFloat lableH =50 *kAppScale;
    CGFloat rightLableW =120 *kAppScale;
    
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100 *kAppScale,lableH)];
    lable.text =@"支付方式";
    UILabel *rightLable =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -rightLableW -10, 0, rightLableW,lableH)];
    rightLable.text =@"还需支付:xxx元";
    rightLable.textColor =[UIColor redColor];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, lableH -1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =[UIColor lightGrayColor];
   
    CGFloat yesPayBtnH =50 *kAppScale;
    CGFloat tableViewHeight = SCREEN_HEIGHT -yesPayBtnH -NavigationBar_BarHeight- lableH;
    
    self.tableView.frame =CGRectMake(0, CGRectGetMaxY(lable.frame), SCREEN_WIDTH, tableViewHeight);
    
    self.yesPayBtn.frame =CGRectMake(0, SCREEN_HEIGHT -NavigationBar_BarHeight  -yesPayBtnH, SCREEN_WIDTH, yesPayBtnH);
    
    [self.view addSubview:lable];
    [self.view addSubview:rightLable];
    [self.view addSubview:lineView];
    
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.yesPayBtn];
    
    
   
    // Do any additional setup after loading the view.
}
#pragma mark - Private Methods

-(void)initAllPayKindDatas {
//    NSArray *kindIconArr ;
    NSArray *kindStrArr =@[@"银联支付",@"支付宝支付",@"微信支付"];
    NSArray * iconArr =@[@"icon_zhifuyl",@"icon_zhifuzhi",@"icon_zhifuwei"];
    for (int index =0; index <3; index ++) {
        FAPayKindModel *payModel =[[FAPayKindModel alloc]init];
        payModel.payKindIcon =[iconArr objectAtIndex:index];
        payModel.payKindStr =kindStrArr[index];
        if (index ==0) {
            payModel.isSelected =YES;
        }else {
            payModel.isSelected =NO;
  
        }
        [self.payArr addObject:payModel];
    }
    
}
-(void)cancleAllSelected {
    NSMutableArray *payOriginalArr =self.payArr;
    for (FAPayKindModel *model in payOriginalArr) {
        model.isSelected =NO;
    }
    self.payArr =payOriginalArr;
}

#pragma mark - Action Methods

-(void)yesPayBtnClick:(UIButton *)button {
    FAPayKindModel *model = self.payArr[self.indexKind];
    DDLog(@"您点击了%@平台的确认支付",model.payKindStr);
}
#pragma mark - UITableViewDelegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.payArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAPayKindTableCell *cell =[FAPayKindTableCell updateWithTableView:tableView];
    if (cell) {
        if (self.payArr.count) {
            FAPayKindModel *model =self.payArr[indexPath.row];
            cell.model =model;
        }
    }
    WS(ws);
    cell.payKindBlock = ^(FAPayKindModel *model) {
        // 所有的取消选择状态
        [ws cancleAllSelected];
        
        if (!model.isSelected) {
            model.isSelected =!model.isSelected;
        }
        // 确定点击的是哪一个
        if ([self.payArr containsObject:model]) {
            ws.indexKind =[self.payArr indexOfObject:model] ;
        }
        [ws.tableView reloadData];
    };

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 *kAppScale;
}

#pragma mark - Setter & Getter

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
//        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
-(NSMutableArray *)payArr {
    if (!_payArr) {
        _payArr =[NSMutableArray array];
    }
    return _payArr;
}
-(UIButton *)yesPayBtn {
    if (!_yesPayBtn) {
        _yesPayBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_yesPayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        _yesPayBtn.backgroundColor =[UIColor redColor];
        [_yesPayBtn addTarget:self action:@selector(yesPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yesPayBtn;
}

@end
