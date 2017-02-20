//
//  FAClassifySubAllItemModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassifyAllItemModel.h"

@interface FAClassifySubAllItemModel : FAClassifyAllItemModel

// 当前分类id
@property(nonatomic,copy)NSString *middleGcid;
// 当前分类的名称
@property(nonatomic,copy)NSString *middleGcname;
// 当前分类的等级
@property(nonatomic,copy)NSString *middleLevel;
// 当前分类的父类id
@property(nonatomic,copy)NSString *middlePid;

@property(nonatomic,strong)NSMutableArray *smallArr;


+(instancetype)updateFAClassifyAllItemModelWithDic:(NSDictionary *)dic;
@end
