//
//  FAPersonalView.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FAPersonalViewDelegate <NSObject>

@optional
-(void)alertPersonView;
- (void)chooseCommodity:(NSInteger)tag;
@end
@interface FAPersonalView : UIView
@property (nonatomic,copy) NSString * photo;
@property (nonatomic,copy) NSString * phone;

@property (weak, nonatomic) id<FAPersonalViewDelegate> delegate;
@end
