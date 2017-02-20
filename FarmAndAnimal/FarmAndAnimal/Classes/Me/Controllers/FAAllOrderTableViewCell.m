//
//  FAAllOrderTableViewCell.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAAllOrderTableViewCell.h"
#import "FAShoppingCommonView.h"
@interface FAAllOrderTableViewCell ()
{
    CGFloat _indexHeight;
}
@property(nonatomic,strong)FAShoppingCommonView *shoppingView;
@end

@implementation FAAllOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)updateWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"FAAllOrderTableViewCell";
    FAAllOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FAAllOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIButton * titleBtn = [CMCustomViewFactory createButton:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBar_HEIGHT) title:@"  猪饲料服务中心" Image:ImageNamed(@"icon_dddianpu")];
        [titleBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15*kAppScale];
        [self.contentView addSubview:titleBtn];
        
        UIImageView * line0Img = [[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleBtn.frame)-1, SCREEN_WIDTH, 1)];
        line0Img.backgroundColor = RGB(235, 235,235);
        [self.contentView addSubview:line0Img];
        
        _indexHeight = CGRectGetMaxY(line0Img.frame);
        
        [self.contentView addSubview:self.shoppingView];
        
        UILabel * insecLabel = [CMCustomViewFactory createLabel:CGRectMake(0, CGRectGetMaxY(self.shoppingView.frame), SCREEN_WIDTH, NavigationBar_HEIGHT) title:@"共1件商品，合计：¥126" color:[UIColor blackColor] font:[UIFont systemFontOfSize:15*kAppScale] textAlignment:NSTextAlignmentRight];
        insecLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:insecLabel];
        
        UIImageView * line1Img = [[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(insecLabel.frame), SCREEN_WIDTH, 1)];
        line1Img.backgroundColor = RGB(235, 235,235);
        [self.contentView addSubview:line1Img];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(line1Img.frame), SCREEN_WIDTH, NavigationBar_HEIGHT)];
        bottomView.backgroundColor= [UIColor whiteColor];
        [self.contentView addSubview:bottomView];
        
        UIButton * deleteBtn = [CMCustomViewFactory createButton:CGRectMake(SCREEN_WIDTH-10-100,NavigationBar_HEIGHT/2-30/2, 100,30) title:@"删除订单" Image:nil];
        [deleteBtn setTitleColor:RGB(175, 175, 175) forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15*kAppScale];
        [bottomView addSubview:deleteBtn];
        
        UIButton * talkBtn = [CMCustomViewFactory createButton:CGRectMake(deleteBtn.frame.origin.x-100-10,deleteBtn.frame.origin.y, 100, 30) title:@"去评价" Image:nil];
        [talkBtn setTitleColor:RGBCOLOR(251, 58, 47) forState:UIControlStateNormal];
        talkBtn.titleLabel.font = [UIFont systemFontOfSize:15*kAppScale];
        [bottomView addSubview:talkBtn];
        
        UIImageView * lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(bottomView.frame), SCREEN_WIDTH, 10)];
        lineImg.backgroundColor = RGB(244, 245,246);
        [self.contentView addSubview:lineImg];  
        
        [self initButtonStyle:deleteBtn withColor:RGB(235, 235, 235)];
        [self initButtonStyle:talkBtn withColor:RGBCOLOR(251, 58, 47)];
    
    }
    return self;
}
-(void)initButtonStyle:(UIButton*)button withColor:(UIColor *)color{
    button.layer.cornerRadius = YES;
    button.layer.borderColor = color.CGColor;
    button.layer.borderWidth = 1.0f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(FAShoppingCommonView *)shoppingView{
    if (!_shoppingView) {
        _shoppingView = [[FAShoppingCommonView alloc] initShoppingCommonView:CGRectMake(0,_indexHeight, SCREEN_WIDTH, 80)];
    }
    return _shoppingView;
}
@end
