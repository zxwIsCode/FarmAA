//
//  FAAddressManagerViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAAddressManagerViewController.h"
#import "FAAddressModel.h"
#import "FAUserModel.h"
#import "FAAddressTableViewCell.h"
#import "FAMyAddressManagerViewController.h"
#define kDeleteTag  10000000000000000
#define kCommitTag  1000000
@interface FAAddressManagerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _listArray;
    FAUserModel * _userModel ;
}
@property (strong,nonatomic)UITableView * tableView;


@end

@implementation FAAddressManagerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAddressRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userModel = [FAUserTools UserAccount];
    [self.view addSubview:self.tableView];
    [self creatView];
}
-(void)creatView{
    UIButton * newAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newAddressBtn.frame = CGRectMake(0, SCREEN_HEIGHT-NavigationBar_BarHeight-NavigationBar_HEIGHT, SCREEN_WIDTH, NavigationBar_HEIGHT);
    [newAddressBtn setTitle:@"新建收货地址" forState:UIControlStateNormal];
    [newAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    newAddressBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [newAddressBtn addTarget:self action:@selector(newAddr) forControlEvents:UIControlEventTouchUpInside];
    [newAddressBtn setBackgroundColor:RGBCOLOR(251, 58, 47)];
    [self.view addSubview:newAddressBtn];
}
// 懒加载tableview
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0,0, SCREEN_WIDTH,SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
//保存请求
-(void)saveRequest:(NSInteger)index
{
    FAAddressModel * addressModels = [_listArray objectAtIndex:index];

    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kAddress_SetDefault;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:addressModels.address_id forKey:@"adid"];

    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            NSArray *array =(NSArray *)result.data;
        if (array.count) {
            NSDictionary *dictionary =array[0];
            FAAddressModel * addressModel = [FAAddressModel dicWithAddress:dictionary];
            //删除以前保存的收货地址
            [FAUserTools removeAllAddressDatas];
            if (addressModel.flag ==0) {
            [FAUserTools saveUserAddress:addressModel];
            }
            for (int i = 0; i<_listArray.count; i++) {
            if (index !=i) {
            FAAddressModel * addressM = [_listArray objectAtIndex:i];
            addressM.flag = 1;
            [_listArray replaceObjectAtIndex:i withObject:addressM];
        }
       }
         [_listArray replaceObjectAtIndex:index withObject:addressModel];
         [ws.tableView reloadData];

      }
    }else{
            [CMHttpStateTools showHtttpStateView:result.state];
    }
    [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
    
}
-(void)getAddressRequest
{
    _listArray = [[NSMutableArray alloc] init];
    
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_GET;
    requestModel.appendUrl = kAddress_AddressList;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_userModel.userid forKey:@"userid"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            NSArray *array =(NSArray *)result.data;
            for (int i = 0; i<array.count;i++) {
                FAAddressModel * addressModel = [FAAddressModel dicWithAddress:array[i]];
                [_listArray addObject:addressModel];
                if (addressModel.flag==0) {
                //删除以前保存的收货地址
                [FAUserTools removeAllAddressDatas];
                [FAUserTools saveUserAddress:addressModel];
            }

        }
            if (_listArray.count ==0||_listArray==nil) {
                [ws dontHaveShow:@"请添加您的收货地址" withPic:@"logo.png"];
            }else{
                [ws haveHidden];
                [ws.tableView reloadData];
            }
        }else{
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
        
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
/*
 删除地址请求
 */
-(void)deleteThisAddress:(NSInteger)index
{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kAddress_AddressDelete;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    FAAddressModel * addressModel =  [_listArray objectAtIndex:index] ;
    [paramDic setValue:addressModel.address_id forKey:@"address_id"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
         [DisplayHelper displaySuccessAlert:result.alertMsg];
        if (result.state ==CMReponseCodeState_Success) {
            [_listArray removeObjectAtIndex:index];
            [ws.tableView reloadData];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];

}

-(void)newAddr
{
    FAMyAddressManagerViewController * myAddressVC  = [[FAMyAddressManagerViewController alloc] init];
    myAddressVC.title = @"添加收货地址";
    [myAddressVC getAddressWithID:@"" withName:@"" withPhone:@"" withPeople:@"" withFlag:0 withRemarks:@""];
    [self.navigationController pushViewController:myAddressVC animated:YES];
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
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"FAAddressTableViewCell";
    
    FAAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FAAddressTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    FAAddressModel * addressModel =  [_listArray objectAtIndex:indexPath.row] ;
    cell.messageLabel.text = addressModel.consignee_name;
    cell.addressLabel.text = addressModel.consignee_address;
    cell.phoneLabel.text =addressModel.consignee_phe;
    if (addressModel.flag==0) {
        [cell.chooseNormalBtn setSelected:YES];
    }else{
        [cell.chooseNormalBtn setSelected:NO];
    }
    cell.deleteByn.tag = kDeleteTag + indexPath.row;
    cell.commitBtn.tag = kCommitTag + indexPath.row;
    [cell.deleteByn addTarget:self action:@selector(deleteThis:) forControlEvents:UIControlEventTouchUpInside];
    [cell.commitBtn addTarget:self action:@selector(commitThis:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self saveRequest:indexPath.row];
}
-(void)deleteThis:(id)sender
{
    UIButton * btn = (UIButton*)sender;
    [self deleteThisAddress:btn.tag-kDeleteTag];
}
-(void)commitThis:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    FAAddressModel * addressModel = [_listArray objectAtIndex:btn.tag-kCommitTag];
    FAMyAddressManagerViewController * commitVC = [[FAMyAddressManagerViewController alloc] init];
    commitVC.title = @"修改收货地址";
    [commitVC getAddressWithID:addressModel.address_id withName:addressModel.consignee_address withPhone:addressModel.consignee_phe withPeople:addressModel.consignee_name withFlag:addressModel.flag withRemarks:addressModel.remarks];
    [self.navigationController pushViewController:commitVC animated:YES];
}
@end
