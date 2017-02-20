//
//  FAShoppingSelectedManager.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingSelectedManager.h"
#import "FAShoppingSectionModel.h"
#import "FAShoppingItemModel.h"


@interface FAShoppingSelectedManager ()

// 所有的数据源
@property(nonatomic,strong)NSMutableArray *allDataSource;
// 分区Title的数据源
@property(nonatomic,strong)NSMutableArray *sectionTitleArr;

@end

@implementation FAShoppingSelectedManager
// 获得所有的选择后的对象
- (NSMutableArray *)getAllSelectedData {
    NSMutableArray *originalArr =self.allDataSource;
    for (int index =0; index <originalArr.count; index ++) {
        FAShoppingSectionModel *sectionModel =self.allDataSource[index];
        sectionModel.isSecSelected =YES;
        NSArray *allItemArr =sectionModel.allItemArray;
        for (int j =0; j<allItemArr.count; j ++) {
            FAShoppingItemModel *itemModel =allItemArr[j];
            itemModel.isItemSelected =YES;
            itemModel.isReviseCount =YES;
        }
    }
    self.allDataSource = originalArr;
    return self.allDataSource;
    
}
// 获得所有的正常对象
- (NSMutableArray *)getAllPhotos {
    
    NSMutableArray *originalArr =self.allDataSource;
    for (int index =0; index <originalArr.count; index ++) {
        FAShoppingSectionModel *sectionModel =self.allDataSource[index];
        sectionModel.isSecSelected =NO;
        NSArray *allItemArr =sectionModel.allItemArray;
        for (int j =0; j<allItemArr.count; j ++) {
            FAShoppingItemModel *itemModel =allItemArr[j];
            itemModel.isItemSelected =NO;
//            itemModel.isReviseCount =NO;
        }
    }
    self.allDataSource = originalArr;
    return self.allDataSource;
}
// 网络第一次请求数据等
- (void)requestAllItems {
    
#warning 假数据开始
    self.sectionTitleArr =[@[@"胖子➕专用",@"廋子➕专用",@"人妖➕专用",@"🐖债➕专用",] mutableCopy];
    
    for (int index =0; index <2; index ++) {
//        FAShoppingSectionModel *sectionModel =[FAShoppingSectionModel updateShoppingSectionModelWithDic:nil];
//        sectionModel.seller =[NSString stringWithFormat:@"%@_%d个",sectionModel.seller,index];
//        [self.allDataSource addObject:sectionModel];
        
        FAShoppingSectionModel *sectionModel =[FAShoppingSectionModel updateShoppingSectionModelWithDic:nil];
        [self.allDataSource addObject:sectionModel];
    }
    // 获取成功之后通知界面更新列表
    if (self.selectedManagerBlock) {
        self.selectedManagerBlock(self.allDataSource ,YES);
    }
    return ;
    
#warning 假数据结束

    
    CMHttpRequestModel *paramsModel =[[CMHttpRequestModel alloc]init];
    paramsModel.appendUrl =kCart_CartList;
    paramsModel.type =CMHttpType_GET;
    // 包装参数设置
    WS(ws);
    [paramsModel.paramDic setObject:@"1" forKey:@"userid"];
    
    
    paramsModel.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result) {
            if (result.state == CMReponseCodeState_Success) {// 成功,做自己的逻辑
                DDLog(@"%@",result.data);
//                if (result.alertMsg) {
//                    [DisplayHelper displaySuccessAlert:result.alertMsg];
//                }else {
//                    [DisplayHelper displaySuccessAlert:@"获取购物车列表成功哦！"];
//                }
                NSArray *infoArr =(NSArray *)result.data;
                
                for (NSDictionary *infoDic in infoArr) {
                    FAShoppingSectionModel *sectionModel =[FAShoppingSectionModel updateShoppingSectionModelWithDic:infoDic];
                    [self.allDataSource addObject:sectionModel];
                }
                
                // 获取成功之后通知界面更新列表
                if (self.selectedManagerBlock) {
                    self.selectedManagerBlock(self.allDataSource ,YES);
                }
                return ;
                
            }else {// 失败,弹框提示
                
                DDLog(@"%@",result.error);
                if (result.alertMsg) {
                    [DisplayHelper displayWarningAlert:result.alertMsg];
                    
                }else {
                    [DisplayHelper displayWarningAlert:@"请求成功,但没有数据哦!"];
                }
            }
        }else {
            
            [DisplayHelper displayWarningAlert:@"网络异常，请稍后再试!"];
            
        }
        if (self.selectedManagerBlock) {
            self.selectedManagerBlock(nil ,NO);
        }

        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:paramsModel];
    
}
// 选择或取消某个分区，更改数据源状态
-(void)selectedSection:(NSInteger)section {
    NSMutableArray *originalArr =self.allDataSource;
    FAShoppingSectionModel *sectionModel =self.allDataSource[section];
//    sectionModel.isSecSelected =!sectionModel.isSecSelected;
    for (FACommotidyModel *model in sectionModel.allItemArray) {
        model.isItemSelected =sectionModel.isSecSelected;
    }
    self.allDataSource = originalArr;

}
// 选择某个item ，更改数据源状态
-(void)selectedItem:(NSIndexPath *)indexPath {
    NSMutableArray *originalArr =self.allDataSource;
    if (indexPath.section <originalArr.count) {
        FAShoppingSectionModel *sectionModel =self.allDataSource[indexPath.section];
        if (indexPath.row <sectionModel.allItemArray.count) {
            FAShoppingItemModel *itemModel =sectionModel.allItemArray[indexPath.row];
            itemModel.isItemSelected =!itemModel.isItemSelected;
        }
    }
    self.allDataSource = originalArr;

}

// 取消所有的编辑状态
- (void)cancelAllEditStatus {
    NSMutableArray *originalArr =self.allDataSource;
    for (int index =0; index <originalArr.count; index ++) {
        FAShoppingSectionModel *sectionModel =self.allDataSource[index];
        sectionModel.isSecSelected =NO;
        NSArray *allItemArr =sectionModel.allItemArray;
        for (int j =0; j<allItemArr.count; j ++) {
            FAShoppingItemModel *itemModel =allItemArr[j];
            itemModel.isItemSelected =NO;
            itemModel.isReviseCount =NO;
        }
    }
    self.allDataSource = originalArr;
}

-(NSMutableArray *)allDataSource {
    if (!_allDataSource) {
        _allDataSource =[NSMutableArray array];
    }
    return _allDataSource;
}
-(NSMutableArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr =[NSMutableArray array];
    }
    return _sectionTitleArr;
}
@end
