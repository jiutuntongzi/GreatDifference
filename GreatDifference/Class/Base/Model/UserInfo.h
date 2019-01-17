//
//  UserInfo.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/17.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^UploadCompletionBlock)(id response,NSError *error);

@interface UserInfo : NSObject<NSCoding>
@property (nonatomic, copy) NSString    *sysUserId;     //

@property (nonatomic, copy) NSString    *token;      //昵称
@property (nonatomic, copy) NSString    *name;          // 真实姓名

@property (nonatomic, copy) NSString    *userId;
@property (nonatomic, copy) NSString    *icon;

@property (nonatomic, copy) NSString    *userType;

@property (nonatomic, copy) NSString    *phoneNum;

@property (nonatomic, copy) NSString    *state;
@property (nonatomic, copy) NSString    *content;

/**** 基础信息返回的字段 ****/
@property (nonatomic, copy) NSString    *gender;    // 性别
@property (nonatomic, copy) NSString    *idCard;
@property (nonatomic, copy) NSString    *realName;
@property (nonatomic, copy) NSString    *bankName;
@property (nonatomic, copy) NSString    *bankNo;

@property (nonatomic, copy) NSString    *mob;
@property (nonatomic, copy) NSString    *invitationCode;    // 邀请码
@property (nonatomic, copy) NSString    *headImgUrl;

@property (nonatomic, copy) NSString    *nickName;

@property (nonatomic, copy) NSString    *province;
@property (nonatomic, copy) NSString    *city;

- (NSString *)getGenderName; // 获得性别名称


+ (void)uploadHeadImageWithUrl:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image completionHandle:(UploadCompletionBlock)completionBlock;
@end
