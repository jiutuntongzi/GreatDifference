//
//  ShoppingHttpManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsModelResult;
@class StoreModelListResult;
@class CommonModelResult;
@class BigOrderDetailResult;
@class PayOrderResult;
@class WeChatOrderResult;

@interface ShoppingHttpManager : NSObject
/**
 *  获取购物车列表
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)getShopCartListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  删除购物车商品
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)deleteShopCartGoodsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  在商品详情里购买商品
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)purchaseGoodsWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
/**
 *  在购物车里点击结算下单
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)shoppingCartPurchaseGoodsWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  点击支付宝去支付
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)getAlipayPayGoodsWithParams:(NSDictionary *)params success:(void (^)(PayOrderResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  点击微信去支付
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)getWeChatPayGoodsWithParams:(NSDictionary *)params success:(void (^)(WeChatOrderResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  用分润去支付
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)IntegralPayGoodsWithParams:(NSDictionary *)params success:(void (^)(PayOrderResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  获取支付宝参数
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
//+ (void)getAlipayPayGoodsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

@end
