//
//  FAClassifySubAllItemModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassifySubAllItemModel.h"
#import "FAClassify2SubItemModel.h"

@implementation FAClassifySubAllItemModel

+(instancetype)updateFAClassifyAllItemModelWithDic:(NSDictionary *)dic {
    return [[self alloc]initFAClassifyMiddleItemModelItemModelWithDic:dic];
    
}

-(instancetype)initFAClassifyMiddleItemModelItemModelWithDic:(NSDictionary *)dic {
    if (self =[super init]) {
        self.middleGcid =dic[@"gcid"];
        self.middleGcname =dic[@"gcname"];
        self.middleLevel =dic[@"level"];
        self.middlePid =dic[@"pid"];
        id lowerID = dic[@"lower"];
        if ([lowerID isKindOfClass:[NSArray class]]) {
            NSArray *lowerArr =(NSArray *)lowerID;
            if (lowerArr.count) {
                for (NSDictionary *dic in lowerArr) {
                    FAClassify2SubItemModel *smallItem =[FAClassify2SubItemModel updateFAClassifyAllItemModelWithDic:dic];
                    [self.smallArr addObject:smallItem];
                    
                }
            }
        }
        
        
    }
    return self;
    
    
}

-(NSMutableArray *)smallArr {
    if (!_smallArr) {
        _smallArr =[NSMutableArray array];
    }
    return _smallArr;
}


@end
