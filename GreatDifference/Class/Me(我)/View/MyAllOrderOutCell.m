//
//  MyAllOrderOutCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyAllOrderOutCell.h"
#import "OrderModel.h"
#import "OrderListModel.h"

#import "MyOrderCell.h"

#import "OrderHeaderView.h"
#import "WaitPayFooterView.h"
#import "WaitPayHeaderView.h"
#import "OrderSectionFooterView.h"
#import "OrderPriceFooterView.h"

#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "StringUtils.h"

@interface MyAllOrderOutCell ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;
@property (nonatomic, copy) NSString          *reuseId;
@property (nonatomic, strong) WaitPayFooterView      *footerView;
@property (nonatomic, strong) OrderHeaderView        *headerView;
@property (nonatomic, strong) NSArray               *orderStatusArray;

@end
@implementation MyAllOrderOutCell

static NSString *cellIdentifier                 = @"outCell";
static NSString *headerIdentifeir               = @"headerIdentifeir";
static NSString *footerWaitReceiveId            = @"footerWaitReceive";  // 待收货
static NSString *footerHadReceiveId             = @"footerHadReceive";  // 已收货
static NSString *footerHadReceiveCommonId       = @"footerHadReceiveCommonId";  // 已收货普通单

static NSString *footerRefundId                 = @"footerRefund";  // 退款/退货

static NSString *footerFinishId                 = @"footerFinish";    // 完成

#pragma mark -- initialization
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _reuseId = reuseIdentifier;
        [self setupSubviews];
        [self.tableView registerClass:[MyOrderCell class] forCellReuseIdentifier:cellIdentifier];
        [self.tableView registerClass:[WaitPayHeaderView class] forHeaderFooterViewReuseIdentifier:headerIdentifeir];
    }
    return self;
}

- (void)setupSubviews{
    
    [self.contentView addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    
    if ([self.reuseId isEqualToString:@"waitPayCell"]) {
        WaitPayFooterView *footerView = [[WaitPayFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        self.tableView.tableFooterView = footerView;
        self.footerView = footerView;
        footerView.cancelOrderBlock = ^(){
            if ([self.delegate respondsToSelector:@selector(tableView:didClickedCancelBigOrder:)]) {
                [self.delegate tableView:self.tableView didClickedCancelBigOrder:self.orderListModel];
            }
        };
        
        footerView.payBlock = ^(){
            if ([self.delegate respondsToSelector:@selector(tableView:didClickedPayBtn:)]) {
                [self.delegate tableView:self.tableView didClickedPayBtn:self.orderListModel];
            }
        };
    }else{
        [self.tableView registerClass:[OrderSectionFooterView class] forHeaderFooterViewReuseIdentifier:footerWaitReceiveId];
        [self.tableView registerClass:[OrderSectionFooterView class] forHeaderFooterViewReuseIdentifier:footerHadReceiveId];
        [self.tableView registerClass:[OrderPriceFooterView class] forHeaderFooterViewReuseIdentifier:footerRefundId];
        [self.tableView registerClass:[OrderSectionFooterView class] forHeaderFooterViewReuseIdentifier:footerFinishId];
        
        [self.tableView registerClass:[OrderSectionFooterView class] forHeaderFooterViewReuseIdentifier:footerHadReceiveCommonId];
 
    }

    OrderHeaderView *headerView = [[OrderHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.headerView = headerView;
    self.tableView.tableHeaderView  = headerView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView);
    
    }];
    
    self.hyb_lastViewInCell = self.tableView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)setupTableHeaderFooterView{

}

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedSectionHeaderHeight = 44;
        _tableView.estimatedRowHeight = 70;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -- tableViewDataSource && Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderModel *order = self.dataSource[section];
    return order.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *storeModel = [self.dataSource objectAtIndex:indexPath.section];
    GoodsModel *goods = [storeModel.products objectAtIndex:indexPath.row];
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.userInteractionEnabled = NO;
    [cell configCellWithModel:goods];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.reuseId isEqualToString:@"waitPayCell"]||[StringUtils isEmpty:self.reuseId]) {
        return 0;
    }
    OrderModel *order = self.dataSource[section];

    if ([self.orderStatusArray containsObject:order.orderState]) {
        return 40;
    }
    
    // 如果是已收货中的 普通单
//    if ([order.orderState isEqualToString:@"2"] && [order.orderType isEqualToString:@"1"]) {
//        return 40;
//    }

    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    OrderModel *orderModel = [self.dataSource objectAtIndex:section];
    WaitPayHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifeir];
    orderModel.existsChangeProduct = self.orderListModel.existsChangeProduct;
    header.orderModel = orderModel;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.reuseId isEqualToString:@"waitPayCell"]) {
        return nil;
    }
    

    OrderModel *order = self.dataSource[section];
    
    if ([self.orderStatusArray containsObject:order.orderState]) {

        OrderPriceFooterView *orderPriceFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerRefundId];
        orderPriceFooter.orderModel = order;
        return orderPriceFooter;
    }
    
    // 如果是已收货中的 普通单
