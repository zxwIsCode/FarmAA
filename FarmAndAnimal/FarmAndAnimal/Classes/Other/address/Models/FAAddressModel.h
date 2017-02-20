//
//  FAAddressModel.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAAddressModel : NSObject
// 地址id
@property (nonatomic, copy) NSString *address_id;
// 地址名字
@property (nonatomic, copy) NSString *consignee_address;
// 收货人姓名
@property (nonatomic, copy) NSString * consignee_name;
// 收货人手机号
@property (nonatomic, copy) NSString *consignee_phe;
// 是否默认地址
@property (nonatomic, assign) NSInteger flag;
// 备注
@property (nonatomic, copy) NSString *remarks;
+(instancetype)dicWithAddress:(NSDictionary *)accountDic;
@end
