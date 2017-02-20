//
//  FAShoppingBuyNowViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingBuyNowViewController.h"
#import "FAPayKindViewController.h"
#import "FAShopingItemFormatModel.h"

@interface FAShoppingBuyNowViewController ()

@property(nonatomic,strong)NSMutableArray *weighBtnArr;

@property(nonatomic,assign)NSInteger goodsCount;


@end

@implementation FAShoppingBuyNowViewController

#pragma mark - Init
- (void)viewDidLoad {
    
    self.title =@"商品属性";
    [super viewDidLoad];
    
    self.goodsCount =1;
    self.commotidyModel.goodsFormatCount =0;
    
    
    [self.view addSubview:self.commonView];
    
    self.commonView.itemModel =self.commotidyModel;
    


}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
#pragma mark - Private Methods
-(void)creatAllSubViews:(CGFloat)commonViewMaxY andCommotidyModel:(FACommotidyModel *)commotidyModel{
    CGFloat cellItemSpacing =5 *kAppScale;
    CGFloat ItemBigSpacing =10 *kAppScale;
    CGFloat lineViewW = SCREEN_WIDTH -2 *cellItemSpacing;
    
    UIView *lineView =  [self creatLineView:CGRectMake(cellItemSpacing, commonViewMaxY, lineViewW, 1)];
    
    UILabel *weightLable =[self creatLable:@"规格" andFrame:CGRectMake(ItemBigSpacing, CGRectGetMaxY(lineView.frame) +cellItemSpacing, 80 *kAppScale, 30 *kAppScale)];
    
    
    CGFloat buttonW =80 *kAppScale;
    CGFloat buttonH =30 *kAppScale;
    CGFloat buttonY =CGRectGetMaxY(weightLable.frame) +cellItemSpacing;

    for (int index =0; index <commotidyModel.sc.count; index ++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag =10 *(index +1);
        CGFloat buttonX =ItemBigSpacing +index * (buttonW +cellItemSpacing);
        btn.frame =CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        FAShopingItemFormatModel *itemFormatModel =commotidyModel.sc[index];

        btn.titleLabel.font =[UIFont systemFontOfSize:14 *kAppScale];
        // 不同状态
        [btn setTitle:itemFormatModel.gsdesc forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.backgroundColor =[UIColor lightGrayColor];
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.weighBtnArr addObject:btn];
        [self.view addSubview:btn];
    }
    UIButton *btn =self.weighBtnArr[0];
    if (btn.tag ==10) {
        btn.selected =YES;
        btn.backgroundColor =[UIColor redColor];
    }
    UIView *lineView2 =  [self creatLineView:CGRectMake(cellItemSpacing, CGRectGetMaxY(btn.frame) +ItemBigSpacing, lineViewW, 1)];
    
    UILabel *numberLable =[self creatLable:@"数量" andFrame:CGRectMake(ItemBigSpacing, CGRectGetMaxY(lineView2.frame) +cellItemSpacing, 100 *kAppScale, 30 *kAppScale)];
    
    CGFloat countBtnWH =30 *kAppScale;
    CGFloat countBtnY =CGRectGetMaxY(numberLable.frame) +cellItemSpacing;
    
    self.subBtn.frame = CGRectMake(ItemBigSpacing, countBtnY, countBtnWH, countBtnWH);
    self.countLable.frame =CGRectMake(cellItemSpacing +CGRectGetMaxX(self.subBtn.frame), countBtnY, countBtnWH, countBtnWH);
    self.addBtn.frame = CGRectMake(cellItemSpacing +CGRectGetMaxX(self.countLable.frame), countBtnY, countBtnWH, countBtnWH);
    
    CGFloat buyNowBtnH =50 *kAppScale;
    self.buyNowBtn.frame =CGRectMake(0, SCREEN_HEIGHT -NavigationBar_BarHeight  -buyNowBtnH, SCREEN_WIDTH, buyNowBtnH);
    // 给子类实现修改
    [self settingBtnTitle];
    // 添加到父View上
    [self.view addSubview:lineView];
    
    [self.view addSubview:weightLable];
    [self.view addSubview:lineView2];
    
    [self.view addSubview:numberLable];
    [self.view addSubview:self.subBtn];
    [self.view addSubview:self.countLable];
    [self.view addSubview:self.addBtn];
    
    [self.view addSubview:self.buyNowBtn];


    // 测试颜色:
    
//    weightLable.backgroundColor =[UIColor blueColor];
//    self.countLable.backgroundColor =[UIColor yellowColor];
    
    
    
}
-(UILabel *)creatLable:(NSString *)text andFrame:(CGRect)frame {
    UILabel *lable =[[UILabel alloc]initWithFrame:frame];
    lable.text =text;
    lable.font =[UIFont systemFontOfSize:14 *kAppScale];
    return lable;
}

