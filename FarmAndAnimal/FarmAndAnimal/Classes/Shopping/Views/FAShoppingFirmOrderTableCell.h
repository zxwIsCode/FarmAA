//
//  FAShoppingFirmOrderTableCell.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAShoppingItemModel.h"
#import "FAAddressModel.h"

#import "FACommotidyModel.h"

@interface FAShoppingFirmOrderTableCell : UITableViewCell

@property(nonatomic,strong)FACommotidyModel *itemModel;

// 确认订单section为0时专用
@property(nonatomic,strong)FAAddressModel *addressModel;

+(instancetype)updateWithTableView:(UITableView *)tableView;

@end
