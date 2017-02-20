//
//  FAShoppingDownModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAShoppingDownModel : NSObject


// 总价格为多少
@property(nonatomic,copy)NSString *totolPriceStr;
// 是否显示总价格
@property(nonatomic,assign)BOOL isHaveTotolPrice;
// 删除还是结算按钮
@property(nonatomic,copy)NSString *rightStr;

@end
