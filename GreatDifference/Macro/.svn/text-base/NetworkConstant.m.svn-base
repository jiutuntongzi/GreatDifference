//
//  NetworkConstant.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/8.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "NetworkConstant.h"

@implementation NetworkConstant
/****************************   服务器地址   *************************/
//NSString *const FORMAL_BASE_URL            = @"http://www.douwong.com/xdel/spi/"; // 正式服务器

//NSString *const BASE_URL                   = @"http://120.77.60.223:9091/";
#if Test //测试
NSString *const BASE_URL                   = @"http://120.77.60.223:9011/";

NSString *const IMAGE_BASE_URL               = @"http://img.worldbigo.com/img";
NSString *const UPLOAD_IMAGE_URL             = @"http://api.worldbigo.com/icon/upload";
#else


NSString *const BASE_URL                   = @"http://api.worldbigo.com/";

NSString *const IMAGE_BASE_URL               = @"http://img.worldbigo.com/img";
NSString *const UPLOAD_IMAGE_URL             = @"http://api.worldbigo.com/icon/upload";
#endif

/****************************   登陆注册  *************************/
NSString *const url_login                   = @"buyer/mob/login";                //登陆
NSString *const url_thirdparth_login        = @"buyer/thirdpart/login";              //第三方登录
NSString *const url_register                = @"buyer/registe/mob";                //登陆
NSString *const url_third_register          = @"buyer/registe/thirdpart";         // 三方注册

NSString *const url_forget_password         = @"buyer/resetpwd";
NSString *const url_modify_password         = @"seller/view/updatepwd";     //修改密码
NSString *const url_send_message            = @"shortMsg/send";             //发送消息


/****************************   首页  *************************/

NSString *const url_home                       = @"buyer/index";
NSString *const url_location_city              = @"map/getCity";
NSString *const url_near_location              = @"map/getNearPoint";
NSString *const url_address_detail             = @"map/getAddress";
NSString *const url_get_sysMessage_list             = @"buyer/view/msg/find";

NSString *const url_shop_list                 = @"buyer/shop/list";                //获取店铺列表
NSString *const url_shop_overView             = @"buyer/shop/overview";   //店铺概览
NSString *const url_get_goods_list                 = @"buyer/product/type/find";                //获取商品列表

NSString *const url_life_type_list      = @"buyer/shop/type/child";                //获取生活服务类型列表

NSString *const url_shop_detail             = @"buyer/shop/detail";   //店铺详情
NSString *const url_collect_shop            = @"buyer/view/shop/collection/addOrDel";// 收藏店铺
NSString *const url_goods_detail            = @"buyer/product/detail";// 商品详情
NSString *const url_scan_qrCode            = @"buyer/product/serialno";// 扫条码商品详情

NSString *const url_collect_goods            = @"buyer/view/product/collection/addOrDel";// 收藏商品

NSString *const url_add_shopCart            = @"buyer/view/cart/add";// 添加到购物车
NSString *const url_get_shopCart_List       = @"buyer/view/cart/findAll";// 获取购物车
NSString *const url_delete_shopCart_goods       = @"/buyer/view/cart/delete";// 获取购物车
NSString *const url_purchase_goods       = @"buyer/view/order/outright/purchase";// 购买
NSString *const url_shoppingCart_purchase       = @"buyer/view/order/add";// 购物车购买
NSString *const url_pay_purchase        = @"buyer/view/order/toPay";// 支付
NSString *const url_integralPay_purchase       = @"buyer/view/order/payMoney";// 余额支付

NSString *const url_order_status_List       = @"order/state/find";// 订单状态列表


/****************************   我  *************************/

NSString *const url_unpay_num                = @"buyer/view/order/stat";     // 获取个人详情

NSString *const url_userInfo_detail                = @"buyer/view/profile/detail";     // 获取个人详情
NSString *const url_userInfo_modify         = @"buyer/view/profile/edit";       // 修改个人信息
NSString *const url_getIdCard_info          = @"buyer/view/idcard";             // 获取身份证信息
NSString *const url_modity_IdCard_info          = @"buyer/view/bind/idcard";             // 获取身份证信息
NSString *const url_bind_card               = @"buyer/view/bind/bank"; // 绑定银行卡
NSString *const url_binded_card_info        = @"buyer/view/bank"; // 已绑定银行卡的信息

