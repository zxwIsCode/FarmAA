//
//  FABussinessCollectionReusableView.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FABussinessCollectionReusableView.h"
#define LabelFont 20 *kAppScale
@implementation FABussinessCollectionReusableView
-(void)drawRect:(CGRect)rect{
    UIButton * topButton = [CMCustomViewFactory createButton:CGRectMake(0, kScrollHeight ,SCREEN_WIDTH, TabBar_HEIGHT) title:self.bussinessName Image:ImageNamed(@"icon_dddianpu")];
    [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self addSubview:topButton];
    
    UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(topButton.frame), SCREEN_WIDTH,10)];
    lineImg.backgroundColor = RGB(244, 245,246);
    [self addSubview:lineImg];
    
    UILabel * nameLabel = [CMCustomViewFactory createLabel:CGRectMake(0, CGRectGetMaxY(lineImg.frame), SCREEN_WIDTH, TabBar_HEIGHT) title:@"—— 全部产品 ——" color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:LabelFont] textAlignment:NSTextAlignmentCenter];
    [self addSubview:nameLabel];
}

@end
