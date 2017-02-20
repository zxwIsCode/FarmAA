//
//  FARegisterViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FARegisterViewController.h"
#import "FAHTMLBaseViewController.h"
#define  kTenTag 10
#define  kEleven 11
#define  kTwelve 12
@interface FARegisterViewController ()<UITextFieldDelegate>
{
    NSTimer * _timer ;
    NSInteger  _secondsCountDown;
}
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
/*
 支付密码
 */
@property (weak, nonatomic) IBOutlet UITextField *payPsdTF;
- (IBAction)registerBtn:(id)sender;
- (IBAction)enterAdvisment:(id)sender;
- (IBAction)getCode:(id)sender;


@end

@implementation FARegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
     title
     注册
     找回密码
     */
    [self initControl];
}
-(void)initControl{
    _phoneTF.delegate =self;
    _passwordTF.delegate = self;
    _payPsdTF.delegate = self;
    _codeTF.delegate = self;
    [_payPsdTF addTarget:self action:@selector(paylimitTextlength:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTF addTarget:self action:@selector(limitTextlength:) forControlEvents:UIControlEventEditingChanged];
    [_codeTF addTarget:self action:@selector(codeLimitTextlength:) forControlEvents:UIControlEventEditingChanged];
    [_codeBtn setUserInteractionEnabled:NO];
    _codeBtn.layer.cornerRadius = 2.0f;
    _codeBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 2.0f;
    _nextBtn.layer.masksToBounds = YES;
    [_nextBtn setUserInteractionEnabled:NO];
    [_nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    
}
- (IBAction)registerBtn:(id)sender {
    if ([FXTPublicTools isBlankString:_phoneTF.text]==YES) {
        [DisplayHelper displayWarningAlert:@"请输入手机号"];
    }else if ([FXTPublicTools isBlankString:_passwordTF.text]==YES){
        [DisplayHelper displayWarningAlert:@"请输入密码"];
    }else if ([FXTPublicTools isBlankString:_payPsdTF.text]==YES){
        [DisplayHelper displayWarningAlert:@"请输入您的支付密码"];
    }else{
        [self registerRequest];
    }
}
-(void)registerRequest{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kLogin_AppRegister;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneTF.text forKey:@"phe"];
    [paramDic setValue:_passwordTF.text forKey:@"pwd"];
    [paramDic setValue:_codeTF.text forKey:@"code"];
    [paramDic setValue:_payPsdTF.text forKey:@"paypwd"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            [DisplayHelper displaySuccessAlert:result.alertMsg];
        }else{
            [DisplayHelper displayWarningAlert:result.alertMsg];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
- (IBAction)enterAdvisment:(id)sender {
    //用户协议
    FAHTMLBaseViewController * htmlVC =[[FAHTMLBaseViewController alloc] init];
    htmlVC.titleStr = @"用户协议";
    [htmlVC setUrl:@"http://app.xiudehao.net/xieyi.html"];
    [self.navigationController pushViewController:htmlVC animated:YES];
}
#pragma mark -
#pragma mark    获取验证码改变顶上的数字
-(void)getCaptcha{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kLogin_RegisterPhoneCode;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneTF.text forKey:@"phe"];

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
        [DisplayHelper displayWarningAlert:@"请输入您的手机号"];
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
    [_payPsdTF resignFirstResponder];
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

-(void)paylimitTextlength:(UITextField *)textField{
    if ([textField.text length]>6)
    {
        textField.text=[textField.text substringToIndex:6];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
