//
//  FAShoppingMinHeaderView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAShoppingSectionModel.h"

#import "FAAddressModel.h"

#import "FAShoppingPlaceView.h"

#define kShoppingMinHeaderViewHeight 144 *kAppScale

typedef void(^ShoppingClickPlace)(NSInteger clickIndex);


@interface FAShoppingMinHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)FAShoppingSectionModel *sectionModel;

@property(nonatomic,strong)FAAddressModel *addressModel;


+(instancetype)updateWithHeaderTableView:(UITableView *)tableView;

// 为添加手势做准备
@property(nonatomic,strong)FAShoppingPlaceView *placeView;

@property(nonatomic,copy)ShoppingClickPlace clickPlaceBlock;



@end
