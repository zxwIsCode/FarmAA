//
//  FAMyCollectionTableViewCell.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/11.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyCollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *commotidyName;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
