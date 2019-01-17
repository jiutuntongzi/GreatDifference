//
//  InviteTopView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/1/6.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InvitationModel;

@interface InviteTopView : UIView
@property (nonatomic, strong) InvitationModel      *invitationModel;
@property (nonatomic, copy) dispatch_block_t inviteBlock;

@end
