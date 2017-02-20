//
//  FAShopingFirmOrderViewController.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//  购物车里面的确认订单界面（包含立即购买的订单情况）

#import "CMBaseViewController.h"
#import "FAShoppingItemModel.h"

#import "FAAddressModel.h"


typedef NS_ENUM(NSInteger, FAShoppingKind) {
    FAShoppingKindMore =0,      //购物车中确认订单
    FAShoppingKindSingle =1        //立即购买中确认订单
};

@interface FAShopingFirmOrderViewController : CMBaseViewController

// 所有的数据源
@property(nonatomic,strong)NSMutableArray *allDataSource;

@property(nonatomic,strong)FAShoppingItemModel *itemModel;

@property(nonatomic,assign)FAShoppingKind shoppingKind;

@property(nonatomic,strong)FAAddressModel *addressModel;

@end
