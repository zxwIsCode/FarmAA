//
//  FAShoppingDetailPhotoModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAShoppingDetailPhotoModel : NSObject

@property(nonatomic,copy)NSString *img;

+(instancetype)updatShoppingDetailPhotoModelWithDic:(NSDictionary *)dataDic;
-(instancetype)initShoppingDetailPhotoModelWithDic:(NSDictionary *)dataDic;

@end
