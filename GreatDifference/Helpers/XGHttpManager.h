//
//  XGHttpManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/22.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGHttpManager : NSObject
+ (void)getRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(id responseObject ,NSError *error))failure;

+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(id responseObject ,NSError *error))failure;
+ (void)postRequestWithFullUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(id responseObject ,NSError *error))failure;
@end
