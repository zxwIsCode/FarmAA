//
//  CMHDemoDefine.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 李保东. All rights reserved.
//


/*************Test测试HTTP**************/

#define kTestHttpHost @"http://192.168.3.186/nmt"
/*************首页**************/

UIKIT_EXTERN NSString *const kHome_GetCarousel; // 首页轮播图接口
UIKIT_EXTERN NSString *const kGood_GetGoodListData; // 产品列表接口

UIKIT_EXTERN NSString *const kHome_GetHomeClassify; // 获取Home界面分类接口

/*************商品、商家**************/

UIKIT_EXTERN NSString *const kSelling_GetHotGoods;  //获得热销产品
UIKIT_EXTERN NSString *const kSelling_GetNewTJGoods;  //获得推荐产品
UIKIT_EXTERN NSString *const kSelling_SetGoodsHouse;  //将某个商品收藏
UIKIT_EXTERN NSString *const kSelling_GetGoodsHouse;  //获取某个商品是否被收藏
UIKIT_EXTERN NSString *const kSelling_GetRate;  // 获取评价

/*************收货地址**************/
UIKIT_EXTERN NSString *const kAddress_AddressList; // 收货地址列表
UIKIT_EXTERN NSString *const kAddress_AddressUpdate; //保存地址
UIKIT_EXTERN NSString *const kAddress_AddressDelete; //删除地址
UIKIT_EXTERN NSString *const kAddress_RisenAddress; //新增地址
UIKIT_EXTERN NSString *const kAddress_SetDefault; // 设置默认地址

/*************登录注册找回密码**************/

UIKIT_EXTERN NSString *const kLogin_FindUserPassword; //找回密码
UIKIT_EXTERN NSString *const kLogin_AppRegister; //注册
UIKIT_EXTERN NSString *const kLogin_RegisterPhoneCode; //注册验证码
UIKIT_EXTERN NSString *const kLogin_AppLogin; //登录
UIKIT_EXTERN NSString *const kUsers_UpdateUserPas; //修改密码
UIKIT_EXTERN NSString *const kUsers_UpdateUserPayPas; //修改支付密码
UIKIT_EXTERN NSString *const kUsers_UploadUserPhoto; //上传头像
UIKIT_EXTERN NSString *const kUsers_UpdateUserInfo; //修改用户信息

UIKIT_EXTERN NSString *const kGoods_MyHouse; //我的收藏
UIKIT_EXTERN NSString *const kUsers_GetUserInfo; // 获取用户信息
/*************分类*************/
UIKIT_EXTERN NSString *const kClassify_GetGoodsTypeInfo; // 获取主界面分类接口

/*************购物车*************/
UIKIT_EXTERN NSString *const kCart_JoinCart; // 商品加入购物车

UIKIT_EXTERN NSString *const kCart_CartList; // 获取购物车列表



#define kTabBarButtonBaseTag 100

