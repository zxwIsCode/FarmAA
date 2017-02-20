//
//  FAShoppingSectionModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FACommotidyModel.h"

@interface FAShoppingSectionModel : NSObject

// 是否是选择状态
@property(nonatomic,assign)BOOL isSecSelected;

// 商家名字
@property(nonatomic,copy)NSString *seller;
// 商家id
@property(nonatomic,copy)NSString *sellerid;

// 商品模型
@property(nonatomic,strong)FACommotidyModel *commotidyModel;


// 区头
//@property(nonatomic,copy)NSString *sectionTitleStr;

//以下5个为区脚

////运费
//@property(nonatomic,copy)NSString *transportationMoney;
////配送方式
//@property(nonatomic,copy)NSString *transportationWay;
//卖家留言
@property(nonatomic,copy)NSString *sellerMessage;
// 商品数量
@property(nonatomic,copy)NSString *goodsCount;
// 总价格
@property(nonatomic,copy)NSString *totolMoney;




@property(nonatomic,strong)NSMutableArray *allItemArray;

+(instancetype)updateShoppingSectionModelWithDic:(NSDictionary *)dic;

-(instancetype)initShoppingSectionModelWithDic:(NSDictionary *)dic;
@end
