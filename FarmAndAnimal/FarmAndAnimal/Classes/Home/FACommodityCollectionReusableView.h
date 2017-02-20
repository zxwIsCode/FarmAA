//
//  FACommodityCollectionReusableView.h
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FACommodityCollectionReusableViewDelegate <NSObject>
-(void)enterReadAllTalk;
@optional
@end

@interface FACommodityCollectionReusableView : UICollectionReusableView<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property (strong,nonatomic)NSMutableArray * listArray;
@property (strong,nonatomic)UITableView * tableView;
@property (strong,nonatomic)UIWebView * webView;
@property (strong,nonatomic)NSString * commodityName;
@property (strong,nonatomic)NSString * money;
@property (strong,nonatomic)NSString * saleNum;
@property (strong,nonatomic)NSString * uniprice;
@property (strong,nonatomic)NSString * talkcount;
@property (strong,nonatomic)NSString * webUrl;
@property (weak, nonatomic) id<FACommodityCollectionReusableViewDelegate> delegate;
-(void)reloadRate;
@end
