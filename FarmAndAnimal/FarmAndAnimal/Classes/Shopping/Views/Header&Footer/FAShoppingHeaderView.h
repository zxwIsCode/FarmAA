//
//  FAShoppingHeaderView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAShoppingSectionModel.h"

#import "FAAddressModel.h"

typedef void(^ShoppingHeaderViewBlock)(FAShoppingSectionModel *model);


#define kShoppingHeaderViewHeight 44 *kAppScale
@interface FAShoppingHeaderView : UITableViewHeaderFooterView

@property(nonatomic,strong)FAShoppingSectionModel *sectionModel;


// 编辑的模式(传值必须在传Model之前)
@property(nonatomic,assign)BOOL isSelected;

// 是否隐藏选择的标题，区分订单复用和购物车复用
@property(nonatomic,assign)BOOL isHiddenSel;

@property(nonatomic,copy)ShoppingHeaderViewBlock headerViewBlock;

+(instancetype)updateWithHeaderTableView:(UITableView *)tableView;

@end
