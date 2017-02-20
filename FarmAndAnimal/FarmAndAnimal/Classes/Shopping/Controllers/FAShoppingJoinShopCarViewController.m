//
//  FAShoppingJoinShopCarViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingJoinShopCarViewController.h"
#import "FAShopingItemFormatModel.h"

@interface FAShoppingJoinShopCarViewController ()

@end

@implementation FAShoppingJoinShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DDLog(@"commotidyModel = %@",self.commotidyModel);

    
}

-(void)settingBtnTitle {
    
    [self.buyNowBtn setTitle:@"加入购物车" forState:UIControlStateNormal];

}

-(void)buyNowBtnClick:(UIButton *)btn {
    DDLog(@"点击了加入购物车");
    
    CMHttpRequestModel *paramsModel =[[CMHttpRequestModel alloc]init];
    paramsModel.appendUrl =kCart_JoinCart;
    
    // 包装参数设置
    WS(ws);
    [paramsModel.paramDic setObject:@"1" forKey:@"userid"];
    [paramsModel.paramDic setObject:self.commotidyModel.gid forKey:@"gid"];
    [paramsModel.paramDic setObject:self.countLable.text forKey:@"gnum"];
    if (self.commotidyModel.goodsFormatCount <self.commotidyModel.sc.count) {
        FAShopingItemFormatModel *itemFormatMdoel =self.commotidyModel.sc[self.commotidyModel.goodsFormatCount];
        [paramsModel.paramDic setObject:itemFormatMdoel.gsid forKey:@"spid"];

    }
   
    
    paramsModel.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result) {
            if (result.state == CMReponseCodeState_Success) {// 成功,做自己的逻辑
                DDLog(@"%@",result.data);
                if (result.alertMsg) {
                    [DisplayHelper displaySuccessAlert:result.alertMsg];
                }else {
                    [DisplayHelper displaySuccessAlert:@"加入购物车成功哦！"];
                }
                NSArray *infoArr =(NSArray *)result.data;
            
                
                
            }else {// 失败,弹框提示
                
                DDLog(@"%@",result.error);
                if (result.alertMsg) {
                    [DisplayHelper displayWarningAlert:result.alertMsg];
                    
                }else {
                    [DisplayHelper displayWarningAlert:@"请求成功,但没有数据哦!"];
                }
            }
        }else {
            
            [DisplayHelper displayWarningAlert:@"网络异常，请稍后再试!"];
            
        }
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:paramsModel];

    
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
