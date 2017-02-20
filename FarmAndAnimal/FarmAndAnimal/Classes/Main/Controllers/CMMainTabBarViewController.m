//
//  CMMainTabBarViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMMainTabBarViewController.h"
#import "CMNavViewController.h"
#import "FAHomeViewController.h"
#import "FAClassifyViewController.h"
#import "FAShoppingViewController.h"
#include "FAMeViewController.h"

#import "CMCustomTabBar.h"

@interface CMMainTabBarViewController ()<CMCustomTabBarDelegate>

@property(nonatomic,strong)FAHomeViewController *homeVC;

@property(nonatomic,strong)FAClassifyViewController *classifyVC;

@property(nonatomic,strong)FAShoppingViewController *shoppingVC;

@property(nonatomic,strong)FAMeViewController *meVC;

@property(nonatomic,strong)CMCustomTabBar *customTabBar;

@end

@implementation CMMainTabBarViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setupCustomTabBar];
    
    [self setupAllChildViewControllers];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark - Private Methods


-(void)setupCustomTabBar {
    CMCustomTabBar *customTabBar =[[CMCustomTabBar alloc]init];
    CGFloat tabBarHeight =TabBar_HEIGHT;
    customTabBar.frame =CGRectMake(0, 49.0 -tabBarHeight, SCREEN_WIDTH, tabBarHeight);
    [self.tabBar addSubview:customTabBar];
    self.customTabBar =customTabBar;
    self.customTabBar.delegate =self;
    self.customTabBar.backgroundColor =[UIColor blueColor];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    [self setupChildViewController:self.homeVC title:@"首页" imageName:@"icon_shouye" selectedImageName:@"icon_shouyebian" andIndex:0];
    
    // 2.分类
    [self setupChildViewController:self.classifyVC title:@"分类" imageName:@"icon_renwu" selectedImageName:@"icon_fenlei" andIndex:1];
    
    // 3.购物车
    [self setupChildViewController:self.shoppingVC title:@"购物车" imageName:@"icon_erweima" selectedImageName:@"icon_gouwu" andIndex:2];
    
    // 4.用户信息
    [self setupChildViewController:self.meVC title:@"我的" imageName:@"icon_yonghu" selectedImageName:@"icon_wode" andIndex:3];
    
}

/**
 *  初始化一个子控制器
 
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName andIndex:(NSInteger)index
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    CMNavViewController *nav = [[CMNavViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 自定义TabBar的SubViews
    [self.customTabBar creatAllTabBarSubViews:childVc.tabBarItem andIndex:index];
    
    
}
#pragma mark - CMCustomTabBarDelegate

-(void)tabBar:(CMCustomTabBar *)tabBar didSelectVC:(NSInteger)lastIndex andNext:(NSInteger)nextIndex {
    self.selectedIndex =nextIndex -kTabBarButtonBaseTag;
}

#pragma mark - Setter & Getter
-(FAHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC =[[FAHomeViewController alloc]init];
    }
    return _homeVC;
}
-(FAClassifyViewController *)classifyVC {
    if (!_classifyVC) {
        _classifyVC =[[FAClassifyViewController alloc]init];
    }
    return _classifyVC;
}
-(FAShoppingViewController *)shoppingVC {
    if (!_shoppingVC) {
        _shoppingVC =[[FAShoppingViewController alloc]init];
    }
    return _shoppingVC;
}
-(FAMeViewController *)meVC {
    if (!_meVC) {
        _meVC =[[FAMeViewController alloc]init];
    }
    return _meVC;
}


@end
