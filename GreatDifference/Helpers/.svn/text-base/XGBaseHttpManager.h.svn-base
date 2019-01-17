//
//  XGBaseHttpManager.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/22.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, NetWorkMethod) {
    NetWorkMethodGET,
    NetWorkMethodPOST,
    NetWorkMethodUpload,
};

@interface XGBaseHttpManager : AFURLSessionManager

+ (instancetype)sharedInstance;
- (void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(NSURLResponse * task, id  responseObject))success  failure:(void (^)(id  responseObject, NSError *error)) failure;

- (void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(NSURLResponse * task, id  responseObject))success  failure:(void (^)(id  responseObject, NSError *error)) failure;
@end
