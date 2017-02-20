//
//  FASectionView.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FASectionViewDelegate <NSObject>

@optional
- (void)chooseSection:(NSInteger)section upAndDown:(NSInteger)upDown;

@end

@interface FASectionView : UIView
@property (weak, nonatomic) id<FASectionViewDelegate> delegate;
@end
