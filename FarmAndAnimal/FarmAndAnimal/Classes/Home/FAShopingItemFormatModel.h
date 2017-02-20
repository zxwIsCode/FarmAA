//
//  FAShopingItemFormatModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//  item修改参数的规格Model（购物车用）

#import <Foundation/Foundation.h>

@interface FAShopingItemFormatModel : NSObject

// 库存
@property(nonatomic,copy)NSString *gstock;

@property(nonatomic,copy)NSString *gprice;

@property(nonatomic,copy)NSString *gsid;

@property(nonatomic,copy)NSString *gsdesc;
+(instancetype)updatShopingItemFormatModelWithDic:(NSDictionary *)dataDic;
-(instancetype)initShopingItemFormatModelWithDic:(NSDictionary *)dataDic;

@end
