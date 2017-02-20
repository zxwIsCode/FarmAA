//
//  FAShoppingFirmOrderDownView.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFirmOrderDownSuperViewHeight 54 *kAppScale

typedef void(^ShoppingFirmOrderDownViewBlock)(NSInteger clickIndex);

@interface FAShoppingFirmOrderDownView : UIView
@property(nonatomic,copy)ShoppingFirmOrderDownViewBlock firmOrderDownBlock;

+(instancetype)FirmOrderDownView;
@end
