//
//  ShoppingHttpManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShoppingHttpManager.h"
#import "XGHttpManager.h"
#import "MJExtension.h"

#import "GoodsModelResult.h"
#import "StoreModelListResult.h"
#import "CommonModelResult.h"
#import "BigOrderDetailResult.h"
#import "BigOrderDetailResult.h"
#import "PayOrderResult.h"
#import "WeChatOrderResult.h"

@implementation ShoppingHttpManager

/**
 *  获取购物车列表
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)getShopCartListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_shopCart_List params:params success:^(id response) {
        StoreModelListResult *result = [StoreModelListResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

/**
 *  删除购物车商品
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)deleteShopCartGoodsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_delete_shopCart_goods params:params success:^(id response) {
        CommonModelResult *result = [CommonModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)purchaseGoodsWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_purchase_goods params:params success:^(id response) {
        BigOrderDetailResult *result = [BigOrderDetailResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)shoppingCartPurchaseGoodsWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_shoppingCart_purchase params:params success:^(id response) {
        BigOrderDetailResult *result = [BigOrderDetailResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}


/**
 *  点击支付宝微信去支付
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)getAlipayPayGoodsWithParams:(NSDictionary *)params success:(void (^)(PayOrderResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_pay_purchase params:params success:^(id response) {
        PayOrderResult *result = [PayOrderResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)getWeChatPayGoodsWithParams:(NSDictionary *)params success:(void (^)(WeChatOrderResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_pay_purchase params:params success:^(id response) {
        WeChatOrderResult *result = [WeChatOrderResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

/**
 *  用分润去支付
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败
 */
+ (void)IntegralPayGoodsWithParams:(NSDictionary *)params success:(void (^)(PayOrderResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_integralPay_purchase params:params success:^(id response) {
        PayOrderResult *result = [PayOrderResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

@end
