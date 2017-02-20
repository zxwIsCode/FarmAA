//
//  FAPersonalView.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAPersonalView.h"
#import "EVbtnAndText.h"
@implementation FAPersonalView

@synthesize photo,phone;
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIButton * headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(20,10,46*kAppScale,46*kAppScale);
    [headerBtn setAdjustsImageWhenHighlighted:NO];
    headerBtn.layer.masksToBounds = YES;
    headerBtn.layer.cornerRadius = 23.0f;
    headerBtn.backgroundColor = [UIColor grayColor];
    [headerBtn addTarget:self action:@selector(hearderOption) forControlEvents:UIControlEventTouchUpInside];
    if ([photo isEqualToString:@"icon_wdtouxiang.png"]==YES) {
        [headerBtn setImage:ImageNamed(photo) forState:UIControlStateNormal];
    }else{
        [headerBtn sd_setImageWithURL:[NSURL URLWithString:photo] forState:UIControlStateNormal];
    }
    [headerBtn setAdjustsImageWhenHighlighted:NO];
    [self addSubview:headerBtn];
    
    UILabel * infoLabel =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerBtn.frame)+20,headerBtn.frame.size.height/2+headerBtn.frame.origin.y-10, SCREEN_WIDTH-120, 20)];
    infoLabel.text = phone;
    infoLabel.font = [UIFont systemFontOfSize:16];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:infoLabel];
    
    UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,headerBtn.frame.size.height+headerBtn.frame.origin.y+20, SCREEN_WIDTH,.5)];
    lineImg.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineImg];
    
    NSArray * iconArr = [NSArray arrayWithObjects:@"icon_yue",@"icon_tixian",@"icon_wdjifen", nil];
    NSArray * titleArr = [NSArray arrayWithObjects:@"余额",@"提现",@"积分",nil];
    CGFloat   orignY = CGRectGetMaxY(lineImg.frame)+5;
    for (int i = 0; i < titleArr.count; i ++) {
        EVbtnAndText * btn = [[EVbtnAndText alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH/3,orignY, SCREEN_WIDTH/3, 75*kAppScale)];
        [btn createBtnAndTitle:[iconArr objectAtIndex:i] title:[titleArr objectAtIndex:i] titleColor:[UIColor whiteColor]];
        [btn.btn setTag:i+10];
        [btn.btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame),btn.frame.origin.y-5,.5,btn.frame.size.height)];
        lineImg.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineImg];

    }
}
-(void)hearderOption{
    if ([self.delegate respondsToSelector:@selector(alertPersonView)]) {
        [_delegate alertPersonView];
    }
}
- (void)btnAction:(id)sender{
    UIButton * btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(chooseCommodity:)]) {
        [_delegate chooseCommodity:btn.tag];
    }
}

@end
