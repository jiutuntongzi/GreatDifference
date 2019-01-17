//
//  LoginHttpManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/22.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoResult;
@class CommonModelResult;
@class VersionUpdateResult;

@interface LoginHttpManager : NSObject

+ (void)registerUserWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)thirdRegisterUserWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)getValidCodeWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)loginWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)thirdLoginWithParams:(NSDictionary *)params success:(void (^)(UserInfoResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)forgetPwdWithParams:(NSDictionary *)params success:(void (^)(CommonModelResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;

+ (void)checkAppUpdateWithParams:(NSDictionary *)params success:(void (^)(VersionUpdateResult *responseObj))success failure:(void (^)(id responseObj ,NSError *error))failure;
@end
