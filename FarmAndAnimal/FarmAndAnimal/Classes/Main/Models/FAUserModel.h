//
//  FAUserModel.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAUserModel : NSObject
// 用户id
@property(nonatomic,copy)NSString *userid;
// 用户手机号
@property(nonatomic,copy)NSString *phone;
// 用户头像
@property(nonatomic,copy)NSString *photo;
// 用户推荐码
@property(nonatomic,copy)NSString *extension;
// 用户昵称
@property(nonatomic,copy)NSString *nickname;
// 推荐人数
@property(nonatomic,copy)NSString *extcount;
// 旺币数量
@property(nonatomic,copy)NSString *coinnum;
// 发布豆数量
@property(nonatomic,copy)NSString *beans;
// 推荐分红总额
@property(nonatomic,copy)NSString *tjtotal;
// 上级的id
@property(nonatomic,copy)NSString *superior;
// 提现总额
@property(nonatomic,copy)NSString *txtotal;
//师傅的推荐码
@property(nonatomic,copy)NSString * masterext;
+(instancetype)dicWithUserAccount:(NSDictionary *)accountDic;
@end
