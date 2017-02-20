//
//  EVbtnAndText.h
//  ElectricVehicle
//
//  Created by 郑州动力无限科技 on 16/9/29.
//  Copyright © 2016年 郑州动力无限科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVbtnAndText : UIView
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UIButton * titleBtn;
@property (nonatomic,assign)BOOL isUrl;
- (void)createBtnAndTitle:(NSString  *)iconImage title:(NSString *)title titleColor:(UIColor *)titlecolor;
@end
