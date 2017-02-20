//
//  FAMyAddressManagerViewController.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "CMBaseViewController.h"

@interface FAMyAddressManagerViewController : CMBaseViewController
-(void)getAddressWithID:(NSString *)addressID withName:(NSString *)addressName withPhone:(NSString*)phone withPeople:(NSString *)name withFlag:(NSInteger)flag withRemarks:(NSString*)remarks;
@end
