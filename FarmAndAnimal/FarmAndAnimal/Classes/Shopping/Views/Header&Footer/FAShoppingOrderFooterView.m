//
//  FAShoppingOrderFooterView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingOrderFooterView.h"

#define kTextFont [UIFont systemFontOfSize:14 *kAppScale]
@interface FAShoppingOrderFooterView ()

//运费
@property(nonatomic,strong)UILabel *transportationMoneyLable;
//配送方式
@property(nonatomic,strong)UILabel *transportationWayLable;
//卖家留言
@property(nonatomic,strong)UILabel *sellerMessageLable;

@property(nonatomic,strong)UITextField *messageTextFeild;
// 商品数量
@property(nonatomic,strong)UILabel *lastCountTolable;


@end
@implementation FAShoppingOrderFooterView
+(instancetype)updateWithFooterTableView:(UITableView *)tableView {
    static NSString *ID = @"FAShoppingOrderFooterViewId";
    FAShoppingOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!footerView) {
        footerView = [[FAShoppingOrderFooterView alloc] initWithReuseIdentifier:ID];
    }
    return footerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithReuseIdentifier:reuseIdentifier]) {
       
        // 初始化
        self.transportationMoneyLable =[[UILabel alloc]init];
        self.transportationWayLable =[[UILabel alloc]init];
        self.sellerMessageLable =[[UILabel alloc]init];
        self.messageTextFeild =[[UITextField alloc]init];
        self.lastCountTolable =[[UILabel alloc]init];
        
        UIView *lineView =[[UIView alloc]init];
        UIView *lineView1 =[[UIView alloc]init];


        // 设置frame
        CGFloat selfH =kShoppingOrderFooterViewHeight;
        CGFloat cellItemSpacing =10 *kAppScale;
        
        CGFloat smallCellH =selfH/3.0;
        self.transportationMoneyLable.frame =CGRectMake(cellItemSpacing, 0, 100*kAppScale, smallCellH);
        CGFloat transportationWayLableW =100 *kAppScale;
        self.transportationWayLable.frame =CGRectMake(SCREEN_WIDTH -cellItemSpacing -transportationWayLableW, 0, transportationWayLableW, smallCellH);
        lineView.frame =CGRectMake(cellItemSpacing, CGRectGetMaxY(self.transportationMoneyLable.frame), SCREEN_WIDTH -cellItemSpacing *2, 1);
        
        self.sellerMessageLable.frame =CGRectMake(cellItemSpacing, CGRectGetMaxY(self.transportationMoneyLable.frame), 100 *kAppScale, smallCellH);
        self.messageTextFeild.frame =CGRectMake(CGRectGetMaxX(self.transportationMoneyLable.frame) +cellItemSpacing, CGRectGetMaxY(self.transportationMoneyLable.frame), 200 *kAppScale, smallCellH);
        
        lineView1.frame =CGRectMake(cellItemSpacing, CGRectGetMaxY(self.sellerMessageLable.frame), SCREEN_WIDTH -cellItemSpacing *2, 1);

        
        CGFloat lastCountTolableW =150 *kAppScale;
        self.lastCountTolable.frame =CGRectMake(SCREEN_WIDTH -lastCountTolableW -cellItemSpacing, CGRectGetMaxY(self.sellerMessageLable.frame), lastCountTolableW, smallCellH);
        
        lineView.backgroundColor =[UIColor lightGrayColor];
        lineView1.backgroundColor =[UIColor lightGrayColor];
        
        // 属性设置
        self.transportationMoneyLable.text =@"运费:";
        self.transportationWayLable.text =@"包邮";
        self.sellerMessageLable.text =@"卖家留言";
        
        self.transportationMoneyLable.font =kTextFont;
        self.transportationWayLable.font =kTextFont;
        self.sellerMessageLable.font =kTextFont;
        self.messageTextFeild.font =kTextFont;
        self.lastCountTolable.font =kTextFont;


        // 添加测试颜色
        self.transportationMoneyLable.backgroundColor =[UIColor brownColor];
        self.transportationWayLable.backgroundColor =[UIColor yellowColor];
        self.sellerMessageLable.backgroundColor =[UIColor purpleColor];
        self.messageTextFeild.backgroundColor =[UIColor redColor];
        self.lastCountTolable.backgroundColor =[UIColor blueColor];
       
        // 添加到父View上
        [self.contentView addSubview:self.transportationMoneyLable];
        [self.contentView addSubview:self.transportationWayLable];
        [self.contentView addSubview:self.sellerMessageLable];
        [self.contentView addSubview:self.messageTextFeild];
        [self.contentView addSubview:self.lastCountTolable];
        
        [self.contentView addSubview:lineView];
        [self.contentView addSubview:lineView1];

    }
    return self;
}

-(void)setSectionModel:(FAShoppingSectionModel *)sectionModel {
    _sectionModel =sectionModel;
    self.messageTextFeild.text =sectionModel.sellerMessage;
    self.lastCountTolable.text =[NSString stringWithFormat:@"共%@件商品,合计%@",sectionModel.goodsCount,sectionModel.totolMoney];
    
}


@end
