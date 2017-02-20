//
//  CMMeViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "FAMeViewController.h"
#import "FAPersonalView.h"
#import "FAAddressManagerViewController.h"
#import "FAPersonalCenterTableViewCell.h"
#import "FAHTMLBaseViewController.h"
#import "FAUserManagerViewController.h"
#import "FAAllOrderViewController.h"
#import "FAMyCollectionViewController.h"
#import "FALoginViewController.h"
#import "FASetupViewController.h"
#import "FABalanceViewController.h"
#import "FAIntegralViewController.h"
#import "FAWithdrawalsViewController.h"
#define  kDistance 155
#define  kCellTag  10
@interface FAMeViewController ()<UITableViewDataSource,UITableViewDelegate,FAPersonalViewDelegate>
{
    NSMutableArray * _kindsArray;
    NSMutableArray * _kindsImages;
    FAUserModel *  _userModel ;
}
@property (strong,nonatomic)UITableView * tableView;
@property(nonatomic,strong)FAPersonalView * personalView;
@end

@implementation FAMeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _userModel = [FAUserTools UserAccount];
    if (_userModel.userid == nil) {
        [self willLogin];
    }else{
        // 登录了才让请求
        if ([FAUserTools isAlreadyLogin]) {
            [self getUserInfo];
        }

        [self didLogin];
    }
}
//还没登录 进行登录
-(void)willLogin
{
    if (self.personalView) {
        [self.personalView removeFromSuperview];
    }

    self.personalView = [[FAPersonalView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDistance)];
    _personalView.delegate=self;
    _personalView.backgroundColor = RGBCOLOR(251, 58, 47);
    _personalView.phone = @"登录/注册";
    _personalView.photo = @"icon_wdtouxiang.png";
    [self.view addSubview:self.personalView];
    
}
//已经登陆
-(void)didLogin
{
    if (self.personalView) {
        [self.personalView removeFromSuperview];
    }
    self.personalView = [[FAPersonalView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kDistance)];
     _personalView.delegate=self;
    if ([FXTPublicTools isBlankString:_userModel.nickname]==NO) {
        _personalView.phone = _userModel.nickname;
    }else{
        _personalView.phone = _userModel.phone;
    }
    _personalView.backgroundColor = RGBCOLOR(251, 58, 47);
    _personalView.photo = _userModel.photo;
    [self.view addSubview:_personalView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // 去除黑线
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.view.backgroundColor = RGB(240, 240, 240);
    [self creatTableView];
    [self creatView];
    [self initData];
}
-(void)creatView{
    UIButton *  tempBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [tempBtn setAdjustsImageWhenHighlighted:NO];
    tempBtn.frame = CGRectMake(0, 0,20 *kAppScale, 20*kAppScale);
    [tempBtn setImage:ImageNamed(@"icon_shezhi") forState:UIControlStateNormal];
    [tempBtn addTarget:self action:@selector(setup) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithCustomView:tempBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
#pragma mark - Request
// 重新获取用户信息
-(void)getUserInfo{
    CMHttpRequestModel * requestModel = [[CMHttpRequestModel alloc] init];
    requestModel.appendUrl = kUsers_GetUserInfo;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [[DisplayHelper shareDisplayHelper] showLoading:self.view ];
    //用户id
    NSNumber *userIdStr = [FAUserTools getUserIdFrom];
    if (!userIdStr) {
        [[DisplayHelper shareDisplayHelper]hideLoading:self.view];
        return;
        
    }
    [paramDic setValue:userIdStr forKey:@"userid"];
    WS(ws);
    requestModel.paramDic = paramDic;
    requestModel.callback = ^(CMHttpResponseModel * result, NSError *error){
        if (result.state ==CMReponseCodeState_Success) {
            NSArray *array =(NSArray *)result.data;
            if (array.count) {
                NSDictionary *dictionary = array[0];
                // 解析并保存数据
                _userModel = [FAUserModel dicWithUserAccount:dictionary];
                [FAUserTools saveUserAccount:_userModel];
                [ws.tableView reloadData];
            }
        }else {
            [CMHttpStateTools showHtttpStateView:result.state];
            
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:requestModel];
}

-(void)initData{
    _kindsArray = [[NSMutableArray alloc] initWithObjects:@"全部订单",@"个人中心",@"我的收藏",@"收货地址",@"清空缓存",@"关于我们", nil];
    _kindsImages = [[NSMutableArray alloc] initWithObjects:@"icon_dingdan.png",@"icon_geren.png",@"icon_wdshoucang.png",@"icon_shouhuo.png",@"icon_guanyu.png",@"icon_qingchu.png", nil];
}
// 懒加载tableview
- (void)creatTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0,kDistance, SCREEN_WIDTH,SCREEN_HEIGHT-NavigationBar_BarHeight-kDistance-TabBar_HEIGHT) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBounces:NO];
    [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
    [_tableView setBackgroundColor:RGB(240, 240, 240)];
    //cell无数据时，不显示间隔线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:v];
    [self.view addSubview:self.tableView];
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
    FAPersonalCenterTableViewCell * personalCell = (FAPersonalCenterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    // 取消选中状态
    switch (personalCell.tag-kCellTag) {
        case 0:
        {
//            if (_userModel.userid ==nil) {
//                [self alertPersonView];
//            }else{
                FAAllOrderViewController * orderVC = [[FAAllOrderViewController alloc] init];
                orderVC.title = @"全部订单";
                [self.navigationController pushViewController:orderVC animated:YES];
//            }
        }
            break;
        case 1:
        {
            /*
             个人中心
             */
//            if (_userModel.userid ==nil) {
//                [self alertPersonView];
//            }else{
                FAUserManagerViewController * userManagerVC = [[FAUserManagerViewController alloc] init];
                userManagerVC.title = @"个人中心";
                [self.navigationController pushViewController:userManagerVC animated:YES];
//            }
        }
            break;
        case 2:
        {
//            if (_userModel.userid ==nil) {
//                [self alertPersonView];
//            }else{
                FAMyCollectionViewController * collectionVC = [[FAMyCollectionViewController alloc] init];
                collectionVC.title =  @"我的收藏";
                [self.navigationController pushViewController:collectionVC animated:YES];
//            }
        }
            break;
        case 3:
        {
            /*
             收货地址
             */
//            if (_userModel.userid ==nil) {
//                [self alertPersonView];
//            }else{
                FAAddressManagerViewController * addressVC = [[FAAddressManagerViewController alloc] init];
                addressVC.title = @"收货地址";
                [self.navigationController pushViewController:addressVC animated:YES];
//            }
        }
            break;
            
        case 4:
        {
            /*
             清空缓存
             */
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"是否清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self myClearCacheAction];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertView addAction:okAction];
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertView addAction:cancleAction];
            [self presentViewController:alertView animated:YES completion:nil];
            
        }
            break;
        case 5:
        {
            /*
             关于我们
             */
            FAHTMLBaseViewController * htmlVC = [[FAHTMLBaseViewController alloc] init];
            htmlVC.titleStr = @"关于我们";
            [htmlVC setUrl:@"http://app.xiudehao.net/guanyu.html"];
            [self.navigationController pushViewController:htmlVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(void)alertPersonView{
    FALoginViewController * loginVC = [[FALoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginVC.isChangePass = NO;
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeOnlyTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - －－－－－ButtonClick－－－－－
- (void)chooseCommodity:(NSInteger)tag
{
    switch (tag) {
        case 10:
        {
            /*
               余额
             */
            FABalanceViewController * balanceVC = [[FABalanceViewController alloc] init];
            balanceVC.title = @"余额";
            [self.navigationController pushViewController:balanceVC animated:YES];
        }
            break;
        case 11:
        {
            /*
             提现
             */
            FAWithdrawalsViewController * withdrawalsVC = [[FAWithdrawalsViewController alloc] init];
            withdrawalsVC.title = @"提现";
            [self.navigationController pushViewController:withdrawalsVC animated:YES];
        }
            break;
        case 12:
        {
            /*
             积分
             */
            FAIntegralViewController * integralVC = [[FAIntegralViewController alloc] init];
            integralVC.title = @"积分";
            [self.navigationController pushViewController:integralVC animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)setup{
    /*
     设置
     */
//    if (_userModel.userid == nil) {
//        [self alertPersonView];
//    }else{
        FASetupViewController * setupVC = [[FASetupViewController alloc] init];
        setupVC.title = @"设置";
        [self.navigationController pushViewController:setupVC animated:YES];
//    }
}

-(void)myClearCacheAction{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       // GCD 获取文件地址，文件里的数据个数
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"%@",cachPath);
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                           //                           NSString * cachePath =@"qwe";
                           CGFloat fileSize = [self folderSizeAtPath:cachPath];
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               NSString *sd  = [NSString stringWithFormat:@"%.2fMB",fileSize];
                               NSLog(@"%@",sd );
                               
                           });
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}


-(void)clearCacheSuccess
{
    [DisplayHelper displaySuccessAlert:@"清理成功"];
}

//获取缓存大小
- (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    //  获取缓存大小，
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    // NSEnumerator （枚举） NSEnumerator用来描述这种集合迭代运算的方式， 通过objectEnumerator向数组请求枚举器，如果想从后向前浏览集合，可使用reverseObjectEnumerator方法。
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    long long folderSize = 0;
    //在获得枚举器后，可以开始一个while循环，每次循环都向这个枚举器请求它的下一个对象:nextObject。nextObject返回nil值时，循环结束。
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    // 因为得到的数据时bate ，所以转换成mb
    return folderSize/(1024.0*1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
