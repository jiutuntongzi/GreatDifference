//
//  OrderFooterView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderSectionFooterView : UITableViewHeaderFooterView
@property (nonatomic, copy) void (^cancelOrderBlock)(NSString *str);
@property (nonatomic, copy) void (^confirmReceiveBlock)(NSString *str);
@property (nonatomic, copy) void (^refundBlock)(NSString *str);
@property (nonatomic, copy) void (^evaluteBlock)(NSString *str);

@property (nonatomic, strong) OrderModel      *orderModel;
//@property (nonatomic, copy) void (^payBlock)(NSString *str);

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier orderModel:(OrderModel *)order;

@end
