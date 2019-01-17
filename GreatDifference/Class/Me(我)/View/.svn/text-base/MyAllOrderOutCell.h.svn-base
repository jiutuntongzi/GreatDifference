//
//  MyAllOrderOutCell.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@class OrderListModel;

typedef NS_ENUM(NSInteger, OutCellType) {
    OutCellTypeWaitPay,
    OutCellTypeWaitRecieve,
    OutCellTypeHadRecieve,
    OutCellTypeFinish,

};

@protocol OrderOutCellDelegate <NSObject>
@optional

- (void)didClickedOrder:(OrderModel *)order atIndexPath:(NSIndexPath *)indexPath;
- (void)didClickedBigOrder:(OrderListModel *)bigOrder atIndexPath:(NSIndexPath *)indexPath;

/**
 *  取消大订单   待支付
 *
 *  @param tableView  tableView
 *  @param orderModel 大订单
 */
- (void)tableView:(UITableView *)tableView didClickedCancelBigOrder:(OrderListModel *)orderListModel;

- (void)tableView:(UITableView *)tableView didClickedCancelOrder:(OrderModel *)orderModel;

- (void)tableView:(UITableView *)tableView didClickedConfirmReceive:(OrderModel *)orderModel;

- (void)tableView:(UITableView *)tableView didClickedEvaluateBtn:(OrderModel *)orderModel;

- (void)tableView:(UITableView *)tableView didClickedPayBtn:(OrderListModel *)orderModel;

- (void)tableView:(UITableView *)tableView didClickedRefundBtn:(OrderModel *)orderModel;

@end
@interface MyAllOrderOutCell : UITableViewCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(OutCellType)cellType;

//@property (nonatomic, strong) OrderListModel  *model;
@property (nonatomic, strong) id<OrderOutCellDelegate>  delegate;

@property (nonatomic, strong) OrderListModel  *orderListModel;



@end