//    if ([order.orderState isEqualToString:@"2"] && [order.orderType isEqualToString:@"1"]) {
//        return nil;
//    }
    
    
    OrderSectionFooterView *footer;
    if ([order.orderState isEqualToString:@"1"]) {// 待收货分两种状态 商家已确认则不可取消订单， 未确认则可取消订单
//        footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerWaitReceiveId];
        footer = [[OrderSectionFooterView alloc]initWithReuseIdentifier:footerWaitReceiveId orderModel:order];
        
    }else if ([order.orderState isEqualToString:@"2"]){
        if ([order.orderType isEqualToString:@"1"]) {
            footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerHadReceiveCommonId];
//            orderPriceFooter.orderModel = order;
//            return orderPriceFooter;
        }else{
            footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerHadReceiveId];
//            footer.backgroundColor = [UIColor redColor];
 
        }
    }else if ([order.orderState isEqualToString:@"9"]){
        footer = [[OrderSectionFooterView alloc]initWithReuseIdentifier:footerFinishId orderModel:order];
    }

    footer.orderModel = order;
    
    footer.cancelOrderBlock = ^(NSString *str){
        if ([self.delegate respondsToSelector:@selector(tableView:didClickedCancelOrder:)]) {
            [self.delegate tableView:tableView didClickedCancelOrder:order];
        }
    };
    
    footer.confirmReceiveBlock = ^(NSString *str){
        if ([self.delegate respondsToSelector:@selector(tableView:didClickedConfirmReceive:)]) {
            [self.delegate tableView:tableView didClickedConfirmReceive:order];
        }
    };
    
    footer.evaluteBlock = ^(NSString *Str){
        if ([self.delegate respondsToSelector:@selector(tableView:didClickedEvaluateBtn:)]) {
            [self.delegate tableView:tableView didClickedEvaluateBtn:order];
        }
    };
    
//    footer.payBlock = ^(NSString *str){
//        if ([self.delegate respondsToSelector:@selector(tableView:didClickedConfirmReceive:)]) {
//            [self.delegate tableView:tableView didClickedConfirmReceive:order];
//        }
//    };
    
    footer.refundBlock = ^(NSString *str){
        if ([self.delegate respondsToSelector:@selector(tableView:didClickedRefundBtn:)]) {
            [self.delegate tableView:tableView didClickedRefundBtn:order];
        }
    };
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    return;
    if ([self.orderListModel.bigOrderState isEqualToString:@"1"]) {
        if ([self.delegate respondsToSelector:@selector(didClickedBigOrder:atIndexPath:)]) {
            [self.delegate didClickedBigOrder:self.orderListModel atIndexPath:indexPath];
        }
        return;
    }
    OrderModel *order = [self.dataSource objectAtIndex:indexPath.section];

    if ([self.delegate respondsToSelector:@selector(didClickedOrder:atIndexPath:)]) {
        [self.delegate didClickedOrder:order atIndexPath:indexPath];
    }

}


- (void)setOrderListModel:(OrderListModel *)model{
    //
    _orderListModel = model;
    self.dataSource = [model.orders mutableCopy];
    [self setNeedsUpdateConstraints];
    CGFloat tableHeight = 0;
    for (OrderModel *storeModel in self.dataSource) {
        NSArray *tempArray = storeModel.products;
        for (GoodsModel *goods in tempArray) {
            CGFloat height = [MyOrderCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
                MyOrderCell *cell = (MyOrderCell *)sourceCell;
                [cell configCellWithModel:goods];
            }];
            tableHeight += height;
        }
        
        if ([self.orderStatusArray containsObject:storeModel.orderState]) {
            tableHeight-=40;
        }
    }
    CGFloat sectionHeight   = self.dataSource.count * 44;
    CGFloat __block tableFooterHeight   = 80;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (![model.bigOrderState isEqualToString:@"1"]) {

//            if ([model.orderState isEqualToString:@"2"]&&[model.orderType isEqualToString:@"1"]){
////                tableHeight -=50;
//            }

            tableFooterHeight = self.dataSource.count * 80;
        }
        make.height.mas_equalTo(tableHeight+ sectionHeight + 44 + tableFooterHeight);
    }];
    [self.tableView reloadData];
    
    [self.footerView setOrderListModel:model];
    [self.headerView setOrderListModel:model];
}

- (NSArray *)orderStatusArray{
    if (!_orderStatusArray) {
        _orderStatusArray = @[@"3", @"4", @"5", @"6", @"7", @"8"];
    }
    return _orderStatusArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
