//
//  UserInfo.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/17.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "UserInfo.h"
#import "AFNetWorking.h"

@implementation UserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];

    [aCoder encodeObject:self.sysUserId forKey:@"sysUserId"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.userId forKey:@"userId"];

    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.headImgUrl forKey:@"headImgUrl"];

    [aCoder encodeObject:self.userType forKey:@"userType"];


}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        if (aDecoder == nil) {
            return self;
        }
        self.name = [aDecoder       decodeObjectForKey:@"name"];
        self.nickName = [aDecoder   decodeObjectForKey:@"nickName"];

        self.userId = [aDecoder     decodeObjectForKey:@"userId"];
        self.token = [aDecoder      decodeObjectForKey:@"token"];
        self.sysUserId = [aDecoder  decodeObjectForKey:@"sysUserId"];
        self.icon = [aDecoder       decodeObjectForKey:@"icon"];
        self.headImgUrl = [aDecoder decodeObjectForKey:@"headImgUrl"];
        self.userType = [aDecoder   decodeObjectForKey:@"userType"];
    }
    return self;
}

//- (NSString *)gender{
//    if ([_gender isEqualToString:@"0"]) {
//        return @"女";
//    }else if ([_gender isEqualToString:@"1"]){
//        return @"男";
//    }
//    return _gender;
//}

- (NSString *)getGenderName // 获得性别名称
{
    if ([_gender isEqualToString:@"0"]) {
        return @"女";
    }else if ([_gender isEqualToString:@"1"]){
        return @"男";
    }else if ([_gender isEqualToString:@"2"]){
        return @"";
    }
    return _gender;
}

+ (void)uploadHeadImageWithUrl:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image completionHandle:(UploadCompletionBlock)completionBlock{
    NSError *error = NULL;
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    urlRequest.HTTPMethod = @"POST";
    urlRequest.timeoutInterval = 8;
    
    NSString *token = [MyUserDefaults objectForKey:Access_token];
    [urlRequest setValue:token forHTTPHeaderField:@"__token__"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    AFJSONResponseSerializer *responseSerilializer = [AFJSONResponseSerializer serializer];
    urlRequest.HTTPBody = data;
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configure];
    manager.responseSerializer= responseSerilializer;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:urlRequest progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionBlock) {
            completionBlock(responseObject,error);
        }
    }];
    
    [uploadTask resume];

}

@end
