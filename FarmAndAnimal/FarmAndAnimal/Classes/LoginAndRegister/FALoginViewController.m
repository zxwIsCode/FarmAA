//
//  FALoginViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FALoginViewController.h"
#import "FARegisterViewController.h"
#import "FAForgetViewController.h"
@interface FALoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginIn:(id)sender;
- (IBAction)forgetPassword:(id)sender;

@end

@implementation FALoginViewController

@synthesize isChangePass = _isChangePass;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    [self initNav];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 5.0f;
    
    _phoneTF.delegate = self;
    [_phoneTF addTarget:self action:@selector(limitTextlength:) forControlEvents:UIControlEventEditingChanged];
    _passwordTF.delegate = self;
    [_passwordTF addTarget:self action:@selector(limitTextlength:) forControlEvents:UIControlEventEditingChanged];
}
-(void)initNav{
    
    UIButton *  tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setAdjustsImageWhenHighlighted:NO];
    tempBtn.frame = CGRectMake(0, 0, 80, 44);
    tempBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
    [tempBtn setTitle:@"注册" forState:UIControlStateNormal];
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(registerUsers) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton * xBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    xBtn.frame = CGRectMake(0,0,14,14);
    [xBtn setImage:ImageNamed(@"denglu") forState:UIControlStateNormal];
    [xBtn addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithCustomView:xBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
-(void)loginRequest{
    
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kLogin_AppLogin;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneTF.text forKey:@"phe"];
    [paramDic setValue:_passwordTF.text forKey:@"pwd"];
    requestModel.paramDic = paramDic;
    
    WS(ws);
    
    [[DisplayHelper shareDisplayHelper]showLoading:self.view noteText:@"登录中..."];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            [DisplayHelper displaySuccessAlert:result.alertMsg];
            NSDictionary * dic =[result.data objectForKey:@"userinfo"];
            FAUserModel * userModel = [FAUserModel dicWithUserAccount:dic];
            [FAUserTools saveUserAccount:userModel];
            [self down];
        }else{
            [DisplayHelper displayWarningAlert:result.alertMsg];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
//注册
-(void)registerUsers{
    FARegisterViewController * registerVC = [[FARegisterViewController alloc] init];
    registerVC.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)loginIn:(id)sender {
    if ([FXTPublicTools isBlankString:_phoneTF.text]==YES) {
        [DisplayHelper displayWarningAlert:@"请输入手机号"];
    }else if ([FXTPublicTools isBlankString:_passwordTF.text]==YES){
        [DisplayHelper displayWarningAlert:@"请输入密码"];
    }else{
        [self loginRequest];
    }
}
- (IBAction)forgetPassword:(id)sender {
    //忘记密码
    FAForgetViewController * forgetVC = [[FAForgetViewController alloc] init];
    forgetVC.title = @"找回密码";
    [self.navigationController pushViewController:forgetVC animated:YES];
}
-(void)down{
    if (_isChangePass ==YES) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark--
#pragma mark        UITextFildDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_phoneTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    return YES;
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