NSString *const url_integral_detail         = @"buyer/view/integral";          // 积分

NSString *const url_integral_record         = @"buyer/view/integral/find";     // 积分使用记录
NSString *const url_my_invitation          = @"buyer/view/invication";     // 积分邀请函页面
NSString *const url_my_invitate_list          = @"buyer/view/invicate/list";     // 邀请人列表

NSString *const url_image_upload            = @"icon/upload"; // 图片上传接口

NSString *const url_wallet                  = @"buyer/view/money"; // 钱包

NSString *const url_cash_record              = @"/buyer/view/consume/find";// 现金消费记录列表

NSString *const url_encashment_apply         = @"buyer/view/encashment/add";     // 提现申请
NSString *const url_encashment_detail        = @"/buyer/view/encashment"; // 提现详细信息

NSString *const url_encashment_applyList     = @"buyer/view/encashment/find"; // 提现申请列表
NSString *const url_consignee_addressList    = @"buyer/view/consignee/findAll"; // 添加收件人地址

NSString *const url_add_consignee_address    = @"buyer/view/consignee/add"; // 添加收件人地址
NSString *const url_modify_consignee_address    = @"buyer/view/consignee/edit"; // 修改收件人地址

NSString *const url_delete_consignee_address    = @"buyer/view/consignee/delete"; // 删除收件人地址
NSString *const url_provinceCity_address        = @"map/getAddress"; // 删除收件人地址

NSString *const url_get_order_list    = @"buyer/view/order/find"; // 获取订单列表
NSString *const url_get_order_detail    = @"buyer/view/order/detail"; // 获取订单详情
NSString *const url_get_bigOrder_detail    = @"buyer/view/bigOrder/detail"; // 获取大订单详情
NSString *const url_unPay_order_detail     = @"buyer/view/order/unpay/toPay";

NSString *const url_delete_myOrder      = @"buyer/view/order/delete"; // 删除订单
NSString *const url_cancel_myOrder      = @"buyer/view/order/cancel"; // 取消订单
NSString *const url_cancel_bigOrder     = @"buyer/view/bigOrder/delete"; // 取消大订单
NSString *const url_delete_bigOrder_products    = @"buyer/view/bigOrder/product/delete"; // 删除大订单中的商品

NSString *const url_confirm_receiveOrder    = @"buyer/view/order/confirm"; // 确认收货
NSString *const url_evaluate_Order          = @"buyer/view/order/evalute"; // 评价订单

NSString *const url_refund_Order            = @"buyer/view/order/returned/add"; // 退货
NSString *const url_cancel_refund_Order     = @"buyer/view/order/returned/cancel"; // 取消退货

NSString *const url_express_list    = @"express/list"; // 快递列表


NSString *const url_add_leave_message         = @"buyer/view/leaveMsg/add"; // 添加留言
NSString *const url_reply_leave_message        = @"buyer/view/reply/add"; // 回复留言

NSString *const url_get_leave_messageList    = @"buyer/view/leaveMsg/find"; // 获取留言列表
NSString *const url_look_leaveMessage_detail        = @"buyer/view/leaveMsg/detail"; // 留言详情
//NSString *const url_reply_leave_message        = @"buyer/view/reply/add"; // 回复留言

NSString *const url_get_signIn_list        = @"buyer/view/sign/list"; // 获取签到信息
NSString *const url_signIn                 = @"buyer/view/sign"; // 签到

NSString *const url_collect_storeList      = @"/buyer/view/shop/collection/find"; // 获取店铺收藏列表

NSString *const url_collect_storeType      = @"buyer/view/shop/collection/type"; // 获取店铺收藏列表

NSString *const url_collect_goodsList              = @"buyer/view/product/collection/find";// 现金消费记录列表
@end
