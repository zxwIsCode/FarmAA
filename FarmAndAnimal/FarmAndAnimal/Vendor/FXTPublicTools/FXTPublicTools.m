//
//  FXTPublicTools.m
//  DingBangBangApp
//
//  Created by apple on 14/12/26.
//  Copyright (c) 2014年 河南力帮信息科技有限公司. All rights reserved.
//

#import "FXTPublicTools.h"

@implementation FXTPublicTools
//程序中使用的，将日期显示成  2011年4月4日 星期一
+ (NSString *) Date2StrV:(NSDate *)indate{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]]; //setLocale 方法将其转为中文的日期表达
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd  hh':'ss EEEE";
    NSString *tempstr = [dateFormatter stringFromDate:indate];
    return tempstr;
}
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    
    return NO;
}
//获取入口类
+ (AppDelegate *)getAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
//改高度
+(CGRect)changeHeightForFrame:(CGRect)frame withHeight:(CGFloat)height{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    return newFrame;
}

//改宽度
+(CGRect)changeWidthForFrame:(CGRect)frame withWidth:(CGFloat)width{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    return newFrame;
}

//改x
+(CGRect)changeXForFrame:(CGRect)frame withX:(CGFloat)x{
    CGRect newFrame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
    return newFrame;
}

//改y
+(CGRect)changeYForFrame:(CGRect)frame withY:(CGFloat)y{
    CGRect newFrame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    return newFrame;
}
+(BOOL)isNotEmp:(id)obj
{
    return !(obj == nil
             || [obj isKindOfClass:[NSNull class]]
             || ([obj respondsToSelector:@selector(length)]
                 && [(NSData *)obj length] == 0)
             || ([obj respondsToSelector:@selector(count)]
                 && [(NSArray *)obj count] == 0));
}
#pragma mark --
#pragma mark 检查空
+ (BOOL) isEmptyOrNull:(NSString *) str
{
    if (!str) {
        // null object
        return YES;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return YES;
        } else {
            // is neither empty nor null
            return NO;
        }
    }
}
+ (CGSize)autoSizeFrame:(CGSize*)sizeFrame withFont:(UIFont*)font withText:(NSString *)text
{
    NSDictionary * dic = @{NSFontAttributeName:font};
    CGSize labelSize = [text boundingRectWithSize:*sizeFrame options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return labelSize;
}
@end
