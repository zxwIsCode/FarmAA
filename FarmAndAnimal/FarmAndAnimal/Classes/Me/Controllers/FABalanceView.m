//
//  FABalanceView.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/18.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FABalanceView.h"

@implementation FABalanceView
{
    NSInteger  _currentSelectIndex;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (int i = 0; i<self.titleArr.count; i++) {
        UIButton * allButton = [CMCustomViewFactory createButton:CGRectMake(20+i*(SCREEN_WIDTH-40)/3, 20, (SCREEN_WIDTH-40)/3, NavigationBar_HEIGHT) title:[self.titleArr objectAtIndex:i] Image:nil];
        allButton.tag = i +10;
        allButton.layer.masksToBounds = YES;
        [allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [allButton addTarget:self action:@selector(chooseSec:) forControlEvents:UIControlEventTouchUpInside];
        allButton.layer.borderColor = RGB(235, 235, 235).CGColor;
        allButton.layer.borderWidth = 1.0f;
        UIBezierPath * maskPath;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = allButton.bounds;
        if (i==0) {
            _currentSelectIndex = allButton.tag;
            allButton.selected = YES;
            [allButton setBackgroundColor:RGBCOLOR(251, 58, 47)];
            maskPath = [UIBezierPath bezierPathWithRoundedRect:allButton.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                   cornerRadii:CGSizeMake(10.f, 10.f)];
            maskLayer.path = maskPath.CGPath;
            allButton.layer.mask = maskLayer;
            
        }else if (i==2){
            maskPath = [UIBezierPath bezierPathWithRoundedRect:allButton.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                   cornerRadii:CGSizeMake(10.f, 8.f)];
            
            maskLayer.path = maskPath.CGPath;
            allButton.layer.mask = maskLayer;
        }
        
        
        [self addSubview:allButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(allButton.frame)+20, SCREEN_WIDTH, 5)];
        lineView.backgroundColor = RGB(244, 245, 246);
        [self addSubview:lineView];
    }

}


-(void)chooseSec:(id)sender{
    UIButton * button = (UIButton*)sender;
    _currentSelectIndex = button.tag;
    for (int i = 0; i<self.titleArr.count; i++) {
        UIButton * otherBtn = [self viewWithTag:i+10];
        if (otherBtn.tag !=button.tag) {
            otherBtn.selected = NO;
            [otherBtn setBackgroundColor:[UIColor whiteColor]];
        }else{
            otherBtn.selected = YES;
            [otherBtn setBackgroundColor:RGBCOLOR(251, 58, 47)];
        }
    }
    if ([self.delegate respondsToSelector:@selector(chooseSection:)]) {
        [_delegate chooseSection:button.tag];
    }
}

@end
