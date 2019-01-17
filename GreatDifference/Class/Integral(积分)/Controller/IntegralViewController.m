//
//  IntegralViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "IntegralViewController.h"
#import "MyWalletCell.h"
#import "WalletModel.h"
#import "MyWalletHeaderView.h"
#import "PersonalHttpManager.h"
#import "IntegralModelResult.h"
#import "IntegralRecordResult.h"
#import "MyInvitationViewController.h"
#import "H5WebViewController.h"

@interface IntegralViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView             *tableView;
@property (nonatomic, strong) NSMutableArray          *dataSource;
@end

@implementation IntegralViewController

#pragma mark -- initialization
static NSString *cellIdentifier = @"reuseCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
 
    

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.tableView registerClass:[MyWalletCell class] forCellReuseIdentifier:cellIdentifier];
//    for (NSInteger index = 0; index < 3; index++) {
//        WalletModel *model = [[WalletModel alloc]init];
//        model.title = @"购物消费得积分";
//        model.content   =   @"您的在便利店科苑店购买100元商品,以优惠20元，获得10个通用积分，16个海淘积分。";
//        [self.dataSource addObject:model];
//    }
//    [self.tableView reloadData];
        // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];
//    self.navigationController.navigationBarHidden = NO;

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
    [PersonalHttpManager getUserIntegralWithParams:nil success:^(IntegralModelResult *responseObj) {
        
        IntegralModel *model = responseObj.data;
        model.title = @"我的积分";
        model.leftTitle = @"推荐好友得积分";
        model.rightTitle    = @"积分问题解答";
        CGFloat TopHeight = SCREEN_HEIGHT*2/5-20;
        
        if (IS_IPHONE_5) {
            TopHeight = SCREEN_HEIGHT*2/5;
        }else if (IS_IPHONE_6SPlus){
            TopHeight = SCREEN_HEIGHT*2/5 - 30;
        }
        MyWalletHeaderView *headerView = [[MyWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopHeight) type:@"0"];
        headerView.model = model;
        self.tableView.tableHeaderView = headerView;
        headerView.leftBlock = ^(IntegralModel *model){
        
            MyInvitationViewController *myInvitationVc = [[MyInvitationViewController alloc]init];
            [self.navigationController pushViewController:myInvitationVc animated:YES];
        };
        
        headerView.rightBlock = ^(IntegralModel *model){
            H5WebViewController *questionVc = [[H5WebViewController alloc]init];
            questionVc.url = model.questionUrl;
            questionVc.title    = @"积分问题解答";
            [self.navigationController pushViewController:questionVc animated:YES];
        };
        
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    
    [PersonalHttpManager getUserIntegralRecordWithParams:params success:^(IntegralRecordResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];

}

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
    titleLabel.text = @"积分明细";
    titleLabel.textColor = THEMECOLOR;
    titleLabel.font     = XGFONT(17);
    [headerView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.8)];
    lineView.backgroundColor = LineColor;
    [headerView addSubview:lineView];
    
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
