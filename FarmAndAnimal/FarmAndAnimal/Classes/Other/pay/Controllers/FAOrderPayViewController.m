//
//  FAOrderPayViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAOrderPayViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface FAOrderPayViewController ()
{
    NSInteger  _commotidyBuyNum;
    CMUserDefaults * _userModel;
    NSInteger _payChoose;
}

@end

@implementation FAOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.、
    self.navigationItem.title = @"订单支付";
    _commotidyBuyNum = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
