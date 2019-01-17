//
//  PersonalHttpManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoResult;
@class CommonModelResult;
@class AddressListResult;
@class StoreModelListResult;
@class GoodsModelListResult;
@class IntegralModelResult;
@class IntegralRecordResult;
@class IDIdentifyModelResult;
@class OrderLIstResult;
@class SignInModelResult;
@class OrderDetailResult;
@class BigOrderDetailResult;
@class ExpressListResult;
@class InvitationModelResult;
@class BankCardResult;
@class MessageModelResult;
@class MessageDetailResult;
@class AddressDetailResult;
@class UnpayNumModelResult;
@class InviteListResult;

@interface PersonalHttpManager : NSObject
//获取未支付订单数量
+ (void)getUnpayNumWithParams:(NSDictionary *)params success:(void (^)(UnpayNumModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//获取消费者信息
+ (void)getUserInfoWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 修改信息
+ (void)modifyUserInfoWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 修改密码
+ (void)changePasswordWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//获取消费者身份证信息
+ (void)getUserIdIdentifyWithParams:(NSDictionary *)params success:(void (^)(IDIdentifyModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//修改消费者身份证信息
+ (void)modityUserIdIdentifyWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
//获取绑定的银行卡信息
+ (void)getBindCardInfoWithParams:(NSDictionary *)params success:(void (^)(BankCardResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//绑定银行卡
+ (void)bindCardWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
//获取消费者积分
+ (void)getUserIntegralWithParams:(NSDictionary *)params success:(void (^)(IntegralModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;


//获取消费者积分记录
+ (void)getUserIntegralRecordWithParams:(NSDictionary *)params success:(void (^)(IntegralRecordResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//获取邀请函
+ (void)getInvitationWithParams:(NSDictionary *)params success:(void (^)(InvitationModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//获取邀请人列表
+ (void)getInvitateUserListWithParams:(NSDictionary *)params success:(void (^)(InviteListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//获取我的钱包
+ (void)getWalletWithParams:(NSDictionary *)params success:(void (^)(IntegralModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//获取现金消费记录
+ (void)getCashRecordWithParams:(NSDictionary *)params success:(void (^)(IntegralRecordResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 修改密码
+ (void)modityPasswordWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 获取收件人地址列表
+ (void)getAddressListWithParams:(NSDictionary *)params success:(void (^)(AddressListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 添加收件人地址
+ (void)addConsigneeAddressWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 修改收件人地址
+ (void)modifyConsigneeAddressWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)deleteConsigneeAddressWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 获取订单列表
+ (void)getMyOrderListWithParams:(NSDictionary *)params success:(void (^)(OrderLIstResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 获取小订单详情
+ (void)getMyOrderDetailWithParams:(NSDictionary *)params success:(void (^)(OrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 获取大订单详情
+ (void)getMyBigOrderDetailWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
/**
 *  从未支付进入确认界面
 *
 *  @return
 */
// 获取未支付订单详情
+ (void)getUnPayOrderDetailWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 删除小订单
+ (void)deleteMyOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 取消小订单
+ (void)cancelMyOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 取消/删除大订单
+ (void)cancelBigOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 取消/删除大订单中的商品
+ (void)deleteBigOrderProductsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 确认收货
+ (void)confirmReceiveOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 评价订单
+ (void)evaluateOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//提现申请
+ (void)applyForWithdrawWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 退货申请
+ (void)refundOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 取消退货申请
+ (void)cancelRefundOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 获取快递公司列表
+ (void)getExpressListWithParams:(NSDictionary *)params success:(void (^)(ExpressListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 添加留言
+ (void)addLeaveMessageWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 回复留言
+ (void)replyLeaveMessageWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
// 获取留言列表
+ (void)getLeaveMessageListWithParams:(NSDictionary *)params success:(void (^)(MessageModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 获取指定信息详情
+ (void)getMessageDetailWithParams:(NSDictionary *)params success:(void (^)(MessageDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error)) failure;

// 根据经纬度获取省市区地址信
+ (void)getProvinceCityWithParams:(NSDictionary *)params success:(void (^)(AddressDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error)) failure;

// 获取签到信息
+ (void)getSignInfoWithParams:(NSDictionary *)params success:(void (^)(SignInModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 签到
+ (void)SignInWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 获取收藏店铺类型列表
+ (void)getCollectStoreTypeListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getCollectStoreListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getCollectGoodsListWithParams:(NSDictionary *)params success:(void (^)(GoodsModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

//上传图片
+ (void)uploadHeadImageWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;


@end
