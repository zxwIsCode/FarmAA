//
//  FASetupViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FASetupViewController.h"
#import "FAForgetViewController.h"
#import "FAPersonalCenterTableViewCell.h"
#import "FALoginViewController.h"
#define  kCellTag  10
#define  kDistance 200
@interface FASetupViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _kindsArray;
    NSMutableArray * _kindsImages;
}
@property (strong,nonatomic)UITableView * tableView;
@end

@implementation FASetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self creatTableView];
    [self creatView];
}
-(void)initData{
    _kindsArray = [[NSMutableArray alloc] initWithObjects:@"修改登录密码",@"修改支付密码", nil];
    _kindsImages = [[NSMutableArray alloc] initWithObjects:@"icon_denglumi.png",@"icon_zhifumi.png", nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 懒加载tableview
- (void)creatTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0,0, SCREEN_WIDTH,SCREEN_HEIGHT-NavigationBar_BarHeight-NavigationBar_HEIGHT) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
    [_tableView setBackgroundColor:RGB(240, 240, 240)];
    //cell无数据时，不显示间隔线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:v];
    [self.view addSubview:self.tableView];
}
-(void)creatView{
    UIButton * newAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newAddressBtn.frame = CGRectMake(0, SCREEN_HEIGHT-NavigationBar_BarHeight-NavigationBar_HEIGHT, SCREEN_WIDTH, NavigationBar_HEIGHT);
    [newAddressBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [newAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newAddressBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [newAddressBtn addTarget:self action:@selector(loginOutOfUser) forControlEvents:UIControlEventTouchUpInside];
    [newAddressBtn setBackgroundColor:RGBCOLOR(251, 58, 47)];
    [self.view addSubview:newAddressBtn];
}

#pragma mark - －－－－－行数－－－－－
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _kindsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"FAPersonalCenterTableViewCell";
    
    FAPersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FAPersonalCenterTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    cell.userInfoImg.image = ImageNamed([_kindsImages objectAtIndex:indexPath.row]);
    cell.tag = indexPath.row +kCellTag;
    cell.nameLabel.text = [_kindsArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * titleStr = [_kindsArray objectAtIndex:indexPath.row];
    FAForgetViewController * forgetVC = [[FAForgetViewController alloc] init];
    forgetVC.title = titleStr;
    [self.navigationController pushViewController:forgetVC animated:YES];
}
-(void)loginOutOfUser{
    [FAUserTools removeAllWechatAndUserDatas];
    FALoginViewController * loginVC = [[FALoginViewController alloc] init];
    loginVC.isChangePass = YES;
    [self presentViewController:loginVC animated:YES completion:nil];
}
@end
