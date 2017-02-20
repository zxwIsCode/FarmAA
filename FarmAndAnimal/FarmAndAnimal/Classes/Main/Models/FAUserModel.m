//
//  FAUserModel.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAUserModel.h"

@implementation FAUserModel
-(instancetype)initWithDictionary:(NSDictionary *)accountDic {
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:accountDic];
    }
    return self;
}
+(instancetype)dicWithUserAccount:(NSDictionary *)accountDic {
    return [[self alloc]initWithDictionary:accountDic];
}

// 避免不必要的key产生崩溃
-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    
}

/**
 *  获得存储对象调用
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.userid = [decoder decodeObjectForKey:@"userid"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.photo = [decoder decodeObjectForKey:@"photo"];
        self.extension = [decoder decodeObjectForKey:@"extension"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.extcount = [decoder decodeObjectForKey:@"extcount"];
        self.coinnum = [decoder decodeObjectForKey:@"coinnum"];
        self.beans = [decoder decodeObjectForKey:@"beans"];
        self.tjtotal = [decoder decodeObjectForKey:@"tjtotal"];
        self.txtotal = [decoder decodeObjectForKey:@"txtotal"];
        self.superior = [decoder decodeObjectForKey:@"superior"];
        self.masterext = [decoder decodeObjectForKey:@"masterext"];
    }
    return self;
}

/**
 *  存储对象到文件调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userid forKey:@"userid"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.photo forKey:@"photo"];
    [encoder encodeObject:self.extension forKey:@"extension"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeObject:self.extcount forKey:@"excount"];
    [encoder encodeObject:self.coinnum forKey:@"coinnum"];
    [encoder encodeObject:self.beans forKey:@"beans"];
    [encoder encodeObject:self.tjtotal forKey:@"tjtotal"];
    [encoder encodeObject:self.txtotal forKey:@"txtotal"];
    [encoder encodeObject:self.superior forKey:@"superior"];
    [encoder encodeObject:self.masterext forKey:@"masterext"];
}

@end
