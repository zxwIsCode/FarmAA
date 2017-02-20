//
//  FAShoppingSectionModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingSectionModel.h"
#import "FAShoppingItemModel.h"
#import "FACommotidyModel.h"

@implementation FAShoppingSectionModel

+(instancetype)updateShoppingSectionModelWithDic:(NSDictionary *)dic {
    return [[self alloc]initShoppingSectionModelWithDic:dic];
}

-(instancetype)initShoppingSectionModelWithDic:(NSDictionary *)dic {
    if (self =[super init]) {
#warning 假数据开始
        self.seller = @"中华小当家";
        self.sellerid = @"100";
        // 某个商家的所有商品
        for (int index =0; index <4; index ++) {
            FACommotidyModel *item =[FACommotidyModel updatWithDic:nil];
            [self.allItemArray addObject:item];
        }
       
#warning 假数据结束

//        self.seller = dic[@"seller"];
//        self.sellerid = dic[@"sellerid"];
//        NSArray *goodsArr =dic[@"cart"];
//        
//        // 某个商家的所有商品
//        for (NSDictionary *goodsDic in goodsArr) {
//            FACommotidyModel *item =[FACommotidyModel updatWithDic:goodsDic];
//            [self.allItemArray addObject:item];
//        }

        // 假数据
        self.sellerMessage =@"尽快发货，听到没!";
        self.goodsCount =@"12";
        self.totolMoney =@"$999";
        

        
    }
    return self;
}

-(NSMutableArray *)allItemArray {
    if (!_allItemArray) {
        _allItemArray = [NSMutableArray array];
    }
    return _allItemArray;
}

@end
