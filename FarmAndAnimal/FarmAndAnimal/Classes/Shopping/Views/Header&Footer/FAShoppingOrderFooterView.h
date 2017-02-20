//
//  FAShoppingOrderFooterView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAShoppingSectionModel.h"

#define kShoppingOrderFooterViewHeight 150 *kAppScale

@interface FAShoppingOrderFooterView : UITableViewHeaderFooterView

@property(nonatomic,strong)FAShoppingSectionModel *sectionModel;

+(instancetype)updateWithFooterTableView:(UITableView *)tableView;


@end
