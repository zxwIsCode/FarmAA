//
//  FAShoppingNormalDownView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingDownView.h"
#import "FALRButton.h"

@interface FAShoppingDownView ()

@property(nonatomic,strong)FALRButton *allSelectedBtn;

@property(nonatomic,strong)UILabel *totalLable;

@property(nonatomic,strong)UIButton *balanceBtn;

@end

@implementation FAShoppingDownView

+(instancetype)NormalDownView {
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        self.allSelectedBtn =[FALRButton leftRightButton];
        self.totalLable =[[UILabel alloc]init];
        self.balanceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat selfH =kSelectedAllSuperViewHeight;
        CGFloat allSelectedBtnW =80 *kAppScale;
        CGFloat totalLableW =80 *kAppScale;
        CGFloat balanceBtnW =120 *kAppScale;
        
        self.allSelectedBtn.frame =CGRectMake(0, 0, allSelectedBtnW, selfH);
        self.totalLable.frame =CGRectMake(SCREEN_WIDTH -totalLableW -balanceBtnW, 0, totalLableW, selfH);
        self.balanceBtn.frame =CGRectMake(SCREEN_WIDTH -balanceBtnW, 0, balanceBtnW, selfH);
        
        [self.allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        self.totalLable.text =@"合计:$129";
        [self.balanceBtn setTitle:@"结算" forState:UIControlStateNormal];
        self.allSelectedBtn.tag =10;
        [self.allSelectedBtn addTarget:self action:@selector(founctionClick:) forControlEvents:UIControlEventTouchUpInside];

        self.balanceBtn.tag =20;
        [self.balanceBtn addTarget:self action:@selector(founctionClick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.allSelectedBtn];
        [self addSubview:self.totalLable];
        [self addSubview:self.balanceBtn];

        
        self.allSelectedBtn.backgroundColor =[UIColor darkGrayColor];
        self.totalLable.backgroundColor =[UIColor yellowColor];
        self.balanceBtn.backgroundColor =[UIColor purpleColor];
    }
    return self;
}
-(void)founctionClick:(UIButton *)btn{
    if (btn.tag ==10) {
        btn.selected =!btn.selected;
    }
    if (self.downViewBlock) {
        self.downViewBlock(btn);
    }
}

-(void)setDownModel:(FAShoppingDownModel *)downModel {
    _downModel =downModel;
    if (downModel.isHaveTotolPrice) {
        self.totalLable.hidden =NO;
        self.totalLable.text =downModel.totolPriceStr;

    }else {
        self.totalLable.hidden =YES;

    }
    [self.balanceBtn setTitle:downModel.rightStr forState:UIControlStateNormal];

}



@end
