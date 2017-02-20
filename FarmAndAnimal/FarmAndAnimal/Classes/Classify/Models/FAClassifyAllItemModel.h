//
//  FAClassifyAllItemModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAClassifyAllItemModel : NSObject

// 当前分类id
@property(nonatomic,copy)NSString *bigGcid;
// 当前分类的名称
@property(nonatomic,copy)NSString *bigGcname;
// 当前分类的等级
@property(nonatomic,copy)NSString *bigLevel;
// 当前分类的父类id
@property(nonatomic,copy)NSString *bigPid;



@property(nonatomic,strong)NSMutableArray *middleArr;

+(instancetype)updateFAClassifyAllItemModelWithDic:(NSDictionary *)dic;

-(instancetype)initFAClassifyBigItemModelItemModelWithDic:(NSDictionary *)dic;



@end
