//
//  FAMyAddressManagerViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAMyAddressManagerViewController.h"
#import "FAAddressModel.h"
@interface FAMyAddressManagerViewController ()<UITextFieldDelegate>
{
    /*
     收货人姓名
     */
    UITextField * _nameTF;
    /*
     收货人手机号
     */
    UITextField * _phoneTF;
    /*
     备注
     */
    UITextField * _areaTF;
    /*
     收货地址
     */
    UITextField * _addressTF;
    FAUserModel * _userModel ;
    NSInteger _flag;
    NSString * _addressID;
}

@end

@implementation FAMyAddressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userModel = [FAUserTools UserAccount];
     [self creatView];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
}
-(void)creatView{
    UIButton *  tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setAdjustsImageWhenHighlighted:NO];
    tempBtn.frame = CGRectMake(0, 0, 80, 44);
    tempBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
    [tempBtn setTitle:@"保存" forState:UIControlStateNormal];
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(saveTheseMessage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
-(void)getAddressWithID:(NSString *)addressID withName:(NSString *)addressName withPhone:(NSString*)phone withPeople:(NSString *)name withFlag:(NSInteger)flag withRemarks:(NSString*)remarks{
    /*
     联系人
     */
    _addressID = addressID;
    _flag = flag;
    
    UILabel * peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40)];
    peopleLabel.text = @"   收货人";
    peopleLabel.textAlignment = NSTextAlignmentLeft;
    peopleLabel.backgroundColor = RGB(235, 235,235);
    peopleLabel.textColor = [UIColor blackColor];
    peopleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:peopleLabel];
    UIImageView * nameBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,peopleLabel.frame.size.height, SCREEN_WIDTH, 40)];
    nameBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameBackView];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,peopleLabel.frame.size.height, 100, 40)];
    nameLabel.text = @"姓名：";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:nameLabel];
    
    _nameTF =[[UITextField alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width-10,nameLabel.frame.origin.y, SCREEN_WIDTH-120, 40)];
    _nameTF.delegate = self;
    _nameTF.text = name;
    [_nameTF addTarget:self action:@selector(limitTextlength:) forControlEvents:UIControlEventEditingChanged];
    _nameTF.borderStyle = UITextBorderStyleNone;
    _nameTF.placeholder = @"请填写收货人的姓名";
    [self.view addSubview:_nameTF];
    
    UIImageView * phoneBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,nameLabel.frame.size.height+2+nameLabel.frame.origin.y, SCREEN_WIDTH, 40)];
    phoneBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneBackView];
    
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,phoneBackView.frame.origin.y, 100, 40)];
    phoneLabel.text = @"手机：";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor blackColor];
    phoneLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:phoneLabel];
    
    _phoneTF =[[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.frame.origin.x+phoneLabel.frame.size.width-10,phoneLabel.frame.origin.y,SCREEN_WIDTH-120, 40)];
    _phoneTF.delegate = self;
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTF addTarget:self action:@selector(limitTextlength:) forControlEvents:UIControlEventEditingChanged];
    _phoneTF.borderStyle = UITextBorderStyleNone;
    _phoneTF.text = phone;
    _phoneTF.placeholder = @"请填写收货人的电话号码";
    [self.view addSubview:_phoneTF];
    
    /*
     收货地址
     */
    UILabel * goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,phoneLabel.frame.origin.y+phoneLabel.frame.size.height+2, SCREEN_WIDTH, 40)];
    goodsLabel.text = @"   收货地址：";
    goodsLabel.textAlignment = NSTextAlignmentLeft;
    goodsLabel.backgroundColor = RGB(235, 235,235);
    goodsLabel.textColor = [UIColor blackColor];
    goodsLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:goodsLabel];
    
    UIImageView * goodsBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,goodsLabel.frame.size.height+2+goodsLabel.frame.origin.y, SCREEN_WIDTH, 40)];
    goodsBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:goodsBackView];
    
    UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,goodsBackView.frame.origin.y, 100, 40)];
    addressLabel.text = @"收货地址";
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:addressLabel];
    
    UIImageView * addressView = [[UIImageView alloc] initWithFrame:CGRectMake(addressLabel.frame.size.width+addressLabel.frame.origin.x,addressLabel.frame.origin.y+addressLabel.frame.size.height/2-14/2, 11, 14)];
    addressView.image = ImageNamed(@"icon_xzdz");
    [self.view addSubview:addressView];
    
    _addressTF = [[UITextField alloc] initWithFrame:CGRectMake(addressView.frame.size.width+addressView.frame.origin.x+5, addressView.frame.origin.y, 200, addressView.frame.size.height)];
    _addressTF.placeholder = @"请输入您的收货地址";
    _addressTF.text =  addressName;
    [self.view addSubview:_addressTF];
    
    UIImageView * areaBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0,addressLabel.frame.size.height+2+addressLabel.frame.origin.y, SCREEN_WIDTH, 70)];
    areaBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:areaBackView];
    
    
    UILabel * areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,areaBackView.frame.origin.y, 100, 40)];
    areaLabel.text = @"备注：";
    areaLabel.textAlignment = NSTextAlignmentCenter;
    areaLabel.backgroundColor = [UIColor clearColor];
    areaLabel.textColor = [UIColor blackColor];
    areaLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:areaLabel];
    
    _areaTF =[[UITextField alloc] initWithFrame:CGRectMake(areaLabel.frame.origin.x+2+areaLabel.frame.size.width,areaLabel.frame.origin.y,SCREEN_WIDTH-120, 40)];
    _areaTF.delegate =self;
    if ([FXTPublicTools isBlankString:remarks]==NO) {
        _areaTF.text = remarks;
    }
    _areaTF.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_areaTF];
    
    UIButton * setAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setAddressBtn.frame = CGRectMake(10, areaLabel.frame.origin.y+areaLabel.frame.size.height +8,20,20);
    [setAddressBtn setImage:ImageNamed(@"icon_dizhixuan") forState:UIControlStateSelected];
    [setAddressBtn setAdjustsImageWhenHighlighted:NO];
    [setAddressBtn setImage:ImageNamed(@"icon_dizhiweixuan") forState:UIControlStateNormal];
    [setAddressBtn addTarget:self action:@selector(selectNormal:) forControlEvents:UIControlEventTouchUpInside];
    if (flag == 0) {
        [setAddressBtn setSelected:YES];
    }else{
        [setAddressBtn setSelected:NO];
    }
    [self.view addSubview:setAddressBtn];
    
    
    UILabel * setAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(setAddressBtn.frame.size.width+setAddressBtn.frame.origin.x+5,setAddressBtn.frame.origin.y,200,20)];
    setAddressLabel.text = @"设置为默认收货地址";
    setAddressLabel.textAlignment = NSTextAlignmentLeft;
    setAddressLabel.backgroundColor = [UIColor clearColor];
    setAddressLabel.textColor = [UIColor blackColor];
    setAddressLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:setAddressLabel];
    
}

