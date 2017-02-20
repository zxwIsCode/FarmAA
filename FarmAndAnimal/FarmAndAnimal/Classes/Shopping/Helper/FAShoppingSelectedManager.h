//
//  FAShoppingSelectedManager.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShoppingSelectedManagerBlock)(NSMutableArray *allDataArr,BOOL isSuceess);


@interface FAShoppingSelectedManager : NSObject

@property(nonatomic,copy)ShoppingSelectedManagerBlock selectedManagerBlock;


//- (void)deletePhotoFinished;

// 获得所有的选择后的对象
- (NSMutableArray *)getAllSelectedData;
// 获得所有的正常对象
- (NSMutableArray *)getAllPhotos;

// 网络第一次请求数据等
- (void)requestAllItems;

// 选择或取消某个分区，更改数据源状态
-(void)selectedSection:(NSInteger)section;
// 选择某个item ，更改数据源状态
-(void)selectedItem:(NSIndexPath *)indexPath;

// 取消所有的编辑状态
- (void)cancelAllEditStatus;
@end
