//
//  LoginHttpManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/22.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "LoginHttpManager.h"
#import "XGHttpManager.h"
#import "MJExtension.h"


#import "UserInfoResult.h"
#import "CommonModelResult.h"
#import "VersionUpdateResult.h"

@implementation LoginHttpManager
+ (void)registerUserWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *response))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_register params:params success:^(id response) {
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

+ (void)thirdRegisterUserWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_third_register params:params success:^(id response) {
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

+ (void)getValidCodeWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult * responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_send_message params:params success:^(id response) {
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

+ (void)loginWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *response))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_login params:params success:^(id response) {
//        NSData *data = [response objectForKey:@"data"];
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


+ (void)thirdLoginWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_thirdparth_login params:params success:^(id response) {
        //        NSData *data = [response objectForKey:@"data"];
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

+ (void)forgetPwdWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_forget_password params:params success:^(id response) {
        //        NSData *data = [response objectForKey:@"data"];
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

+ (void)checkAppUpdateWithParams:(NSDictionary *)params success:(void (^)(VersionUpdateResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure{
    [XGHttpManager postRequestWithUrl:url_forget_password params:params success:^(id response) {
        //        NSData *data = [response objectForKey:@"data"];
        VersionUpdateResult *result = [VersionUpdateResult mj_objectWithKeyValues:response];
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
