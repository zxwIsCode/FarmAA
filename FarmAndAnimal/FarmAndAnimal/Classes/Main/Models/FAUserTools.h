//
//  FAUserTools.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAUserModel.h"
#import "FAAddressModel.h"
@interface FAUserTools : NSObject
// 保存用户登录数据
+(void)saveUserAccount:(FAUserModel *)account;
// 取得用户登录数据
+(FAUserModel *)UserAccount;
// 保存用户收货地址数据
+(void)saveUserAddress:(FAAddressModel*)address;
// 取得用户收货地址数据
+(FAAddressModel *)UserAddress;
//删除用户收货地址数据
+(void)removeAllAddressDatas;
// 是否登录过
+(BOOL)isAlreadyLogin;

// 清除所有的登录数据和用户自身的数据
+(void)removeAllWechatAndUserDatas;

// 根据是否登录反馈userI的的参数
+(NSNumber *)getUserIdFrom ;

@end
