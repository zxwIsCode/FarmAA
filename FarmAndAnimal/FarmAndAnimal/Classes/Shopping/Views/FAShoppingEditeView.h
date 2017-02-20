//
//  FAShopingEditeView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAShoppingItemModel.h"
#import "FACommotidyModel.h"


@interface FAShoppingEditeView : UIView

@property(nonatomic,strong)FACommotidyModel *itemModel;

// 编辑的模式
@property(nonatomic,assign)BOOL isSelected;

-(instancetype)initShoppingEditeView:(CGRect)frame;
@end
