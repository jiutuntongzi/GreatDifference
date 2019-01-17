//
//  InvitationView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/25.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitationView : UIView
@property (nonatomic, copy) void(^sendInviteBlock)(id model, UIButton *button);
@end
