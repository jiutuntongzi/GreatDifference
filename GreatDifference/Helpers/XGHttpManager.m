//
//  XGHttpManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/22.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "XGHttpManager.h"
#import "XGBaseHttpManager.h"

@implementation XGHttpManager

+ (void)getRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(id response ,NSError *error))failure{
    [[XGBaseHttpManager sharedInstance] get:[self setUpRootUrl:url] parameters:params success:^(NSURLResponse *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(id  responseObject, NSError *error) {
        if (failure) {
            failure(responseObject,error);
        }
    }];
}

+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(id responseObject ,NSError *error))failure{
    [self postRequestWithFullUrl:[self setUpRootUrl:url] params:params success:success failure:failure];
    
}

+ (void)postRequestWithFullUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(id responseObject ,NSError *error))failure{
    [[XGBaseHttpManager sharedInstance] post:url parameters:params success:^(NSURLResponse *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(id  responseObject, NSError *error) {
        if (failure) {
            failure(responseObject,error);
        }
    }];
}


+ (NSString *)setUpRootUrl:(NSString *)baseUrl server:(NSString *)serverAddress{
    
    return [baseUrl stringByAppendingPathComponent:serverAddress ] ;
    
}

+ (NSString *)setUpRootUrl:(NSString *)serverAddress{
    NSString *url = [BASE_URL stringByAppendingPathComponent:serverAddress];
    return url;
}


@end
