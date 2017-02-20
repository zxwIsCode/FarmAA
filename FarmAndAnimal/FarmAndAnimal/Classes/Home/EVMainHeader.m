//
//  EVMainHeader.m
//  ElectricVehicle
//
//  Created by 郑州动力无限科技 on 16/9/29.
//  Copyright © 2016年 郑州动力无限科技. All rights reserved.
//

#import "EVMainHeader.h"
#import "EVbtnAndText.h"
@implementation EVMainHeader
-(void)creatMainHeaderView
{
    int j = 0;
    int k = 0;
    CGFloat  btnAndTextHeight = 0;
    for (int i = 0; i < self.itemArray.count; i ++) {
        EVbtnAndText * btn = [[EVbtnAndText alloc] initWithFrame:CGRectMake(j * SCREEN_WIDTH/5,kScrollHeight+10+k*75*kAppScale, SCREEN_WIDTH/5, 75*kAppScale)];
        btn.btn.tag = i;
        btn.isUrl = YES;
        [btn createBtnAndTitle:[[self.itemArray objectAtIndex:i] objectForKey:@"gimg"] title:[[self.itemArray objectAtIndex:i] objectForKey:@"gcname"] titleColor:[UIColor blackColor]];
        [btn.btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        j++;
        btnAndTextHeight = kScrollHeight+10+75*kAppScale+ k*75*kAppScale ;
        if (j==5) {
            j=0;
            k++;
        }
    }
    if ([self.delegate respondsToSelector:@selector(getHeaderHeight:)]) {
        [_delegate getHeaderHeight:btnAndTextHeight];
    }
    UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,btnAndTextHeight, SCREEN_WIDTH,10)];
    lineImg.backgroundColor = RGB(244, 245,246);
    [self addSubview:lineImg];
    
    UIButton * headerButton = [CMCustomViewFactory createButton:CGRectMake(0, CGRectGetMaxY(lineImg.frame), SCREEN_WIDTH, TabBar_HEIGHT) title:@"  新品推荐" Image:ImageNamed(@"icon_xinpin")];
    [headerButton setTitleColor:RGBCOLOR(251, 58, 47) forState:UIControlStateNormal];
    [self addSubview:headerButton];

}


- (void)btnAction:(id)sender{
    UIButton * btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(chooseCommodity:withGoodID:)]) {
        [_delegate chooseCommodity:btn.titleLabel.text withGoodID:[[self.itemArray objectAtIndex:btn.tag] objectForKey:@"gcid"]];
    }
}
@end
