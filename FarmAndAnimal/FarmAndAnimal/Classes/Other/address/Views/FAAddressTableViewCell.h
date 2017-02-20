//
//  FAAddressTableViewCell.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAAddressTableViewCell : UITableViewCell
/*
 名字＋手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
/*
 地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
/*
 删除
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteByn;
/*
 编辑
 */
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
/*
 默认地址
 */
@property (weak, nonatomic) IBOutlet UIButton *chooseNormalBtn;
/*
 手机号
 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@end
