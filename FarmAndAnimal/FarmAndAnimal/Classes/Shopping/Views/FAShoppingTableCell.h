//
//  FAShoppingTableCell.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAShoppingItemModel.h"
#import "FACommotidyModel.h"

typedef void(^ShoppingTableCellBlock)(FACommotidyModel *model);


@interface FAShoppingTableCell : UITableViewCell
@property(nonatomic,strong)FACommotidyModel *itemModel;


// 编辑的模式
@property(nonatomic,assign)BOOL isSelected;

// 是否要编辑数量等(传值必须在传Model之前)
@property(nonatomic,assign)BOOL isReviseCount;

@property(nonatomic,copy)ShoppingTableCellBlock tableCellBlock;

+(instancetype)updateWithTableView:(UITableView *)tableView;
@end
