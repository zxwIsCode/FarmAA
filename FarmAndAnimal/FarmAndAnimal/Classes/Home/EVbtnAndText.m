//
//  EVbtnAndText.m
//  ElectricVehicle
//
//  Created by 郑州动力无限科技 on 16/9/29.
//  Copyright © 2016年 郑州动力无限科技. All rights reserved.
//

#import "EVbtnAndText.h"

@implementation EVbtnAndText

- (void)createBtnAndTitle:(NSString *)iconImage title:(NSString *)title titleColor:(UIColor *)titlecolor
{
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setFrame:CGRectMake((self.frame.size.width-50)/2, 0, 45*kAppScale, 45*kAppScale)];
    if(_isUrl==YES){
    [_btn sd_setImageWithURL:[NSURL URLWithString:iconImage] forState:UIControlStateNormal];
    }else{
    [_btn setImage:[UIImage imageNamed:iconImage] forState:UIControlStateNormal];
    }
    [_btn setAdjustsImageWhenHighlighted:NO];
    [self addSubview:_btn];
    
    self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn setFrame:CGRectMake(0,45, self.frame.size.width, 15)];
    [_titleBtn setTitle:title forState:UIControlStateNormal];
    [_titleBtn setTitleColor:titlecolor forState:UIControlStateNormal];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleBtn];
}

@end
