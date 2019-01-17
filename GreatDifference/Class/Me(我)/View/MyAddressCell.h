//
//  MyAddressCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "OrderModel.h"
#import "OrderListModel.h"
@interface MyAddressCell : UITableViewCell
@property (nonatomic, strong) AddressModel      *address;
@property (nonatomic, strong) OrderModel        *orderDetail;
@property (nonatomic, strong) OrderListModel    *orderListModel;

@end
