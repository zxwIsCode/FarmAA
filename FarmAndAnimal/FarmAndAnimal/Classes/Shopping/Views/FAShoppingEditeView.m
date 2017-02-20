//
//  FAShopingEditeView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingEditeView.h"
#import "FAShopingItemFormatModel.h"

@interface FAShoppingEditeView ()


@property(nonatomic,strong)UIImageView *photoImageView;

@property(nonatomic,strong)UIView *rightSuperView; //父

@property(nonatomic,strong)UIButton *subBtn;

@property(nonatomic,strong)UIButton *addBtn;

@property(nonatomic,strong)UILabel *numberLable;

@property(nonatomic,strong)UIButton *weightBtn;



@end
@implementation FAShoppingEditeView

-(instancetype)initShoppingEditeView:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        // 1.初始化
        self.photoImageView =[[UIImageView alloc]init];
        self.rightSuperView =[[UIView alloc]init];
        self.subBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.numberLable =[[UILabel alloc]init];
        self.weightBtn =[UIButton buttonWithType:UIButtonTypeCustom];

        
        // 2.设置frame
        CGFloat selfH =frame.size.height;
        CGFloat selfW =frame.size.width;
        CGFloat cellItemSpacing =5 *kAppScale;
        CGFloat photoImageViewWH =kShoppingCellHeight -2* 2 *cellItemSpacing;
        self.photoImageView.frame =CGRectMake(+cellItemSpacing, cellItemSpacing, photoImageViewWH, photoImageViewWH);
        CGFloat rightSuperViewMinX =CGRectGetMaxX(self.photoImageView.frame) +2 *cellItemSpacing;
        CGFloat rightSuperViewY = cellItemSpacing;
        CGFloat rightSuperViewW =selfW -rightSuperViewMinX - 2 *2 *cellItemSpacing;
        CGFloat rightSuperViewH =selfH -2 *cellItemSpacing;
        
        self.rightSuperView.frame =CGRectMake(rightSuperViewMinX, rightSuperViewY, rightSuperViewW , rightSuperViewH);
        
        CGFloat buttonW =60 *kAppScale;
        CGFloat buttonH =30*kAppScale;
        self.subBtn.frame =CGRectMake(0, cellItemSpacing, buttonW, buttonH);
        self.addBtn.frame =CGRectMake(rightSuperViewW -buttonW, cellItemSpacing, buttonW, buttonH);
        
        CGFloat numberLableW =(CGRectGetMinX(self.addBtn.frame) -CGRectGetMaxX(self.subBtn.frame));
        self.numberLable.frame =CGRectMake(CGRectGetMaxX(self.subBtn.frame), cellItemSpacing, numberLableW, buttonH);
        
        CGFloat weightBtnH =rightSuperViewH -2 *cellItemSpacing -buttonH;
        self.weightBtn.frame =CGRectMake(0, CGRectGetMaxY(self.subBtn.frame), rightSuperViewW, weightBtnH);
        // 3.设置基本属性
        
        [self.subBtn addTarget:self action:@selector(countBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.subBtn.tag =1;
        self.addBtn.tag =2;
        [self.addBtn addTarget:self action:@selector(countBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        // 4.添加到父View上
        [self addSubview:self.photoImageView];
        [self addSubview:self.rightSuperView];
        
        [self.rightSuperView addSubview:self.subBtn];
        [self.rightSuperView addSubview:self.addBtn];
        [self.rightSuperView addSubview:self.numberLable];
        [self.rightSuperView addSubview:self.weightBtn];

        
        // 5.测试颜色
        self.photoImageView.backgroundColor =[UIColor brownColor];
        self.rightSuperView.backgroundColor =[UIColor yellowColor];
        
        self.subBtn.backgroundColor =[UIColor purpleColor];
        self.addBtn.backgroundColor =[UIColor redColor];
        self.numberLable.backgroundColor =[UIColor blueColor];
        self.weightBtn.backgroundColor =[UIColor orangeColor];
    }
    return self;
}
-(void)countBtnClick:(UIButton *)button {
    
    if (button.tag ==1) { // 点击了减号按钮
        if (_itemModel.goodsCount >1) {
            _itemModel.goodsCount --;
        }else {
            _itemModel.goodsCount =1;
        }
    }else { // 点击了加号按钮
        _itemModel.goodsCount ++;
    }
    self.numberLable.text =[NSString stringWithFormat:@"%ld",_itemModel.goodsCount];

}
-(void)setItemModel:(FACommotidyModel *)itemModel {
    _itemModel =itemModel;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.gpo]];
    if (!itemModel.goodsCount) {
        itemModel.goodsCount =1;
    }
    self.numberLable.text =[NSString stringWithFormat:@"%ld",itemModel.goodsCount];
    FAShopingItemFormatModel *itemFormatModel =itemModel.sc[0];
    [self.weightBtn setTitle:itemFormatModel.gsdesc forState:UIControlStateNormal];


}

//-(void)setItemModel:(FAShoppingItemModel *)itemModel {
//    _itemModel =itemModel;
//    self.photoImageView.image =[UIImage imageNamed:itemModel.goodsImage];
//    self.numberLable.text =itemModel.goodsCount;
//    [self.weightBtn setTitle:itemModel.weightStr forState:UIControlStateNormal];
//}
@end
