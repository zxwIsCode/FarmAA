//
//  FAShoppingTableCell.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingTableCell.h"
#import "FAShoppingCommonView.h"
#import "FAShoppingEditeView.h"
@interface FAShoppingTableCell ()

@property(nonatomic,strong)UIButton *selectedBtn;

// 正常状态的cell的子控件
@property(nonatomic,strong)FAShoppingCommonView *shoppingView;
// 点击编辑状态的cell的子控件
@property(nonatomic,strong)FAShoppingEditeView *shoppingEditeView;


@end

@implementation FAShoppingTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)updateWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"kShoppingTableCelld";
    FAShoppingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FAShoppingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1.初始化
        self.selectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];

        // 2.设置frame
        CGFloat selfH =kShoppingCellHeight;
        CGFloat cellItemSpacing =5 *kAppScale;
        self.selectedBtn.center = CGPointMake(25 *kAppScale, selfH *0.5);
        CGFloat selectedBtnWH =20 *kAppScale;
        self.selectedBtn.bounds =CGRectMake(0, 0,selectedBtnWH, selectedBtnWH);
        
       
        // 3.设置基本属性
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhong"] forState:UIControlStateNormal];
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhongb"] forState:UIControlStateHighlighted];
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhongb"] forState:UIControlStateSelected];
        [self.selectedBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 4.添加到父View上
        [self.contentView addSubview:self.selectedBtn];

        // 5.测试颜色
        
        self.shoppingView.backgroundColor =[UIColor whiteColor];
        
    }
    return self;
}
-(void)chooseBtnClick:(UIButton *)btn {
    
    _itemModel.isItemSelected =!_itemModel.isItemSelected;
    if (self.tableCellBlock) {
        self.tableCellBlock(_itemModel);
    }
    
}
-(void)setItemModel:(FACommotidyModel *)itemModel {
    _itemModel =itemModel;
    
    // 2.赋值的问题
    if (itemModel.isItemSelected) {
        self.selectedBtn.selected =YES;
    }else {
        self.selectedBtn.selected =NO;

    }
    
    if (_isReviseCount) {
//        self.shoppingView.hidden =YES;
        [_shoppingView removeFromSuperview];
        self.shoppingEditeView.hidden =NO;
        self.shoppingEditeView.itemModel =itemModel;
    }else {
        [_shoppingEditeView removeFromSuperview];

        self.shoppingView.hidden =NO;
//        self.shoppingEditeView.hidden =YES;
        self.shoppingView.itemModel =itemModel;
    }
    
  
}

-(void)setIsSelected:(BOOL)isSelected {
    _isSelected =isSelected;
    
   
}

-(void)setIsReviseCount:(BOOL)isReviseCount {
    _isReviseCount =isReviseCount;
    CGFloat selfH =kShoppingCellHeight;
    CGFloat cellItemSpacing =5 *kAppScale;
    CGFloat shoppingViewX = CGRectGetMaxX(self.selectedBtn.frame)+cellItemSpacing;
    if (_isReviseCount) {
        self.shoppingEditeView = [[FAShoppingEditeView alloc] initShoppingEditeView:CGRectMake(CGRectGetMaxX(self.selectedBtn.frame) +cellItemSpacing, cellItemSpacing, SCREEN_WIDTH -shoppingViewX -cellItemSpacing, selfH)];
        [self.contentView addSubview:self.shoppingEditeView];
    }else {
        self.shoppingView = [[FAShoppingCommonView alloc] initShoppingCommonView:CGRectMake(CGRectGetMaxX(self.selectedBtn.frame) +cellItemSpacing, cellItemSpacing, SCREEN_WIDTH -shoppingViewX -cellItemSpacing, selfH)];
        [self.contentView addSubview:self.shoppingView];
        
    }
}



@end
