//
//  FXTPublicTools.h
//  DingBangBangApp
//
//  Created by apple on 14/12/26.
//  Copyright (c) 2014年 河南力帮信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
@interface FXTPublicTools : NSObject
//程序中使用的，将日期显示成  2011年4月4日 星期一
+ (NSString *) Date2StrV:(NSDate *)indate;
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;
//判断是不是空
+ (BOOL) isEmptyOrNull:(NSString *) str;
//获取入口类
+ (AppDelegate *)getAppDelegate;
//改高度
+(CGRect)changeHeightForFrame:(CGRect)frame withHeight:(CGFloat)height;

//改宽度
+(CGRect)changeWidthForFrame:(CGRect)frame withWidth:(CGFloat)width;

//改x
+(CGRect)changeXForFrame:(CGRect)frame withX:(CGFloat)x;

//改y
+(CGRect)changeYForFrame:(CGRect)frame withY:(CGFloat)y;

+ (BOOL)isNotEmp:(id)obj;
//自动布局
+ (CGSize)autoSizeFrame:(CGSize*)sizeFrame withFont:(UIFont*)font withText:(NSString *)text;
@end
