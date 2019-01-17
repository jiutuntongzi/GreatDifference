//
//  MessageModel.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/8.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "MessageModel.h"
#import "MJExtension.h"

@implementation MessageModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"replyList":@"MessageModel"};
}

- (BOOL)isSender{
    if ([_userType isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}
@end
