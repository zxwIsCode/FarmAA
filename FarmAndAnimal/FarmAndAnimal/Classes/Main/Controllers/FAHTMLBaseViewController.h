//
//  FAHTMLBaseViewController.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "CMBaseViewController.h"

@interface FAHTMLBaseViewController : CMBaseViewController
@property (nonatomic,copy)NSString * titleStr;
/**
 *  加载一个本地的html文件
 *
 *  @param path 文件路径
 */
- (void)setHtmlFilePath:(NSString *)path;
/**
 *  加载html string
 */
- (void)setHtmlStr:(NSString *)htmlStr;
/**
 *  加载一个url
 */
- (void)setUrl:(NSString *)url;
@end
