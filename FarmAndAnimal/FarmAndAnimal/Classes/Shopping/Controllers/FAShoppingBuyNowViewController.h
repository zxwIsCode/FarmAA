//
//  FAShoppingBuyNowViewController.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//  购物车立即购买详情界面

#import "CMBaseViewController.h"

#import "FAShoppingItemModel.h"
#import "FAShoppingCommonView.h"

#import "FACommotidyModel.h"


@interface FAShoppingBuyNowViewController : CMBaseViewController

// 子类继承实现
@property(nonatomic,strong)UIButton *buyNowBtn;

//@property(nonatomic,strong)FAShoppingItemModel *goodsItem;

@property (strong,nonatomic)FACommotidyModel * commotidyModel ;


@property(nonatomic,strong)FAShoppingCommonView *commonView;


@property(nonatomic,strong)UILabel *countLable;

@property(nonatomic,strong)UIButton *subBtn;

@property(nonatomic,strong)UIButton *addBtn;

@property(nonatomic,strong)UIButton *tempBtn;

// 给子类实现修改
-(void)settingBtnTitle;

@end
