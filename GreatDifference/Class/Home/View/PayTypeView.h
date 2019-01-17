//
//  PayTypeView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTypeView : UIView

@property (nonatomic, copy) dispatch_block_t closeBlock;
@property (nonatomic, copy) void (^didClickedPayTypeBlock)(id model, NSIndexPath *indexPath);

@end
