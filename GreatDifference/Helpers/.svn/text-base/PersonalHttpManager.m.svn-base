//
//  PersonalHttpManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "PersonalHttpManager.h"
#import "MJExtension.h"

#import "XGHttpManager.h"
#import "UserInfoResult.h"
#import "CommonModelResult.h"
#import "AddressListResult.h"
#import "StoreModelListResult.h"
#import "GoodsModelListResult.h"
#import "IntegralModelResult.h"
#import "IntegralRecordResult.h"
#import "IDIdentifyModelResult.h"
#import "OrderLIstResult.h"
#import "SignInModelResult.h"
#import "OrderDetailResult.h"
#import "BigOrderDetailResult.h"
#import "ExpressListResult.h"
#import "InvitationModelResult.h"
#import "BankCardResult.h"
#import "MessageModelResult.h"
#import "MessageDetailResult.h"

#import "AddressDetailResult.h"
#import "UnpayNumModelResult.h"
#import "InviteListResult.h"

@implementation PersonalHttpManager

//获取未支付订单数量
+ (void)getUnpayNumWithParams:(NSDictionary *)params success:(void (^)(UnpayNumModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    
    [XGHttpManager postRequestWithUrl:url_unpay_num params:params success:^(id response) {
        UnpayNumModelResult *result = [UnpayNumModelResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}
+ (void)getUserInfoWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_userInfo_detail params:params success:^(id response) {
        UserInfoResult *result = [UserInfoResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)modifyUserInfoWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_userInfo_modify params:params success:^(id response) {
        UserInfoResult *result = [UserInfoResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 修改密码
+ (void)changePasswordWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_modify_password params:params success:^(id response) {
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

//获取消费者身份证信息
+ (void)getUserIdIdentifyWithParams:(NSDictionary *)params success:(void (^)(IDIdentifyModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_getIdCard_info params:params success:^(id response) {
        IDIdentifyModelResult *result = [IDIdentifyModelResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

//修改消费者身份证信息
+ (void)modityUserIdIdentifyWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_modity_IdCard_info params:params success:^(id response) {
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

//获取绑定的银行卡信息
+ (void)getBindCardInfoWithParams:(NSDictionary *)params success:(void (^)(BankCardResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;{
    [XGHttpManager postRequestWithUrl:url_binded_card_info params:params success:^(id response) {
        BankCardResult *result = [BankCardResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

//绑定银行卡
+ (void)bindCardWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_bind_card params:params success:^(id response) {
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

//获取消费者积分
+ (void)getUserIntegralWithParams:(NSDictionary *)params success:(void (^)(IntegralModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_integral_detail params:params success:^(id response) {
        IntegralModelResult *result = [IntegralModelResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

//获取消费者积分记录
+ (void)getUserIntegralRecordWithParams:(NSDictionary *)params success:(void (^)(IntegralRecordResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_integral_record params:params success:^(id response) {
        IntegralRecordResult *result = [IntegralRecordResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

//获取邀请函
+ (void)getInvitationWithParams:(NSDictionary *)params success:(void (^)(InvitationModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_my_invitation params:params success:^(id response) {
        InvitationModelResult *result = [InvitationModelResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];

}

//获取邀请人列表
+ (void)getInvitateUserListWithParams:(NSDictionary *)params success:(void (^)(InviteListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_my_invitate_list params:params success:^(id response) {
        InviteListResult *result = [InviteListResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

//获取我的钱包
+ (void)getWalletWithParams:(NSDictionary *)params success:(void (^)(IntegralModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_wallet params:params success:^(id response) {
        IntegralModelResult *result = [IntegralModelResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

//获取现金消费记录
+ (void)getCashRecordWithParams:(NSDictionary *)params success:(void (^)(IntegralRecordResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_cash_record params:params success:^(id response) {
        IntegralRecordResult *result = [IntegralRecordResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)modityPasswordWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_integral_record params:params success:^(id response) {
        UserInfoResult *result = [UserInfoResult mj_objectWithKeyValues:response];
        
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

+ (void)getAddressListWithParams:(NSDictionary *)params success:(void (^)(AddressListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_consignee_addressList params:params success:^(id response) {
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

+ (void)addConsigneeAddressWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_add_consignee_address params:params success:^(id response) {
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

+ (void)modifyConsigneeAddressWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_modify_consignee_address params:params success:^(id response) {
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

+ (void)deleteConsigneeAddressWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_delete_consignee_address params:params success:^(id response) {
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

// 获取订单列表
+ (void)getMyOrderListWithParams:(NSDictionary *)params success:(void (^)(OrderLIstResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_order_list params:params success:^(id response) {
        OrderLIstResult *result = [OrderLIstResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];

}

// 获取小订单详情
+ (void)getMyOrderDetailWithParams:(NSDictionary *)params success:(void (^)(OrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_order_detail params:params success:^(id response) {
        OrderDetailResult *result = [OrderDetailResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 获取大订单详情
+ (void)getMyBigOrderDetailWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_bigOrder_detail params:params success:^(id response) {
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

// 获取未支付订单详情
+ (void)getUnPayOrderDetailWithParams:(NSDictionary *)params success:(void (^)(BigOrderDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_unPay_order_detail params:params success:^(id response) {
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

// 删除小订单
+ (void)deleteMyOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_delete_myOrder params:params success:^(id response) {
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

// 取消订单
+ (void)cancelMyOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_cancel_myOrder params:params success:^(id response) {
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

// 取消大订单
+ (void)cancelBigOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_cancel_bigOrder params:params success:^(id response) {
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

// 取消/删除大订单中的商品
+ (void)deleteBigOrderProductsWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_delete_bigOrder_products params:params success:^(id response) {
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
+ (void)confirmReceiveOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_confirm_receiveOrder params:params success:^(id response) {
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

// 评价订单
+ (void)evaluateOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_evaluate_Order params:params success:^(id response) {
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

//提现申请
+ (void)applyForWithdrawWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_encashment_apply params:params success:^(id response) {
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

// 退货申请
+ (void)refundOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_refund_Order params:params success:^(id response) {
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


// 取消退货申请
+ (void)cancelRefundOrderWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_cancel_refund_Order params:params success:^(id response) {
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

// 获取快递公司列表
+ (void)getExpressListWithParams:(NSDictionary *)params success:(void (^)(ExpressListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_express_list params:params success:^(id response) {
        ExpressListResult *result = [ExpressListResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 添加留言
+ (void)addLeaveMessageWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_add_leave_message params:params success:^(id response) {
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

// 回复留言
+ (void)replyLeaveMessageWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_reply_leave_message params:params success:^(id response) {
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

+ (void)getLeaveMessageListWithParams:(NSDictionary *)params success:(void (^)(MessageModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_leave_messageList params:params success:^(id response) {
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

// 获取指定信息详情
+ (void)getMessageDetailWithParams:(NSDictionary *)params success:(void (^)(MessageDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error)) failure{
    [XGHttpManager postRequestWithUrl:url_look_leaveMessage_detail params:params success:^(id response) {
        MessageDetailResult *result = [MessageDetailResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 根据经纬度获取省市区地址信
+ (void)getProvinceCityWithParams:(NSDictionary *)params success:(void (^)(AddressDetailResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error)) failure{
    [XGHttpManager postRequestWithUrl:url_provinceCity_address params:params success:^(id response) {
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

+ (void)getSignInfoWithParams:(NSDictionary *)params success:(void (^)(SignInModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_get_signIn_list params:params success:^(id response) {
        SignInModelResult *result = [SignInModelResult mj_objectWithKeyValues:response];
        if (success) {
            success(result);
        }
    } failure:^(id responseObject, NSError *error) {
        if (failure) {
            failure(responseObject, error);
        }
    }];
}

// 签到
+ (void)SignInWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_signIn params:params success:^(id response) {
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

// 获取收藏店铺类型列表
+ (void)getCollectStoreTypeListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_collect_storeType params:params success:^(id response) {
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

+ (void)getCollectStoreListWithParams:(NSDictionary *)params success:(void (^)(StoreModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_collect_storeList params:params success:^(id response) {
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

+ (void)getCollectGoodsListWithParams:(NSDictionary *)params success:(void (^)(GoodsModelListResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_collect_goodsList params:params success:^(id response) {
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


+ (void)uploadHeadImageWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithFullUrl:url params:params success:^(id response) {
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


@end
