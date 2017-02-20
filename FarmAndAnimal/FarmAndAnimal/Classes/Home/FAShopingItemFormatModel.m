//
//  FAShopingItemFormatModel.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShopingItemFormatModel.h"

@implementation FAShopingItemFormatModel

+(instancetype)updatShopingItemFormatModelWithDic:(NSDictionary *)dataDic {
    return [[self alloc]initShopingItemFormatModelWithDic:dataDic];
}
-(instancetype)initShopingItemFormatModelWithDic:(NSDictionary *)dataDic {
    if (self =[super init]) {
#warning 假数据开始
        self.gstock =@"2万";
        self.gprice =@"166";
        self.gsid =@"19";
        self.gsdesc =@"红色";
#warning 假数据结束
//        self.gstock =dataDic[@"gstock"];
//        self.gprice =dataDic[@"gprice"];
//        self.gsid =dataDic[@"gsid"];
//        self.gsdesc =dataDic[@"gsdesc"];

    }
    return self;
}
@end
