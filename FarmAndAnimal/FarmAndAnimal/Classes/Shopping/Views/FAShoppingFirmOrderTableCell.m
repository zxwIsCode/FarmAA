//
//  FAShoppingFirmOrderTableCell.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingFirmOrderTableCell.h"
#import "FAShoppingCommonView.h"

@interface FAShoppingFirmOrderTableCell ()

@property(nonatomic,strong)FAShoppingCommonView *shoppingView;



@end

@implementation FAShoppingFirmOrderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)updateWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"kFAShoppingFirmOrderTableCelld";
    FAShoppingFirmOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[FAShoppingFirmOrderTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat selfH =kShoppingCellHeight;
        CGFloat cellItemSpacing =5 *kAppScale;
        CGFloat shoppingViewX = cellItemSpacing;
        self.shoppingView = [[FAShoppingCommonView alloc] initShoppingCommonView:CGRectMake(cellItemSpacing, cellItemSpacing, SCREEN_WIDTH -shoppingViewX -cellItemSpacing, selfH)];
        [self.contentView addSubview:self.shoppingView];

    }
    return self;
}

-(void)setItemModel:(FACommotidyModel *)itemModel {
    _itemModel =itemModel;
    
    self.shoppingView.itemModel =itemModel;
    
}

#pragma mark - 确认订单section为0时专用
// 确认订单section为0时专用
-(void)setAddressModel:(FAAddressModel *)addressModel {
    _addressModel =addressModel;
    self.backgroundColor =[UIColor redColor];
    
}


@end
