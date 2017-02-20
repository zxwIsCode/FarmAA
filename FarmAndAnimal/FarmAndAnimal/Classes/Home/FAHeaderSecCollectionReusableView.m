//
//  FAHeaderSecCollectionReusableView.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAHeaderSecCollectionReusableView.h"

@implementation FAHeaderSecCollectionReusableView
-(void)creatOnlyButton{
    UIButton * headerButton = [CMCustomViewFactory createButton:CGRectMake(0,0, SCREEN_WIDTH, TabBar_HEIGHT) title:@"  热销产品" Image:ImageNamed(@"icon_rexiao")];
    [headerButton setTitleColor:RGBCOLOR(251, 58, 47) forState:UIControlStateNormal];
    [self addSubview:headerButton];
}
@end
