//
//  NHBussinessCollectionViewCell.h
//  NearHouse
//
//  Created by 郑州动力无限科技 on 2016/10/21.
//  Copyright © 2016年 郑州动力无限科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHBussinessCollectionViewCell : UICollectionViewCell
/*
    头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
/*
    商品名字
 */
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;
/*
   价钱
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*
   批发价
 */
@property (weak, nonatomic) IBOutlet UILabel *wholePriceLabel;


@end
