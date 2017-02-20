//
//  FATalkTableViewCell.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FATalkTableViewCell.h"

@implementation FATalkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImg.frame = CGRectMake(_headImg.frame.origin.x, _headImg.frame.origin.y, 11*kAppScale, 11*kAppScale);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
