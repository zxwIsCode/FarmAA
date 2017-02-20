//
//  FABalanceView.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/18.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FABalanceViewDelegate <NSObject>

@optional
-(void)alertPersonView;
- (void)chooseSection:(NSInteger)index;
@end

@interface FABalanceView : UIView
@property (weak, nonatomic) id<FABalanceViewDelegate> delegate;
@property (strong,nonatomic)NSArray * titleArr;
@end