-(UIView *)creatLineView:(CGRect)frame {
    
    UIView *lineView =[[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor =[UIColor darkGrayColor];
    return lineView;
}

#pragma mark - 子类继承
// 给子类实现修改
-(void)settingBtnTitle{
    [self.buyNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];

}
#pragma mark - Action Methods

-(void)buttonClick:(UIButton *)btn {
    self.tempBtn.selected = NO;
    btn.selected = YES;
    self.tempBtn = btn;
    
    if (self.tempBtn.selected) {
        for (UIButton *btn in self.weighBtnArr) {
            btn.backgroundColor =[UIColor lightGrayColor];
        }
        self.tempBtn.backgroundColor =[UIColor redColor];
        
        self.commotidyModel.goodsFormatCount= self.tempBtn.tag/10 -1;

    }else {
        for (UIButton *btn in self.weighBtnArr) {
            btn.backgroundColor =[UIColor redColor];
        }
        self.tempBtn.backgroundColor =[UIColor lightGrayColor];
    }
    
}
// 点击减少按钮
-(void)subButtonClick:(UIButton *)btn {
    if (self.goodsCount >1) {
        self.goodsCount --;
    }else {
        self.goodsCount =1;
    }
    self.countLable.text =[NSString stringWithFormat:@"%ld",self.goodsCount];
    self.commotidyModel.goodsCount =self.goodsCount;
    
}
// 点击添加按钮
-(void)addButtonClick:(UIButton *)btn {
    
    self.goodsCount ++;
    self.countLable.text =[NSString stringWithFormat:@"%ld",self.goodsCount];
    self.commotidyModel.goodsCount =self.goodsCount;


    
}
// 点击立即购买按钮
-(void)buyNowBtnClick:(UIButton *)btn {
    
    DDLog(@"点击了立即购买");

    FAPayKindViewController *payKindVC =[[FAPayKindViewController alloc]init];
    payKindVC.itemModel =self.commotidyModel;
    [self.navigationController pushViewController:payKindVC animated:YES];
}

#pragma mark - Setter & Getter
-(void)setCommotidyModel:(FACommotidyModel *)commotidyModel {
    _commotidyModel =commotidyModel;
    
    CGFloat commonViewMaxY = kShoppingCellHeight + 10*kAppScale + 5*kAppScale;
    
    [self creatAllSubViews:commonViewMaxY andCommotidyModel:commotidyModel];

    
    
}
-(FAShoppingCommonView *)commonView {
    CGFloat selfH =kShoppingCellHeight +10 *kAppScale;
    CGFloat cellItemSpacing =5 *kAppScale;
    if (!_commonView) {
        _commonView =[[FAShoppingCommonView alloc]initShoppingCommonView:CGRectMake(cellItemSpacing+10 *kAppScale, cellItemSpacing, SCREEN_WIDTH -2 *cellItemSpacing, selfH)];
    }
    return _commonView;
}
-(UIButton *)subBtn {
    if (!_subBtn) {
        _subBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn setTitle:@"减" forState:UIControlStateNormal];
        _subBtn.backgroundColor =[UIColor lightGrayColor];
        [_subBtn addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"加" forState:UIControlStateNormal];
        _addBtn.backgroundColor =[UIColor lightGrayColor];
        [_addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(UILabel *)countLable {
    if (!_countLable) {
        _countLable =[[UILabel alloc]init];
        _countLable.textAlignment =NSTextAlignmentCenter;
        _countLable.text =[NSString stringWithFormat:@"%ld",self.goodsCount];
    }
    return _countLable;
}
-(NSMutableArray *)weighBtnArr {
    if (!_weighBtnArr) {
        _weighBtnArr =[NSMutableArray array];
    }
    return _weighBtnArr;
}
-(UIButton *)buyNowBtn {
    if (!_buyNowBtn) {
        _buyNowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _buyNowBtn.backgroundColor =[UIColor redColor];
        [_buyNowBtn addTarget:self action:@selector(buyNowBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _buyNowBtn;
}

@end
