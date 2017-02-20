//
//  FACommotidyModel.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/7.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FACommotidyModel.h"
#import "FAShopingItemFormatModel.h"
#import "FAShoppingDetailPhotoModel.h"
@implementation FACommotidyModel
//@synthesize gcid,gc,gcname,gname,gp,gid,gpo,godshtml,intl,intlpay,isintpay,pid,sales,sc;
+(instancetype)updatWithDic:(NSDictionary *)dataDic {
    return [[self alloc]initWithDic:dataDic];
}

-(instancetype)initWithDic:(NSDictionary *)dataDic {
    if (self =[super init]) {
#warning 假数据开始
        self.gcid = dataDic[@"gcid"];
        self.godshtml = dataDic[@"godshtml"];
        self.gpo = @"icon_dddianpu";
        self.gcname = dataDic[@"gcname"];
        self.gname = @"老张大盘鸡";
        self.gp = @"99";
        self.gid = dataDic[@"gid"];
        self.intl = dataDic[@"intl"];
        self.intlpay =dataDic[@"intlpay"];
        self.isintpay = dataDic[@"isintpay"];
        self.pid = dataDic[@"pid"];
        self.sales = @"120";
        
        
        
        for (int index =0; index <3; index ++) {
            FAShopingItemFormatModel *itemFormatModel =[FAShopingItemFormatModel updatShopingItemFormatModelWithDic:nil];
            [self.sc addObject:itemFormatModel];

        }
        
        NSArray *scArr =dataDic[@"sc"];
        for (NSDictionary *scDic in scArr) {
            FAShopingItemFormatModel *itemFormatModel =[FAShopingItemFormatModel updatShopingItemFormatModelWithDic:scDic];
            [self.sc addObject:itemFormatModel];
        }
        
        
#warning 假数据结束
//        self.gcid = dataDic[@"gcid"];
//        self.godshtml = dataDic[@"godshtml"];
//        self.gpo = dataDic[@"gpo"];
//        self.gcname = dataDic[@"gcname"];
//        self.gname = dataDic[@"gname"];
//        self.gp = dataDic[@"gp"];
//        self.gid = dataDic[@"gid"];
//        self.intl = dataDic[@"intl"];
//        self.intlpay =dataDic[@"intlpay"];
//        self.isintpay = dataDic[@"isintpay"];
//        self.pid = dataDic[@"pid"];
//        self.sales = dataDic[@"sales"];
//        
//        NSArray *gcArr =dataDic[@"gc"];
//        for (NSDictionary *gcDic in gcArr) {
//            FAShoppingDetailPhotoModel *itemFormatModel =[FAShoppingDetailPhotoModel updatShoppingDetailPhotoModelWithDic:gcDic];
//            [self.gc addObject:itemFormatModel];
//        }
//        
//        NSArray *scArr =dataDic[@"sc"];
//        for (NSDictionary *scDic in scArr) {
//            FAShopingItemFormatModel *itemFormatModel =[FAShopingItemFormatModel updatShopingItemFormatModelWithDic:scDic];
//            [self.sc addObject:itemFormatModel];
//        }


        
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(NSMutableArray *)gc {
    if (!_gc) {
        _gc =[NSMutableArray array];
    }
    return _gc;
}
-(NSMutableArray *)sc {
    if (!_sc) {
        _sc =[NSMutableArray array];
    }
    return _sc;
}


@end
