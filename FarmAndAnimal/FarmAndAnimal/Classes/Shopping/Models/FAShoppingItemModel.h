//
//  FAShoppingItemModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAShoppingItemModel : NSObject

//@property(nonatomic,copy)NSString *detailStr;  //gname
//
//@property(nonatomic,copy)NSString *weightStr;  //sc
//
//@property(nonatomic,copy)NSString *priceStr; //gp
//
//@property(nonatomic,copy)NSString *goodsImage; //gpo
// 购买的数量
@property(nonatomic,assign)NSInteger goodsCount;  //

// 选中的规格在数组中的位置
@property(nonatomic,assign)NSInteger goodsFormatCount;

// 这个规格或者数量是否修改过
@property(nonatomic,assign)BOOL isEditeItem;

#warning 注意区分isReviseCount 和 isItemSelected
// 是否要编辑数量等
@property(nonatomic,assign)BOOL isReviseCount;

// 是否是选中的状态
@property(nonatomic,assign)BOOL isItemSelected;

+(instancetype)updateShoppingItemModelWithDic:(NSDictionary *)dic;

-(instancetype)initShoppingItemModelWithDic:(NSDictionary *)dic;

@end
