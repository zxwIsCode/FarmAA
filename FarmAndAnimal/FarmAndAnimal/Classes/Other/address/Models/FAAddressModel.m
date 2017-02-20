//
//  FAAddressModel.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAAddressModel.h"

@implementation FAAddressModel
@synthesize consignee_address,address_id,consignee_name,consignee_phe,flag,remarks;
-(instancetype)initWithDictionary:(NSDictionary *)adddressDic {
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:adddressDic];
    }
    return self;
}
+(instancetype)dicWithAddress:(NSDictionary *)adddressDic {
    return [[self alloc]initWithDictionary:adddressDic];
}

// 避免不必要的key产生崩溃
-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    
}

/**
 *  获得存储对象调用
 */

#pragma mark -
#pragma mark -----nscoding-----
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:consignee_address forKey:@"consignee_address"];
    [encoder encodeObject:address_id forKey:@"address_id"];
    [encoder encodeObject:consignee_name forKey:@"consignee_name"];
    [encoder encodeObject:consignee_phe forKey:@"consignee_phe"];
    [encoder encodeObject:remarks forKey:@"remarks"];
    [encoder encodeObject:[NSNumber numberWithInteger:flag] forKey:@"flag"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.consignee_address = [decoder decodeObjectForKey:@"consignee_address"] ;
        self.address_id = [decoder decodeObjectForKey:@"address_id"];
        self.consignee_name = [decoder decodeObjectForKey:@"consignee_name"];
        self.consignee_phe = [decoder decodeObjectForKey:@"consignee_phe"];
        self.flag = [[decoder decodeObjectForKey:@"flag"] integerValue];
        self.remarks = [decoder decodeObjectForKey:@"remarks"];
    }
    return self;
}

@end
