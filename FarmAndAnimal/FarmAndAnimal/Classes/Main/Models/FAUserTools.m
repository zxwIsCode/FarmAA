//
//  FAUserTools.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAUserTools.h"
#define userAccountPath @"userAccout.data"
#define userAddressPath @"userAddress.data"
@implementation FAUserTools
#pragma mark - 用户登录数据处理有关

// 保存用户登录数据
+(void)saveUserAccount:(FAUserModel*)account {
    NSString *userAccountFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userAccountPath];
    [NSKeyedArchiver archiveRootObject:account toFile:userAccountFile];
}
// 取得用户登录数据
+(FAUserModel *)UserAccount {
    NSString *userAccountFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userAccountPath];
    
    FAUserModel *userAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:userAccountFile];
    return userAccount;
}


// 保存用户收货地址数据
+(void)saveUserAddress:(FAAddressModel*)address {
    NSString *userAddressFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userAddressPath];
    [NSKeyedArchiver archiveRootObject:address toFile:userAddressFile];
}
// 取得用户收货地址数据
+(FAAddressModel *)UserAddress {
    NSString *userAddressFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userAddressPath];
    
    FAAddressModel *userAddress = [NSKeyedUnarchiver unarchiveObjectWithFile:userAddressFile];
    return userAddress;
}
#pragma mark - 清除数据有关

// 清除所有的微信登录数据和用户自身的数据
+(void)removeAllWechatAndUserDatas {
    [self removeAllAddressDatas];
    [self removeAllUserDatas];
}
// 清除所有用户的数据
+(void)removeAllUserDatas {
    NSString *userFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userAccountPath];
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:userFile error:nil];
    
}
+(void)removeAllAddressDatas {
    NSString *userFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:userAddressPath];
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:userFile error:nil];
    
}
#pragma mark - 其他数据处理方面

// 是否登录过
+(BOOL)isAlreadyLogin {
    if ([self UserAccount]) {
        return YES;
    }
    return NO;
}
// 根据是否登录反馈userI的的参数
+(NSNumber *)getUserIdFrom {
    FAUserModel *account =[self UserAccount];
    if (account) {
        return [NSNumber numberWithLong:[account.userid intValue]];
    }else {
        [DisplayHelper displayWarningAlert:@"请登录后再试一下!"];
        return nil;
    }
    return @(1);
}

@end
