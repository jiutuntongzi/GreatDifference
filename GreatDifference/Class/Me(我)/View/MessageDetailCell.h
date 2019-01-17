//
//  MessageDetailCell.h
//  GreatDifference
//
//  Created by 杨旭根 on 2017/1/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;

@interface MessageDetailCell : UITableViewCell
@property (nonatomic, strong) MessageModel      *message;

+ (CGFloat)getCellHeight:(MessageModel *)message;
@end
