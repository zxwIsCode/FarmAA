//
//  FASectionView.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FASectionView.h"

@implementation FASectionView
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSArray * titleArr = @[@"综合排序",@"销量",@"价格"];
    for (int i = 0;i<titleArr.count;i++){
        
        UIImageView * downImg = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_gwxjiantou")];
        UIImage * upimg = [[UIImage alloc] init];
        upimg  =  [self turnImage:downImg.image];
        
        UIButton * button = [CMCustomViewFactory createButton:CGRectMake(i*(SCREEN_WIDTH-2)/3, 0,(SCREEN_WIDTH-2)/3, NavigationBar_HEIGHT) title:[titleArr objectAtIndex:i] normalImage:downImg.image selectImage:upimg];
        button.tag = 100+i;
        [self initButton:button];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f*kAppScale];
        [button addTarget:self action:@selector(downTurnAround:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
}
-(void)initButton:(UIButton*)btn{
    
    // 按钮图片和标题总高度
    CGFloat totalHeight = (btn.imageView.frame.size.width + btn.titleLabel.frame.size.width);
    // 设置按钮图片偏移
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,totalHeight - btn.imageView.frame.size.width, 0.0, -btn.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn.imageView.frame.size.width, 0,totalHeight - btn.titleLabel.frame.size.width)];
}

-(void)downTurnAround:(id)sender
{
    NSInteger upAndDown = 2;
    UIButton * button = (UIButton *)sender;
    if (button.isSelected==NO) {
        button.selected = YES;
        upAndDown = 2;
    }else{
        button.selected = NO;
        upAndDown = 1;
    }
    if ([self.delegate respondsToSelector:@selector(chooseSection:upAndDown:)]) {
        [_delegate chooseSection:button.tag upAndDown:upAndDown];
    }
}
- (UIImage *)turnImage:(UIImage *)image
{
    long double rotate = 0.0;
    CGRect rect;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    rotate = M_PI;
    rect = CGRectMake(0, 0, image.size.width, image.size.height);
    float      translateX = -rect.size.width;
    float      translateY = -rect.size.height;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
@end
