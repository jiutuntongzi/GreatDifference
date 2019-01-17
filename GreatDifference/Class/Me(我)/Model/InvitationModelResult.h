//
//  InvitationModelResult.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/6.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvitationModel.h"

@interface InvitationModelResult : NSObject
@property (nonatomic, copy) NSString  *message;
@property (nonatomic, copy) NSString  *state;
@property (nonatomic, strong) InvitationModel      *data;


@end
