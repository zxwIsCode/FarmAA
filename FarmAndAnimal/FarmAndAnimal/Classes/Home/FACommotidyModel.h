//
//  FACommotidyModel.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/7.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAShoppingItemModel.h"
@interface FACommotidyModel : FAShoppingItemModel
// 分类ID
@property (nonatomic, copy) NSString *gcid;
// 分类名称
@property (nonatomic, copy) NSString *gcname;
// 商品分类ID
@property (nonatomic, copy) NSString *gid;
// 商品的名字
@property (nonatomic, copy) NSString *gname;
// 图文描述地址
@property (nonatomic, copy) NSString *godshtml;
// 商品的售价
@property (nonatomic, copy) NSString *gp;
// 商品缩略图
@property (nonatomic, copy) NSString *gpo;
// 商品赠送多少积分
@property (nonatomic, copy) NSString *intl;
// 最多可以使用的积分数额
@property (nonatomic, copy) NSString *intlpay;
// 是否可以使用积分支付 （0否1是）
@property (nonatomic, copy) NSString *isintpay;
//商品分类的父类id
@property (nonatomic, copy) NSString *pid;
// 销量
@property (nonatomic, copy) NSString *sales;
// 商品图片数组
@property (nonatomic ,copy) NSMutableArray * gc;
//规格数组
@property (nonatomic ,copy) NSMutableArray * sc;

+(instancetype)updatWithDic:(NSDictionary *)dataDic;
-(instancetype)initWithDic:(NSDictionary *)dataDic;
@end
