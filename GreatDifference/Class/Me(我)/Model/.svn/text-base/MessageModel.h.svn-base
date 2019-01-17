//
//  MessageModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/8.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic, assign) BOOL  isSender; // 是否是发送者
//@property (nonatomic, copy) NSString  *headImg;
@property (nonatomic, copy) NSString  *content;
//@property (nonatomic, copy) NSString  *time;
@property (nonatomic, strong) NSString *message; // 用于系统消息

/**
 *  留言记录列表里的字段
 */

@property (nonatomic, copy) NSString        *createTime;
@property (nonatomic, copy) NSString        *leaveMsgId;
@property (nonatomic, copy) NSString        *subject; //留言主题
@property (nonatomic, copy) NSString        *sysUserName;
@property (nonatomic, copy) NSString        *leaveMsgReplyId;
@property (nonatomic, copy) NSString        *userType;  /** 用户类型；1-客服；2-用户 **/


@property (nonatomic, strong) NSArray       *replyList;

@end