// 选择默认地址
-(void)selectNormal:(id)sender{
    UIButton * btn = (UIButton *)sender;
    if (btn.isSelected ==YES) {
        [btn setSelected:NO];
        _flag = 1 ;
    }else{
        [btn setSelected:YES];
        _flag = 0;
    }
}
// 点击保存按钮
-(void)saveTheseMessage:(id)sender
{
    // 保存
    if ([FXTPublicTools isBlankString:_nameTF.text]==YES) {
        [DisplayHelper displayWarningAlert:@"收货人不能为空" ];
    }else if ([FXTPublicTools isBlankString:_addressTF.text]==YES){
         [DisplayHelper displayWarningAlert:@"请输入收货地址"];
    }else{
        [self saveRequest];
    }
}
//保存请求
-(void)saveRequest
{
    
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    if ([self.title isEqualToString:@"新增收货地址"]) {
        requestModel.appendUrl = kAddress_RisenAddress;
    }else{
        requestModel.appendUrl = kAddress_AddressUpdate;
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_userModel.userid forKey:@"userid"];
    [paramDic setValue:_phoneTF.text forKey:@"cphe"];
    [paramDic setValue:_nameTF.text forKey:@"cname"];
    [paramDic setValue:_addressTF.text forKey:@"caddress"];
    [paramDic setValue:_areaTF.text forKey:@"remarks"];
    [paramDic setValue:_addressID forKey:@"address_id"];
    [paramDic setValue:[NSNumber numberWithInteger:_flag] forKey:@"flag"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            FAAddressModel * addressModel = [FAAddressModel dicWithAddress:result.data];
            [FAUserTools saveUserAddress:addressModel];
            [DisplayHelper displaySuccessAlert:@"保存成功"];
            [ws.navigationController popViewControllerAnimated:YES];
        }else{
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
        
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];

}
#pragma mark--
#pragma mark        UITextFildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
    [_areaTF resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -
#pragma mark 输入长度限制
- (void)limitTextlength:(UITextField *)textField
{
    if ([textField.text length]>12)
    {
        textField.text=[textField.text substringToIndex:11];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
