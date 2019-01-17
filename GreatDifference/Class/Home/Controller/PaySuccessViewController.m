//
//  PaySuccessViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/8.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "OrderDetailTopCell.h"
#import "MyAddressCell.h"
#import "PaySuccessFooterView.h"
#import "MainViewController.h"

@interface PaySuccessViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableArray      *dataSource;
@end

@implementation PaySuccessViewController
static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"支付成功";
    [self.view addSubview:self.tableView];
    
    [self createFooterView];
    [self.tableView registerClass:[OrderDetailTopCell class] forCellReuseIdentifier:cellIdentifier];
    [self configureData];
    // Do any additional setup after loading the view.
}

- (void)configureData{
    if (self.payOrder == nil) {
        return;
    }
    [self.dataSource addObject:self.payOrder];
    [self.tableView reloadData];
}

- (void)createFooterView{
    
    PaySuccessFooterView *footer = [[PaySuccessFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [self.view addSubview:footer];
    footer.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footer;
    footer.payOrder = self.payOrder;
    footer.backBlock = ^(){
        
        UIWindow *window  = [UIApplication sharedApplication].keyWindow;
        window.rootViewController    = [MainViewController new];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    
}

#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight    = 70;
        _tableView.backgroundColor = XGCOLOR(236, 236, 236);
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayOrderModel *model = [self.dataSource objectAtIndex:indexPath.row];
    OrderDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.payOrder = model;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 45;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
