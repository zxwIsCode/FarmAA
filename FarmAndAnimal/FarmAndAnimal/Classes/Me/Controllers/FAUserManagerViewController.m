//
//  FAUserManagerViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/10.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAUserManagerViewController.h"
#import "GTMBase64.h"
#define kPhoto  20
#define kPicture 30
#define kNameTag  10000
#define kPhoneTag  20000
@interface FAUserManagerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    // 拍照
    UIImagePickerController *  _pickerPhoto;
    // 从相册里选
    UIImagePickerController *  _pickerPicture;
    NSData  * _imgData;
    NSString * _fullPath;
    FAUserModel * _userModel ;
}
@property (strong,nonatomic)UIImageView * headerImg;

@end

@implementation FAUserManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _userModel = [FAUserTools UserAccount];
    [self creatView];
    UIButton *  tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setAdjustsImageWhenHighlighted:NO];
    tempBtn.frame = CGRectMake(0, 0, 80, 44);
    tempBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0f];
    [tempBtn setTitle:@"保存" forState:UIControlStateNormal];
    [tempBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(saveMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
-(void)creatView{
    /*
     头像设置
     */
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, NavigationBar_HEIGHT)];
    headerView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerShow)];
    [headerView addGestureRecognizer:tapGestureRecognizer];
    [self.view addSubview:headerView];
    
    UILabel *  headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 100, headerView.frame.size.height)];
    headerLabel.text = @"头像";
    headerLabel.font = [UIFont systemFontOfSize:15.0];
    [headerView addSubview:headerLabel];
    
    self.headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-45,44/2-28/2, 28,28)];
    _headerImg.layer.masksToBounds = YES;
    _headerImg.layer.cornerRadius = 14.0f;
    if ([FXTPublicTools isBlankString:_userModel.photo]==NO) {
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:_userModel.photo] placeholderImage:ImageNamed(@"icon_grtouxiang")];
    }else{
        _headerImg.image = ImageNamed(@"icon_grtouxiang");
    }
    [headerView addSubview:self.headerImg];
    
    
    UIImageView * jianImg= [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerImg.frame)+5, headerView.frame.size.height/2-10/2, 4, 7)];
    jianImg.image = ImageNamed(@"wode_jiantou");
    [headerView addSubview:jianImg];

    
    UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height, SCREEN_WIDTH, 2)];
    lineImg.backgroundColor = RGB(235, 235,235);
    [self.view addSubview:lineImg];
    
    
    /*
     昵称设置
     */
    
    UIView * nameView = [[UIView alloc] initWithFrame:CGRectMake(0,lineImg.frame.origin.y+lineImg.frame.size.height, SCREEN_WIDTH, 44)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    
    UILabel *  nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 100, nameView.frame.size.height)];
    nameLabel.text = @"昵称";
    nameLabel.font = [UIFont systemFontOfSize:15.0];
    [nameView addSubview:nameLabel];
    
    UITextField * nameTF = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-200,0, 200, 44)];
    nameTF.tag = kNameTag;
    nameTF.borderStyle = UITextBorderStyleNone;
    nameTF.textAlignment = NSTextAlignmentRight;
    nameTF.textColor = RGB(175, 175, 175);
    nameTF.placeholder = @"请输入你的昵称";
    nameTF.font = [UIFont systemFontOfSize:15.0f];
    if ([FXTPublicTools isBlankString:_userModel.nickname]==NO) {
        nameTF.text = _userModel.nickname;
    }else{
        nameTF.text = _userModel.phone;
    }
    [nameView addSubview:nameTF];
    
    
    UIImageView * line1Img = [[UIImageView alloc] initWithFrame:CGRectMake(0,nameView.frame.size.height+nameView.frame.origin.y, SCREEN_WIDTH, 2)];
    line1Img.backgroundColor = RGB(235, 235,235);
    [self.view addSubview:line1Img];
    
    /*
     手机号修改
     */
    
    UIView * phoneView = [[UIView alloc] initWithFrame:CGRectMake(0,line1Img.frame.origin.y+line1Img.frame.size.height, SCREEN_WIDTH, 44)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneView];
    
    UILabel *  phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 100, phoneView.frame.size.height)];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = [UIFont systemFontOfSize:15.0];
    [phoneView addSubview:phoneLabel];
    
    UITextField * phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-200,0, 200, 44)];
    phoneTF.tag = kPhoneTag;
    phoneTF.borderStyle = UITextBorderStyleNone;
    phoneTF.textAlignment = NSTextAlignmentRight;
    phoneTF.textColor = RGB(175, 175, 175);
    phoneTF.placeholder = @"绑定手机号码";
    phoneTF.font = [UIFont systemFontOfSize:15.0f];
    phoneTF.text = _userModel.phone;
    [phoneView addSubview:phoneTF];
    
    
    UIImageView * line2Img = [[UIImageView alloc] initWithFrame:CGRectMake(0,phoneView.frame.size.height+phoneView.frame.origin.y, SCREEN_WIDTH, 2)];
    line2Img.backgroundColor = RGB(235, 235,235);
    [self.view addSubview:line2Img];
  }
-(void)headerShow
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //         相机选择
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        _pickerPhoto = [[UIImagePickerController alloc] init];//初始化
        _pickerPhoto.delegate = self;
        _pickerPhoto.allowsEditing = YES;//设置可编辑
        _pickerPhoto.sourceType = sourceType;
        [self presentViewController:_pickerPhoto animated:YES completion:nil];
    }];
    [alertView addAction:okAction];
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //从手机相册选择
        _pickerPicture=[[UIImagePickerController alloc]init];
        _pickerPicture.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        _pickerPicture.delegate = self;
        _pickerPicture.allowsEditing=YES;
        [self presentViewController:_pickerPicture animated:YES completion:^{
        }];
    }];
    [alertView addAction:pictureAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertView addAction:cancleAction];
    [self presentViewController:alertView animated:YES completion:nil];
}
-(void)saveMessage
{
    if (_imgData!=nil) {
        [self uploadHeaderImg];
    }
    [self uploadName];
}
-(void)uploadName{
    UITextField * nameTF = (UITextField *)[self.view viewWithTag:kNameTag];
    UITextField * phoneTF = (UITextField *)[self.view viewWithTag:kPhoneTag];
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kUsers_UpdateUserInfo;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_userModel.userid forKey:@"userid"];
    [paramDic setValue:nameTF.text forKey:@"username"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view noteText:@"上传中..."];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        [DisplayHelper displaySuccessAlert:result.alertMsg];
        if (result.state ==CMReponseCodeState_Success) {
            _userModel.phone = phoneTF.text;
            _userModel.nickname = nameTF.text;
            [FAUserTools saveUserAccount:_userModel];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
-(void)uploadHeaderImg{
    
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.type = CMHttpType_POST;
    requestModel.appendUrl = kUsers_UploadUserPhoto;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_userModel.userid forKey:@"userid"];
    [paramDic setValue:[GTMBase64 stringByEncodingData:_imgData] forKey:@"pho"];
    requestModel.paramDic = paramDic;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view noteText:@"上传中..."];
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        [DisplayHelper displaySuccessAlert:result.alertMsg];
        if (result.state ==CMReponseCodeState_Success) {
            _userModel.photo = [result.data objectForKey:@"uhead"];
            [FAUserTools saveUserAccount:_userModel];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    _imgData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [_imgData writeToFile:fullPath atomically:NO];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey: UIImagePickerControllerEditedImage];
    [self saveImage:image withName:@"currentImage.png"];
    _fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:_fullPath];
    [self.headerImg setImage:savedImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
