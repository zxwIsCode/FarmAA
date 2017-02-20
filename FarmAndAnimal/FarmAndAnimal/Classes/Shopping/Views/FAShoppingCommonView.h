//
//  FAShoppingCommonView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "FAShoppingItemModel.h"

#import "FACommotidyModel.h"

@interface FAShoppingCommonView : UIView
-(instancetype)initShoppingCommonView:(CGRect)frame;
@property(nonatomic,strong)FACommotidyModel *itemModel;


@end
