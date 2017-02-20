//
//  FAClassify2SubItemModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassifyAllItemModel.h"

@interface FAClassify2SubItemModel : FAClassifyAllItemModel

// 当前分类id
@property(nonatomic,copy)NSString *smallGcid;
// 当前分类的名称
@property(nonatomic,copy)NSString *smallGcname;
// 当前分类的等级
@property(nonatomic,copy)NSString *smallLevel;
// 当前分类的父类id
@property(nonatomic,copy)NSString *smallPid;

+(instancetype)updateFAClassifyAllItemModelWithDic:(NSDictionary *)dic;
@end
