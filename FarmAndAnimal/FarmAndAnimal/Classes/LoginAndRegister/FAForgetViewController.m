//
//  FAForgetViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAForgetViewController.h"
#define  kTenTag 10
#define  kEleven 11
#define  kTwelve 12
@interface FAForgetViewController ()<UITextFieldDelegate>
{
    NSTimer * _timer ;
    FAUserModel * _userModel;
    NSInteger  _secondsCountDown;
}
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *morePsdTF;
- (IBAction)commitBtn:(id)sender;
- (IBAction)getCode:(id)sender;

@end

@implementation FAForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initControl];
}
-(void)initControl{
    _userModel = [FAUserTools UserAccount];
    _passwordTF.delegate = self;
    _morePsdTF.delegate = self;
    _codeTF.delegate = self;
    if ([self.title isEqualToString:@"找回密码"]) {
    _phoneTF.delegate =self;
    _phoneTF.userInteractionEnabled = YES;
    [_phoneTF addTarget:self action:@selector(limitTextlength:) forControlEvents:UIControlEventEditingChanged];
    }else{
    _phoneTF.text = _userModel.phone;
    _phoneTF.userInteractionEnabled =NO;
    }
    [_codeTF addTarget:self action:@selector(codeLimitTextlength:) forControlEvents:UIControlEventEditingChanged];
    [_codeBtn setUserInteractionEnabled:NO];
    _codeBtn.layer.cornerRadius = 2.0f;
    _codeBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 2.0f;
    _nextBtn.layer.masksToBounds = YES;
    [_nextBtn setUserInteractionEnabled:NO];
    [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    
}
- (IBAction)commitBtn:(id)sender {
    if ([FXTPublicTools isBlankString:_phoneTF.text]==YES) {
        [DisplayHelper displayWarningAlert:@"请输入手机号"];
    }else if ([FXTPublicTools isBlankString:_passwordTF.text]==YES){
        [DisplayHelper displayWarningAlert:@"请输入密码" ];
    }else if ([_passwordTF.text isEqualToString:_morePsdTF.text]==NO){
        [DisplayHelper displayWarningAlert:@"两次密码输入不一致"];
    }else{
        [self registerRequest];
    }
}
-(void)registerRequest{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneTF.text forKey:@"phe"];
    if ([self.title isEqualToString:@"找回密码"]) {
     requestModel.appendUrl = kLogin_FindUserPassword;
        [paramDic setValue:_passwordTF.text forKey:@"pwd"];
        [paramDic setValue:_morePsdTF.text forKey:@"ppwd"];
    }else{
        if ([self.title isEqualToString:@"修改登录密码"]){
        requestModel.appendUrl = kUsers_UpdateUserPas;
        [paramDic setValue:_passwordTF.text forKey:@"cpwd"];
        [paramDic setValue:_morePsdTF.text forKey:@"pwd"];
    }else{
        requestModel.appendUrl = kUsers_UpdateUserPayPas;
        [paramDic setValue:_morePsdTF.text forKey:@"paypwd"];
        [paramDic setValue:_passwordTF.text forKey:@"paypwds"];
        
    }
        [paramDic setValue:_userModel.userid forKey:@"userid"];
}
       [paramDic setValue:_codeTF.text forKey:@"code"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            [DisplayHelper displaySuccessAlert:result.alertMsg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [DisplayHelper displayWarningAlert:result.alertMsg];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}

#pragma mark -
#pragma mark    获取验证码改变顶上的数字
-(void)getCaptcha{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    requestModel.appendUrl = kLogin_RegisterPhoneCode;
    [paramDic setValue:@"1" forKey:@"state"];
    [paramDic setValue:_phoneTF.text forKey:@"user_phe"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            [DisplayHelper displaySuccessAlert:result.alertMsg];
        }else{
            [DisplayHelper displayWarningAlert:result.alertMsg];
            [_codeBtn setTitle: [NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
            _codeBtn.userInteractionEnabled = YES;
            [_timer invalidate];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
#pragma mark - 获取验证码按钮点击事件

- (IBAction)getCode:(id)sender {
    if ([FXTPublicTools isBlankString:_phoneTF.text]==YES) {
       [DisplayHelper displayWarningAlert:@"请输入手机号"];
    }else{
        UIButton * btn  = (UIButton*)sender;
        
        [self getCaptcha];
        btn.userInteractionEnabled= NO;
        _secondsCountDown = 60;
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeNumber) userInfo:nil repeats:YES];
    }
}
// 改变数字  计时
- (void)changeNumber
{
    _secondsCountDown --;
    [_codeBtn setTitle: [NSString stringWithFormat:@"%lds",(long)_secondsCountDown] forState:UIControlStateNormal];
    if (_secondsCountDown == 0) {
        [_codeBtn setTitle: [NSString stringWithFormat:@"重新获取"] forState:UIControlStateNormal];
        _codeBtn.userInteractionEnabled = YES;
        [_timer invalidate];
    }
}
#pragma mark--
#pragma mark           UITextFildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_phoneTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_morePsdTF resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -
#pragma mark 手机号码输入长度限制
- (void)limitTextlength:(UITextField *)textField
{
    if ([textField.text length]>10)
    {
        textField.text=[textField.text substringToIndex:11];
        [_codeBtn setUserInteractionEnabled:YES];
        
        if ([_codeTF.text length]>3)
        {
            [_nextBtn setUserInteractionEnabled:YES];
            [_nextBtn setBackgroundColor:RGB(35,130,235)];
            
        }
    } else {
        [_codeBtn setUserInteractionEnabled:NO];
        [_nextBtn setUserInteractionEnabled:NO];
        [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}
#pragma mark 验证码输入长度判断
- (void)codeLimitTextlength:(UITextField *)textField
{
    if ([textField.text length]>3)
    {
        if ([_phoneTF.text length] > 10) {
            [_nextBtn setUserInteractionEnabled:YES];
            [_nextBtn setBackgroundColor:RGB(35,130,235)];
        }
        
    } else {
        [_nextBtn setUserInteractionEnabled:NO];
        [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
