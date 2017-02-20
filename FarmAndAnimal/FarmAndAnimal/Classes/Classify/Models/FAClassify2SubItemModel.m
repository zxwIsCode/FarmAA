//
//  FAClassify2SubItemModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassify2SubItemModel.h"

@implementation FAClassify2SubItemModel
+(instancetype)updateFAClassifyAllItemModelWithDic:(NSDictionary *)dic {
    return [[self alloc]initFAClassifySmallItemModelWithDic:dic];
    
}

-(instancetype)initFAClassifySmallItemModelWithDic:(NSDictionary *)dic {
    
    if (self =[super init]) {
        self.smallGcid =dic[@"gcid"];
        self.smallGcname =dic[@"gcname"];
        self.smallLevel =dic[@"level"];
        self.smallPid =dic[@"pid"];
            
    }
    return self;
    
    
}
@end
