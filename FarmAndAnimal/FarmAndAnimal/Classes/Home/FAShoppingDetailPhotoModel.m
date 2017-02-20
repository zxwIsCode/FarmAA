//
//  FAShoppingDetailPhotoModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingDetailPhotoModel.h"

@implementation FAShoppingDetailPhotoModel

+(instancetype)updatShoppingDetailPhotoModelWithDic:(NSDictionary *)dataDic {
    return [[self alloc]initShoppingDetailPhotoModelWithDic:dataDic];
}
-(instancetype)initShoppingDetailPhotoModelWithDic:(NSDictionary *)dataDic {
    if (self =[super init]) {
        self.img =dataDic[@"img"];
    }
    return self;
}
@end
