//
//  WaitRecevieViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/6.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "WaitRecevieViewController.h"
#import "MyAllOrderOutCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "OrderModel.h"
#import "ApplyForRefundViewController.h"
#import "PersonalHttpManager.h"
#import "OrderLIstResult.h"
#import "PersonalHttpManager.h"
#import "MyOrderDetailViewController.h"
#import "StoreDetailViewController.h"
//#import "MJRefresh.h"

@interface WaitRecevieViewController ()<UITableViewDataSource, UITableViewDelegate, OrderOutCellDelegate, UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UITableView      *tableView;
@property (nonatomic, strong) NSMutableArray   *dataSource;
@property (nonatomic, strong) OrderModel        *orderModel;
@property (nonatomic, copy) NSString           *reasonStr;
@property (nonatomic, strong) UITextField      *tapTextField;

@property (nonatomic, strong) NSArray         *pickerDataSource;
@property (nonatomic, strong) UIView          *pickerAccessoryView;

@property (nonatomic, strong) UIPickerView    *pickerView;
@property (nonatomic, assign) NSInteger        page;
@property (nonatomic, strong) UIView                *coverView;
@property (nonatomic, copy) NSString           *isMore;

@end

@implementation WaitRecevieViewController
static NSString *cellIdentifier         = @"waitReceiveCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.tapTextField];

    [self.tableView registerClass:[MyAllOrderOutCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataWithMore:) name:KNOTIFICATION_REFRESH_WAIT_RECEIVE_ORDERS object:nil];
    self.reasonStr = [self.pickerDataSource firstObject];

//    [self refreshDataWithMore:NO];
//
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshDataWithMore:NO];
}

- (void)refreshDataWithMore:(BOOL)more{
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"2" forKey:@"orderState"];
    [params setValue:[NSNumber numberWithInteger:self.page] forKey:@"pageIndex"];
    
    [params setValue:@"10" forKey:@"pageSize"];
    
    if (!more) {
        [PersonalHttpManager getMyOrderListWithParams:params success:^(OrderLIstResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dataSource = [responseObj.data mutableCopy];
                [self endRefresh];
            });
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } failure:^(id responseObj, NSError *error) {
                    [self endRefresh];
            
//            NSString *message= [responseObj objectForKey:@"message"];
//            XGLog(@"%@" ,message);
        }];
    }else{
        [PersonalHttpManager getMyOrderListWithParams:params success:^(OrderLIstResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dataSource addObjectsFromArray:responseObj.data];
                [self endRefresh];
            });
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } failure:^(id responseObj, NSError *error) {
            [self endRefresh];
            
            //            NSString *message= [responseObj objectForKey:@"message"];
            //            XGLog(@"%@" ,message);
        }];

    }

}



#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UITextField *)tapTextField{
    if (!_tapTextField) {
        _tapTextField = [UITextField new];
        _tapTextField.inputView = self.pickerView;
        _tapTextField.inputAccessoryView = self.pickerAccessoryView;
    }
    return _tapTextField;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSArray *)pickerDataSource{
    if (!_pickerDataSource) {
        _pickerDataSource = @[@"我不想买了", @"信息填写错误,重新拍", @"卖家缺货", @"同城见面交易", @"其他原因"];
    }
    return _pickerDataSource;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIView *)pickerAccessoryView
{
    if (!_pickerAccessoryView) {
        _pickerAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _pickerAccessoryView.backgroundColor = [UIColor grayColor];
        
        UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 25)];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerAccessoryView addSubview:finishBtn];
    }
    return _pickerAccessoryView;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverView)];
        [_coverView addGestureRecognizer:tap];
        //        _coverView.hidden = YES;
    }
    return _coverView;
}
#pragma mark -- tableViewDataSource && delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    MyAllOrderOutCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;
    [cell setOrderListModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    CGFloat height = [MyAllOrderOutCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MyAllOrderOutCell *cell = (MyAllOrderOutCell *)sourceCell;
        [cell setOrderListModel:model];
    }];
    return height;
}

#pragma mark -- UIPickerViewDataSource && delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.pickerDataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *content = self.pickerDataSource[row];
    self.reasonStr = content;
}



#pragma mark -- clickedAction
- (void)finishAction:(UIButton *)btn
{
    [self.tapTextField resignFirstResponder];
    [self.coverView removeFromSuperview];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setValue:self.orderModel.orderId forKey:@"orderId"];
    [params setValue:self.reasonStr forKey:@"returnReason"];
    
    [PersonalHttpManager cancelMyOrderWithParams:params success:^(CommonModelResult *responseObj) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshDataWithMore:@"NO"];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];

        });

    } failure:^(id responseObj, NSError *error) {
        
    }];
    
}

#pragma mark -- OrderOutCellDelegate
- (void)didClickedOrder:(OrderModel *)order atIndexPath:(NSIndexPath *)indexPath{
    MyOrderDetailViewController *orderDetailVc = [[MyOrderDetailViewController alloc]init];
    orderDetailVc.orderId = order.orderId;
    orderDetailVc.orderType = @"2";
    orderDetailVc.orderModel = order;
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView didClickedCancelOrder:(OrderModel *)orderModel{
    
    if ([orderModel.orderType isEqualToString:@"2"]) {
        self.orderModel = orderModel;
        [self.tapTextField becomeFirstResponder];
        [self.navigationController.view addSubview:self.coverView];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请直接联系店家线下处理" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    UIAlertAction *lookupAction = [UIAlertAction actionWithTitle:@"查看店铺信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StoreDetailViewController *storeDetailVc = [[StoreDetailViewController alloc]init];
        storeDetailVc.shopId = orderModel.shopId;
        [self.navigationController pushViewController:storeDetailVc animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:lookupAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

// 确认收货
- (void)tableView:(UITableView *)tableView didClickedConfirmReceive:(OrderModel *)orderModel{

    self.orderModel = orderModel;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认收货吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) { // 确认收货
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:self.orderModel.orderId forKey:@"orderId"];
        [PersonalHttpManager confirmReceiveOrderWithParams:param success:^(CommonModelResult *responseObj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_HAD_RECEIVE object:nil];
                [self refreshDataWithMore:NO];


            });
        } failure:^(id responseObj, NSError *error) {
            
        }];
    }
}

- (void)tapCoverView{
    [self.tapTextField resignFirstResponder];
    [self.coverView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
