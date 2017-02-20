//
//  FAShoppingCommonView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingCommonView.h"
#import "FAShopingItemFormatModel.h"

@interface FAShoppingCommonView ()


@property(nonatomic,strong)UIImageView *photoImageView;


@property(nonatomic,strong)UIView *rightSuperView;

@property(nonatomic,strong)UILabel *contentLable;

@property(nonatomic,strong)UILabel *integralLable;

@property(nonatomic,strong)UILabel *moneyLable;

// 销量
@property(nonatomic,strong)UILabel *countLable;

@end
@implementation FAShoppingCommonView

-(instancetype)initShoppingCommonView:(CGRect)frame; {
    if (self =[super initWithFrame:frame]) {
        // 1.初始化
        self.photoImageView =[[UIImageView alloc]init];
        self.rightSuperView =[[UIView alloc]init];
        self.contentLable =[[UILabel alloc]init];
        self.integralLable =[[UILabel alloc]init];
        self.moneyLable =[[UILabel alloc]init];
        self.countLable =[[UILabel alloc]init];
        
        // 2.设置frame
        CGFloat selfH =frame.size.height;
        CGFloat selfW =frame.size.width;
        CGFloat cellItemSpacing =5 *kAppScale;
        CGFloat photoImageViewWH =kShoppingCellHeight -2* 2 *cellItemSpacing;
        self.photoImageView.frame =CGRectMake(cellItemSpacing, cellItemSpacing, photoImageViewWH, photoImageViewWH);
        CGFloat rightSuperViewMinX =CGRectGetMaxX(self.photoImageView.frame) +2 *cellItemSpacing;
        CGFloat rightSuperViewY = cellItemSpacing;
        CGFloat rightSuperViewW =selfW -rightSuperViewMinX - 2 *2 *cellItemSpacing;
        CGFloat rightSuperViewH =selfH -2 *cellItemSpacing;
        
        self.rightSuperView.frame =CGRectMake(rightSuperViewMinX, rightSuperViewY, rightSuperViewW , rightSuperViewH);
        self.contentLable.frame =CGRectMake(0, cellItemSpacing, rightSuperViewW, 36 *kAppScale);
        self.integralLable.frame =CGRectMake(0, CGRectGetMaxY(self.contentLable.frame) +cellItemSpacing, rightSuperViewW, 15 *kAppScale);
        CGFloat moneyLableH =20 *kAppScale;
        CGFloat moneyLableY =rightSuperViewH -moneyLableH -2 *cellItemSpacing;
        
        self.moneyLable.frame =CGRectMake(0, moneyLableY, 100 *kAppScale, moneyLableH);
        CGFloat countLableW =80 *kAppScale;
        self.countLable.frame =CGRectMake(rightSuperViewW -countLableW, moneyLableY, countLableW, moneyLableH);
        
        
        // 3.设置基本属性
        self.moneyLable.textColor =[UIColor redColor];
        // 4.添加到父View上
        [self addSubview:self.photoImageView];
        [self addSubview:self.rightSuperView];
        
        [self.rightSuperView addSubview:self.contentLable];
        [self.rightSuperView addSubview:self.integralLable];
        [self.rightSuperView addSubview:self.moneyLable];
        [self.rightSuperView addSubview:self.countLable];
        
        // 5.测试颜色
        self.photoImageView.backgroundColor =[UIColor brownColor];
//        self.rightSuperView.backgroundColor =[UIColor yellowColor];
//        self.contentLable.backgroundColor =[UIColor purpleColor];
//        self.integralLable.backgroundColor =[UIColor redColor];
//        self.moneyLable.backgroundColor =[UIColor blueColor];
//        self.countLable.backgroundColor =[UIColor orangeColor];

    }
    return self;
}

-(void)setItemModel:(FACommotidyModel *)itemModel {
    _itemModel =itemModel;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.gpo]];
    self.contentLable.text =itemModel.gname;
    self.integralLable.text =itemModel.sales;
    self.moneyLable.text =[NSString stringWithFormat:@"￥%@",itemModel.gp];
    
}


@end
