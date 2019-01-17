//
//  MyWalletViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyWalletCell.h"
#import "WalletModel.h"
#import "MyWalletHeaderView.h"
#import "IntegralModelResult.h"
#import "PersonalHttpManager.h"
#import "IntegralRecordResult.h"

#import "CompleteUserInfoViewController.h"
#import "WithdrawViewController.h"
#import "H5WebViewController.h"
#import "BindCardViewController.h"

@interface MyWalletViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView             *tableView;
@property (nonatomic, strong) NSMutableArray          *dataSource;
@property (nonatomic, assign) NSInteger              page;
@end

@implementation MyWalletViewController

#pragma mark -- initialization
static NSString *cellIdentifier = @"reuseCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.tableView registerClass:[MyWalletCell class] forCellReuseIdentifier:cellIdentifier];
    [self fetchData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchData) name:@"kNotification_completeUseInfo" object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"银行卡" style:UIBarButtonItemStylePlain target:self action:@selector(bindBankCard)];
    
    // Do any additional setup after loading the view.
}

- (void)bindBankCard{
    BindCardViewController *bindCardVc = [[BindCardViewController alloc]init];
    [self.navigationController pushViewController:bindCardVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)setupHeaderViewWithModel:(IntegralModel *)model{
    
    CGFloat TopHeight = SCREEN_HEIGHT*2/5-20;
    
    if (IS_IPHONE_5) {
        TopHeight = SCREEN_HEIGHT*2/5;
    }else if (IS_IPHONE_6SPlus){
        TopHeight = SCREEN_HEIGHT*2/5 - 30;
    }
    
    MyWalletHeaderView *headerView = [[MyWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopHeight) type:@"1"];
    model.title = @"可用金额";
    model.leftTitle = @"分润提现";
    model.rightTitle    = @"分润问题解答";
    [headerView setWalletModel:model];
    self.tableView.tableHeaderView = headerView;
    
    headerView.leftBlock = ^(IntegralModel *model){
        
        if ([model.canEncashment isEqualToString:@"1"]) {
            WithdrawViewController *withdrawVc = [[WithdrawViewController alloc]init];
            [self.navigationController pushViewController:withdrawVc animated:YES];
            return ;
        }
        
        CompleteUserInfoViewController *identifyManagerVc = [[CompleteUserInfoViewController alloc]init];
        [self.navigationController pushViewController:identifyManagerVc animated:YES];
    };
    
    headerView.rightBlock = ^(IntegralModel *model){
        
        H5WebViewController *questionVc = [[H5WebViewController alloc]init];
        questionVc.url = model.questionUrl;
        questionVc.title    = @"分润问题解答";
        [self.navigationController pushViewController:questionVc animated:YES];

    };
}


#pragma mark -- getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource   =   self;
        _tableView.delegate     =   self;
        _tableView.estimatedSectionHeaderHeight = 40;
    }
    return _tableView;
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}

- (void)fetchData{
    [PersonalHttpManager getWalletWithParams:nil success:^(IntegralModelResult *responseObj) {
        [self setupHeaderViewWithModel:responseObj.data];
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];

    [PersonalHttpManager getCashRecordWithParams:params success:^(IntegralRecordResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

#pragma mark -- tableViewDataSource &&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWalletCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    IntegralModel *model = self.dataSource[indexPath.row];
    cell.integralModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    titleLabel.text = @"消费明细";
    titleLabel.textColor = THEMECOLOR;
    titleLabel.font     = XGFONT(17);
    [headerView addSubview:titleLabel];
    
    return headerView;
}

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
