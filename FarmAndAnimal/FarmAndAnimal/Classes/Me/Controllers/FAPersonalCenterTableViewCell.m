//
//  FAPersonalCenterTableViewCell.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/10.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAPersonalCenterTableViewCell.h"

@implementation FAPersonalCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userInfoImg.frame = CGRectMake(_userInfoImg.frame.origin.x, _userInfoImg.frame.origin.y, 18*kAppScale, 18*kAppScale);
    self.backJianImg.frame = CGRectMake(_backJianImg.frame.origin.x, _backJianImg.frame.origin.y, 4*kAppScale, 7*kAppScale);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
