//
//  FAShoppingItemModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingItemModel.h"

@implementation FAShoppingItemModel

+(instancetype)updateShoppingItemModelWithDic:(NSDictionary *)dic {
    return [[self alloc]initShoppingItemModelWithDic:dic];
}

-(instancetype)initShoppingItemModelWithDic:(NSDictionary *)dic {
    if (self =[super init]) {
//        self.detailStr =@"猪饲料详情item为";
    }
    return self;
}
@end
