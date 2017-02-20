//
//  FAAddressTableViewCell.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAAddressTableViewCell.h"

@implementation FAAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_chooseNormalBtn setImage:ImageNamed(@"icon_dizhiweixuan") forState:UIControlStateNormal];
    [_chooseNormalBtn setImage:ImageNamed(@"icon_dizhixuan") forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
