//
//  FAAllOrderTableViewCell.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAShoppingItemModel.h"
@interface FAAllOrderTableViewCell : UITableViewCell
@property(nonatomic,strong)FAShoppingItemModel *itemModel;
+(instancetype)updateWithTableView:(UITableView *)tableView;
@end
