//
//  MyWalletCell.h
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WalletModel;
@class IntegralModel;
@interface MyWalletCell : UITableViewCell
@property (nonatomic, strong) WalletModel    *wallet;
@property (nonatomic, strong) IntegralModel  *integralModel;

@end
