//
//  FAClassifyCoCell.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAClassifyCoCell.h"

@interface FAClassifyCoCell ()

@property (nonatomic, strong) UILabel *itemLable;

@end

@implementation FAClassifyCoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.itemLable = [[UILabel alloc] initWithFrame:self.bounds];
        self.itemLable.font = [UIFont systemFontOfSize:13];
        self.itemLable.textAlignment = NSTextAlignmentCenter;
//        self.itemLable.backgroundColor =[UIColor orangeColor];
        [self.contentView addSubview:self.itemLable];
    }
    return self;
}

-(void)setSub2Model:(FAClassify2SubItemModel *)sub2Model {
    _sub2Model =sub2Model;
    self.itemLable.text =sub2Model.smallGcname;
}
@end
