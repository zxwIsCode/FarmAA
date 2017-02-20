//
//  FAShoppingHeaderView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingHeaderView.h"
#import "FALRButton.h"

@interface FAShoppingHeaderView ()

@property(nonatomic,strong)UIButton *selectedBtn;

@property(nonatomic,strong)FALRButton *titleBtn;


@end
@implementation FAShoppingHeaderView
+(instancetype)updateWithHeaderTableView:(UITableView *)tableView {
    static NSString *ID = @"ShoppingHeaderViewId";
    FAShoppingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[FAShoppingHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithReuseIdentifier:reuseIdentifier]) {
        self.selectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.titleBtn =[FALRButton leftRightButton];
        
        CGFloat selfH =kShoppingHeaderViewHeight;
        CGFloat cellItemSpacing =5 *kAppScale;
        self.selectedBtn.center = CGPointMake(25 *kAppScale, selfH *0.5);
        CGFloat selectedBtnWH =20 *kAppScale;
        self.selectedBtn.bounds =CGRectMake(0, 0,selectedBtnWH, selectedBtnWH);
        
        self.titleBtn.frame =CGRectMake(CGRectGetMaxX(self.selectedBtn.frame) +cellItemSpacing, 0, 180 , selfH);
        
        // 设置基本属性
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhong"] forState:UIControlStateNormal];
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhongb"] forState:UIControlStateHighlighted];
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhongb"] forState:UIControlStateSelected];
        [self.selectedBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        
        self.titleBtn.backgroundColor =[UIColor blueColor];
        
        [self.contentView addSubview:self.selectedBtn];
        [self.contentView addSubview:self.titleBtn];
        
    }
    return self;
}

#pragma mark - Action Methods
-(void)chooseBtnClick:(UIButton *)btn {
    
    _sectionModel.isSecSelected =!_sectionModel.isSecSelected;
    if (self.headerViewBlock) {
        self.headerViewBlock(_sectionModel);
    }
    
}

#pragma mark - Setter & Getter
-(void)setSectionModel:(FAShoppingSectionModel *)sectionModel {
    _sectionModel =sectionModel;
    // 2.赋值的问题
    if (sectionModel.isSecSelected) {
        self.selectedBtn.selected =YES;
    }else {
        self.selectedBtn.selected =NO;
    }

    [self.titleBtn setTitle:sectionModel.seller forState:UIControlStateNormal];
}
-(void)setIsHiddenSel:(BOOL)isHiddenSel {
    CGFloat selfH =kShoppingHeaderViewHeight;
    CGFloat cellItemSpacing =5 *kAppScale;
    
    if (isHiddenSel) {
        self.selectedBtn.center = CGPointMake(0, 0);
        self.selectedBtn.bounds =CGRectMake(0, 0,0, 0);
        self.titleBtn.frame =CGRectMake(CGRectGetMaxX(self.selectedBtn.frame) +cellItemSpacing, 0, 180 , selfH);
    }else {
        CGFloat selfH =kShoppingHeaderViewHeight;
        CGFloat cellItemSpacing =5 *kAppScale;
        self.selectedBtn.center = CGPointMake(25 *kAppScale, selfH *0.5);
        CGFloat selectedBtnWH =20 *kAppScale;
        self.selectedBtn.bounds =CGRectMake(0, 0,selectedBtnWH, selectedBtnWH);
        self.titleBtn.frame =CGRectMake(CGRectGetMaxX(self.selectedBtn.frame) +cellItemSpacing, 0, 180 , selfH);
    }
}
-(void)setIsSelected:(BOOL)isSelected {
    _isSelected =isSelected;
}



@end
