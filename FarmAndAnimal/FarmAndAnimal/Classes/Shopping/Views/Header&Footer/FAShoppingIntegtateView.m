//
//  FAShoppingIntegtateView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingIntegtateView.h"

@interface FAShoppingIntegtateView ()

@property(nonatomic,strong)UILabel *integrateLable;

@property(nonatomic,strong)UIButton *selectedBtn;

@end

@implementation FAShoppingIntegtateView

+(instancetype)IntegrateView {
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        
        self.integrateLable =[[UILabel alloc]init];
        self.selectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        self.integrateLable.frame =CGRectMake(0, 0, 160 *kAppScale, kShoppingIntegtateHeight);
        CGFloat selectedBtnWH = kShoppingIntegtateHeight;
        self.selectedBtn.frame =CGRectMake(SCREEN_WIDTH -selectedBtnWH -10 *kAppScale, 0, selectedBtnWH, selectedBtnWH);
        
        self.integrateLable.backgroundColor =[UIColor redColor];
        self.selectedBtn.backgroundColor =[UIColor greenColor];
        
        self.integrateLable.text =@"可用XX积分";
        [self.selectedBtn setTitle:@"无" forState:UIControlStateNormal];
        [self.selectedBtn setTitle:@"选择" forState:UIControlStateHighlighted];
        [self.selectedBtn setTitle:@"选择" forState:UIControlStateSelected];
        [self.selectedBtn addTarget:self action:@selector(choseStateClick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.integrateLable];
        [self addSubview:self.selectedBtn];
    }
    return self;
}
-(void)choseStateClick:(UIButton *)button {
    self.selectedBtn.selected = !self.selectedBtn.selected;
    
}


@end
