//
//  FAShoppingNormalDownView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FAShoppingDownModel.h"

#define kSelectedAllSuperViewHeight 54 *kAppScale

typedef void(^ShoppingDownViewBlock)(UIButton *btn);

@interface FAShoppingDownView : UIView

@property(nonatomic,strong)FAShoppingDownModel *downModel;

@property(nonatomic,copy)ShoppingDownViewBlock downViewBlock;

+(instancetype)NormalDownView;
@end
