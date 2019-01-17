//
//  HomeHttpManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HomeHttpManager.h"
#import "XGHttpManager.h"
#import "MJExtension.h"

#import "BannerModelResult.h"
#import "UserLocationResult.h"
#import "AddressListResult.h"
#import "StoreModelListResult.h"
#import "StoreOverViewResult.h"
#import "AddressDetailResult.h"
#import "StoreModelResult.h"
#import "CommonModelResult.h"
#import "GoodsModelResult.h"
#import "GoodsModelListResult.h"
#import "MessageModelResult.h"
#import "OrderStatusResult.h"

@implementation HomeHttpManager
+ (void)getHomeDataWithParams:(NSDictionary *)params success:(void (^)(BannerModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_home params:params success:^(id response) {
        BannerModelResult *result = [BannerModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)getStoreListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_shop_list params:params success:^(id response) {
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

+ (void)getStoreOverViewWithParams:(NSDictionary *)params success:(void (^)(StoreOverViewResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_shop_overView params:params success:^(id response) {
        XGLog(@"返回的列表是:%@",response);
        StoreOverViewResult *result = [StoreOverViewResult mj_objectWithKeyValues:response];
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
 *  获取某个类型的商品列表
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getGoodsListWithParams:(NSDictionary *)params success:(void (^)(GoodsModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_goods_list params:params success:^(id response) {
        XGLog(@"返回的列表是:%@",response);
        GoodsModelListResult *result = [GoodsModelListResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)getLifeServiceTypeListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_life_type_list params:params success:^(id response) {
        XGLog(@"返回的列表是:%@",response);
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

+ (void)getStoreDetailWithParams:(NSDictionary *)params success:(void (^)(StoreModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_shop_detail params:params success:^(id response) {
        StoreModelResult *result = [StoreModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}


+ (void)collectStoreWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_collect_shop params:params success:^(id response) {
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

+ (void)getGoodsDetailWithParams:(NSDictionary *)params success:(void (^)(GoodsModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_goods_detail params:params success:^(id response) {
        GoodsModelResult *result = [GoodsModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 扫条码获取详情
+ (void)scanQrcodeGetDetailWithParams:(NSDictionary *)params success:(void (^)(GoodsModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_scan_qrCode params:params success:^(id response) {
        GoodsModelResult *result = [GoodsModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)collectGoodsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_collect_goods params:params success:^(id response) {
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

// 添加到购物车
+ (void)addShopCartWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_add_shopCart params:params success:^(id response) {
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

+ (void)getCurrentCityWithParams:(NSDictionary *)params success:(void (^)(UserLocationResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_location_city params:params success:^(id response) {
        UserLocationResult *result = [UserLocationResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 获取系统消息
+ (void)getSystemMessageListWithParams:(NSDictionary *)params success:(void (^)(MessageModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_sysMessage_list params:params success:^(id response) {
        MessageModelResult *result = [MessageModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)getNearLocationWithParams:(NSDictionary *)params success:(void (^)(AddressListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_near_location params:params success:^(id response) {
        AddressListResult *result = [AddressListResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)getAddressDetailWithParams:(NSDictionary *)params success:(void (^)(AddressDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_address_detail params:params success:^(id response) {
        AddressDetailResult *result = [AddressDetailResult mj_objectWithKeyValues:response];
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
 *  获取订单状态列表
 *
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getOrderStatusListWithParams:(NSDictionary *)params success:(void (^)(OrderStatusResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_order_status_List params:params success:^(id response) {
        OrderStatusResult *result = [OrderStatusResult mj_objectWithKeyValues:response];
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
