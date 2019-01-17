//
//  MessageDetailViewController.h
//  GreatDifference
//
//  Created by 杨旭根 on 2017/1/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GoodsModel.h"

@interface MessageDetailViewController : BaseViewController
@property (nonatomic, copy) NSString  *messageId;
@property (nonatomic, strong) GoodsModel      *goods;
@end
