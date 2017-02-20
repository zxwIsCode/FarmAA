//
//  CMCustomViewFactory.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMCustomViewFactory.h"

@implementation CMCustomViewFactory

+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title Image:(UIImage*)Image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
    [button setTitle:title forState:UIControlStateNormal];
    }
    if (Image) {
    [button setImage:Image forState:UIControlStateNormal];
    }
    button.frame = frame;
    [button setAdjustsImageWhenDisabled:NO];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}
+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title normalImage:(UIImage*)normalImage selectImage:(UIImage *)selectImage 
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.frame = frame;
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    [button setAdjustsImageWhenDisabled:NO];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}
+ (UILabel*)createLabel:(CGRect)frame title:(NSString*)title color:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    UIColor *labelColor = (color == nil ? [UIColor blackColor]:color);
    label.textColor = labelColor;
    UIFont  *labelFont = (font == nil ? [UIFont systemFontOfSize:17] : font);
    label.font = labelFont;
    label.textAlignment = alignment;
    return label;
}
//自适应
+ (CGSize)autoSizeFrame:(CGSize)sizeFrame withFont:(UIFont*)font withText:(NSString *)text
{
    NSDictionary * dic = @{NSFontAttributeName:font};
    CGSize labelSize = [text boundingRectWithSize:sizeFrame options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return labelSize;
}

@end
