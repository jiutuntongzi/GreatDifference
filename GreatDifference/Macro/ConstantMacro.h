//
//  ConstantMacro.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#ifndef ConstantMacro_h
#define ConstantMacro_h

#ifdef DEBUG
#define     XGLog(...)      NSLog(__VA_ARGS__)

#else
#define     XGLog(...)
#endif

/******************************   尺寸及颜色   *****************************/
#define SCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT           ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE_4              (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)480)<DBL_EPSILON)     //4S 或者4

#define IS_IPHONE_5              (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)568)<DBL_EPSILON)
//
#define IS_IPHONE_6S              (fabs((double)[UIScreen mainScreen].bounds.size.height - 667)<DBL_EPSILON)

#define IS_IPHONE_6SPlus          (fabs((double)[UIScreen mainScreen].bounds.size.height - 736)<DBL_EPSILON)

#define XGCOLOR(r,g,b)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kFirstLaunch                 @"firstLaunch"
#define CURRENT_VERSION              @"CFBundleVersion"     //当前版本
#define kApp_URL                     @"http://itunes.apple.com/lookup?id="
#define kAppId                       @"1227301547" //1139634548  795636922 1227301547
// 输入的格式 为0XFFFFFF
//#define kColorWithRGB(rgbValue) \
//[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
//                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
//                 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define XGFONT(s)               [UIFont systemFontOfSize:(s)]
#define THEMECOLOR              XGCOLOR(252, 139, 0)        // 主题色
#define kSpace                  10
#define LineColor               [[UIColor lightGrayColor]colorWithAlphaComponent:0.75]
/******************************    通知   *****************************/

#define KNOTIFICATION_SHOPCART_CANCEL_ALL       @"notification_shopcart_cancel_all" // 取消全选
#define KNOTIFICATION_SHOPCART_SELECT_ALL       @"notification_shopcart_select_all" // 全选

// 地图位置通知
#define KNOTIFICATION_UPDATE_LOCATION           @"notification_update_location" // 更新用户位置

#define KNOTIFICATION_UPDATE_USERHEAD           @"notification_update_userHead" // 用户方向更新
#define KNOTIFICATION_UPDATE_USERINFO           @"notification_update_userInfo" // 用户信息更新

#define KNOTIFICATION_UPDATE_CONTACT_ADDRESS    @"notification_update_contact_address" // 更新用户地址

#define KNOTIFICATION_LOCATION_FAIL             @"notification_location_fail" // 定位失败
#define kNOTIFICATION_CHARGE_SUCCESS                @"kn_charge_success"// 支付成功

#define kNOTIFICATION_CHARGE_FINISH                 @"kn_charge_finish"

#define kNOTIFICATION_CHARGE_CANCEL_PAY             @"cancel_pay"

#define kNOTIFICATION_CHARGE_FAIL                   @"charge_fail"  // 订单支付失败

#define KNOTIFICATION_USE_INTEGRAL                  @"use_integral"

/******************************    订单通知   *****************************/
#define KNOTIFICATION_REFRESH_ALL_ORDERS                  @"refreshAllOrders"   //刷新全部订单列表

#define KNOTIFICATION_REFRESH_WAIT_ORDERS                  @"refreshWaitPayOrders"   //刷新待支付订单列表

#define KNOTIFICATION_REFRESH_WAIT_RECEIVE_ORDERS          @"refreshWaitReceiveOrders"   //刷新待收货订单列表

#define KNOTIFICATION_REFRESH_HAD_RECEIVE                  @"refreshHadReceiveOrders"   //刷新已收货订单列表

#define KNOTIFICATION_REFRESH_REFUND_ORDERS                  @"refreshRefundOrders"   //刷新退款退货订单列表

#define KNOTIFICATION_REFRESH_FINISH_ORDERS                  @"refreshFinishOrders"   //刷新已完成订单列表

/******************************    存储的key   *****************************/
#define Access_token                        @"access_token"
#define LoginState                          @"loginState"
#define CurrentLongitude                    @"current_longitude"
#define CurrentLatitude                     @"current_latitude"
#define SearchStoreHistory                  @"searchStoreHistory"

/******************************    其他   *****************************/
#define MyUserDefaults              [NSUserDefaults standardUserDefaults]
#define WS(type)                __weak typeof(type) weak##type  = type


typedef NS_ENUM(NSInteger, CellType) {
    CellTypeNormal,             //title detailLabel形式
    CellTypeAvatar,
    CellTypePicker,
    CellTypeqrCode,             // 有二维码图标的
};

#endif /* ConstantMacro_h */
