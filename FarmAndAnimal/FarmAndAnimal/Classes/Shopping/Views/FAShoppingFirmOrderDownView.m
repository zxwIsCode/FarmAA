//
//  FAShoppingFirmOrderDownView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingFirmOrderDownView.h"

@interface FAShoppingFirmOrderDownView ()

@property(nonatomic,strong)UILabel *totalLable;

@property(nonatomic,strong)UIButton *balanceBtn;

@end

@implementation FAShoppingFirmOrderDownView

+(instancetype)FirmOrderDownView {
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        self.totalLable =[[UILabel alloc]init];
        self.balanceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat selfH =kFirmOrderDownSuperViewHeight;
        CGFloat totalLableW =80 *kAppScale;
        CGFloat balanceBtnW =120 *kAppScale;
        
        self.totalLable.frame =CGRectMake(SCREEN_WIDTH -totalLableW -balanceBtnW, 0, totalLableW, selfH);
        self.balanceBtn.frame =CGRectMake(SCREEN_WIDTH -balanceBtnW, 0, balanceBtnW, selfH);
        
        self.totalLable.text =@"合计:$129";
        [self.balanceBtn setTitle:@"结算" forState:UIControlStateNormal];
    
        self.balanceBtn.tag =20;
        [self.balanceBtn addTarget:self action:@selector(founctionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.totalLable];
        [self addSubview:self.balanceBtn];
        
        self.totalLable.backgroundColor =[UIColor yellowColor];
        self.balanceBtn.backgroundColor =[UIColor purpleColor];
    }
    return self;
}
-(void)founctionClick:(UIButton *)btn{
    if (self.firmOrderDownBlock) {
        self.firmOrderDownBlock(btn.tag);
    }
}



@end
