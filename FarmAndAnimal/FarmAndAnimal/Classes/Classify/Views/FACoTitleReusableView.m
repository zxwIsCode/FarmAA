//
//  FACoTitleReusableView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FACoTitleReusableView.h"

@implementation FACoTitleReusableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSLog(@"%@",NSStringFromCGRect(frame));
        self.backgroundColor = RGBACOLOR(240, 240, 240, 0.8);
        self.sectionLable = [[UILabel alloc] initWithFrame:self.bounds];
        self.sectionLable.font = [UIFont systemFontOfSize:14 *kAppScale];
        self.sectionLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.sectionLable];
    }
    return self;
}

@end
