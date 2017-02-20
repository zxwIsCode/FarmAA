//
//  FABalanceTableViewCell.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/18.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FABalanceTableViewCell.h"

@implementation FABalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.circleLabel.layer.cornerRadius = 25.0f;
    self.circleLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
