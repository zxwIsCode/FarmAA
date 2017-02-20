//
//  EVMainHeader.h
//  ElectricVehicle
//
//  Created by 郑州动力无限科技 on 16/9/29.
//  Copyright © 2016年 郑州动力无限科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EVMainHeaderDelegate <NSObject>

@optional
- (void)chooseCommodity:(NSString *)goodtype withGoodID:(NSString *)goodID;
- (void)getHeaderHeight:(CGFloat)headerHeight;
@end

@interface EVMainHeader : UICollectionReusableView
@property (weak, nonatomic) id<EVMainHeaderDelegate> delegate;
@property (copy,nonatomic) NSMutableArray * itemArray;
//新品推荐以上视图
-(void)creatMainHeaderView;

@end
