//
//  IdentifyManagerCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdentifyManagerCell : UITableViewCell
@property (nonatomic, copy) void (^addPictureBlock) (UIButton *btn);
- (void)setContent:(NSDictionary *)dic;
@end
