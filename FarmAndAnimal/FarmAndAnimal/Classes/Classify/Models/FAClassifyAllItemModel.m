//
//  FAClassifyAllItemModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassifyAllItemModel.h"
#import "FAClassifySubAllItemModel.h"

@implementation FAClassifyAllItemModel



+(instancetype)updateFAClassifyAllItemModelWithDic:(NSDictionary *)dic {
    return [[self alloc]initFAClassifyBigItemModelItemModelWithDic:dic];

}


-(instancetype)initFAClassifyBigItemModelItemModelWithDic:(NSDictionary *)dic {
    if (self =[super init]) {
        self.bigGcid =dic[@"gcid"];
        self.bigGcname =dic[@"gcname"];
        self.bigLevel =dic[@"level"];
        self.bigPid =dic[@"pid"];
        id lowerID = dic[@"lower"];
        if ([lowerID isKindOfClass:[NSArray class]]) {
            NSArray *lowerArr =(NSArray *)lowerID;
            if (lowerArr.count) {
                for (NSDictionary *dic in lowerArr) {
                   FAClassifySubAllItemModel *middleItem  =[FAClassifySubAllItemModel updateFAClassifyAllItemModelWithDic:dic];
                    [self.middleArr addObject:middleItem];
                }
            }
        }


    
       
        
    }
    return self;

}


-(NSMutableArray *)middleArr {
    if (!_middleArr) {
        _middleArr =[NSMutableArray array];
    }
    return _middleArr;
}




@end
