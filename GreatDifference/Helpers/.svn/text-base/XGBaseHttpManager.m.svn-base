//
//  XGBaseHttpManager.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/22.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "XGBaseHttpManager.h"

@implementation XGBaseHttpManager
static XGBaseHttpManager *sharedInstance = nil;
+ (instancetype)sharedInstance{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedInstance = [[self alloc]initWithSessionConfiguration:configuration];
    });
    return sharedInstance;
}

- (void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(NSURLResponse * task, id  responseObject))success  failure:(void (^)(id  responseObject, NSError *error)) failure{
    
    [self requestType:NetWorkMethodGET url:url parameters:params success:success failure:failure];
}


- (void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(NSURLResponse * task, id  responseObject))success  failure:(void (^)(id  responseObject, NSError *error)) failure{
    
    [self requestType:NetWorkMethodPOST url:url parameters:params success:success failure:failure];
}


- (void)requestType:(NetWorkMethod )requestType url:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(NSURLResponse * task, id  responseObject))success  failure:(void (^)(id  responseObject, NSError *error)) failure{
    NSError *aError = nil;
    AFJSONResponseSerializer *responseSerilializer = [AFJSONResponseSerializer serializer];
    [responseSerilializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json",  @"text/javascript", nil]];
    self.responseSerializer = responseSerilializer;
    
    AFJSONRequestSerializer *requestSerial = [AFJSONRequestSerializer serializer];
    NSMutableURLRequest *request;
    if (requestType == NetWorkMethodGET) {
        request = [requestSerial requestWithMethod:@"GET" URLString:url parameters:params error:&aError];
    }else if (requestType == NetWorkMethodPOST){
        request = [requestSerial requestWithMethod:@"POST" URLString:url parameters:params error:&aError];
        NSString *token = [MyUserDefaults objectForKey:Access_token];
        [request setValue:token forHTTPHeaderField:@"__token__"];
    }

    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        XGLog(@"%@ -- 返回的字典是%@",response, responseObject);
    
        NSString *code = [[responseObject objectForKey:@"state"] stringValue];
        if ([code isEqualToString:@"1"]) {
            if (success) {
                success(response,responseObject);
            }
            
        }
        else{
            if (failure) {
                failure(responseObject,error);
            }
        }
    }];
    [dataTask resume];
    
    

}

@end
