//
//  CMHDemoDefine.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 李保东. All rights reserved.
//


/*************Test测试HTTP**************/
/*************首页**************/

NSString *const kHome_GetCarousel = @"/Api/GetCarousel"; // 首页轮播图接口
NSString *const kHome_GetHomeClassify = @"/Classify/GetHomeClassify"; // 获取Home界面分类接口
NSString *const kGood_GetGoodListData = @"/Goods/GetGoods"; // 产品列表

/*************商家、商品*************/
NSString *const kSelling_GetHotGoods = @"/Goods/GetHotGoods";// 获得热销产品
NSString *const kSelling_GetNewTJGoods = @"/Goods/GetNewTJGoods";// 获得推荐产品
NSString *const kSelling_SetGoodsHouse = @"/Goods/SetGoodsHouse";  //将某个商品收藏
NSString *const kSelling_GetGoodsHouse = @"/Goods/GetGoodsHouse";  //获取某个商品是否被收藏
NSString *const kSelling_GetRate = @"/Goods/GetRate";  // 获取评价
/*************收货地址**************/
NSString *const kAddress_AddressList = @"/Address/GetAddress"; // 收货地址列表
NSString *const kAddress_AddressUpdate = @"Address/RenewAddress"; // 修改收货地址
NSString *const kAddress_AddressDelete = @"/Address/DelAddress"; // 删除收货地址
NSString *const kAddress_RisenAddress = @"/Address/NewlyAdded"; // 新增收货地址
NSString *const kAddress_SetDefault = @"/Address/SetDefault"; // 设置默认地址
/*************用户信息操作**************/
NSString *const kLogin_FindUserPassword = @"/AppLogin/FindUPwd"; // 找回密码
NSString *const kLogin_AppRegister = @"/Register/UserRegister"; // 注册
NSString *const kLogin_RegisterPhoneCode = @"/SendMessage/SendMsg"; // 发送验证码
NSString *const kLogin_AppLogin = @"/AppLogin/ULogin"; // 登录
NSString *const kUsers_UpdateUserPas = @"/AppLogin/UpUserPwd"; //修改密码
NSString *const kUsers_UpdateUserPayPas = @"/UpdateUserPayPas"; //修改支付密码
NSString *const kUsers_UploadUserPhoto = @"/AppLogin/UploadUserPhoto"; //上传头像
NSString *const kUsers_UpdateUserInfo = @"/AppLogin/UpdateUserNick"; //修改用户信息
NSString *const kGoods_MyHouse = @"/Goods/MyHouse"; //我的收藏
// 用户信息
NSString *const kUsers_GetUserInfo = @"/AppLogin/GetUserInfo"; //获取用户信息接口


/*************分类*************/
NSString *const kClassify_GetGoodsTypeInfo = @"/Classify/GetClassify"; // 获取主界面分类接口

/*************购物车*************/
NSString *const kCart_JoinCart = @"/Cart/JoinCart"; // 商品加入购物车

NSString *const kCart_CartList = @"/Cart/CartList"; // 获取购物车列表


