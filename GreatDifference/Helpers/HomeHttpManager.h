//
//  HomeHttpManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BannerModelResult;
@class UserLocationResult;
@class AddressListResult;
@class StoreModelListResult;
@class StoreOverViewResult;
@class AddressDetailResult;
@class StoreModelResult;
@class CommonModelResult;
@class GoodsModelResult;
@class GoodsModelListResult;
@class MessageModelResult;
@class OrderStatusResult;

@interface HomeHttpManager : NSObject
/**
 *  获取首页轮播图片
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void (^)(BannerModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getStoreListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
+ (void)getStoreOverViewWithParams:(NSDictionary *)params success:(void (^)(StoreOverViewResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

/**
 *  获取某个类型的商品列表
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getGoodsListWithParams:(NSDictionary *)params success:(void (^)(GoodsModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getLifeServiceTypeListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getStoreDetailWithParams:(NSDictionary *)params success:(void (^)(StoreModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)collectStoreWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 获取商品详情
+ (void)getGoodsDetailWithParams:(NSDictionary *)params success:(void (^)(GoodsModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 扫条码获取详情
+ (void)scanQrcodeGetDetailWithParams:(NSDictionary *)params success:(void (^)(GoodsModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)collectGoodsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 添加到购物车
+ (void)addShopCartWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getCurrentCityWithParams:(NSDictionary *)params success:(void (^)(UserLocationResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

// 获取系统消息
+ (void)getSystemMessageListWithParams:(NSDictionary *)params success:(void (^)(MessageModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getNearLocationWithParams:(NSDictionary *)params success:(void (^)(AddressListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getAddressDetailWithParams:(NSDictionary *)params success:(void (^)(AddressDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;


/**
 *  获取订单状态列表
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getOrderStatusListWithParams:(NSDictionary *)params success:(void (^)(OrderStatusResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
@end
