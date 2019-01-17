//
//  WithdrawViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/23.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "WithdrawViewController.h"
#import "CommonReuseCell.h"
#import "PersonalHttpManager.h"
#import "StringUtils.h"

@interface WithdrawViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray       *dataSource;
@property (nonatomic, strong) UITableView          *tableView;
@end

@implementation WithdrawViewController
static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分润提现";
    
    [self.view addSubview:self.tableView];
    [self createDataSource];
    [self setupFooterView];

    // Do any additional setup after loading the view.
}

- (void)createDataSource{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"提现金额" forKey:@"title"];
    [dic setValue:@"请输入(单笔不能小于500元)" forKey:@"placeHolder"];
    [dic setValue:@"" forKey:@"detail"];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"提现密码" forKey:@"title"];
    [dic1 setValue:@"请输入提现密码" forKey:@"placeHolder"];
    [dic1 setValue:@"" forKey:@"detail"];
    self.dataSource = [NSMutableArray arrayWithCapacity:2];
    
    [self.dataSource addObject:dic];
    [self.dataSource addObject:dic1];
    
    [self.tableView reloadData];
}

- (void)setupFooterView{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 20, 40)];
    submitBtn.backgroundColor = THEMECOLOR;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(submitBtn.frame)+10, SCREEN_WIDTH - 20, 100)];
//    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.text = @"1.提现金额大笔不能小于500且必须是100的整数；\n2.提现单笔手续费5元；\n3.星期五和星期六不提供提现服务；\n4.提现将会在第二个工作日到账；\n5.每天只能提现一次；";
    detailLabel.font = XGFONT(12);
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.numberOfLines = 0;
    [footer addSubview:submitBtn];
    [footer addSubview:detailLabel];
    self.tableView.tableFooterView = footer;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    CommonReuseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CommonReuseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:CommonCellTypeTF];
    }
    [cell setContentDict:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


#pragma mark -- clickedAction
- (void)submitAction:(UIButton *)btn{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSInteger index = 0; index < self.dataSource.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        CommonReuseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *title = [cell getCellTitle];
        NSString *detail = [cell getCellDetail];
        
        if ([title isEqualToString:@"提现金额"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入提现金额"];
                return;
            }
            if ([detail integerValue] < 500) {
                [HUDUtils showAlert:@"提现金额不能低于500"];
                return;
            }
            
            if ([detail integerValue] % 100  !=0) {
                [HUDUtils showAlert:@"提现金额必须为100的整数"];
                return;
            }
            [params setValue:detail forKey:@"money"];
        }else if ([title isEqualToString:@"提现密码"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入提现密码"];
                return;
            }
            [params setValue:detail forKey:@"payPwd"];
        }
    }
    
    [HUDUtils showLoading:@"正在申请提现"];
    
    [PersonalHttpManager applyForWithdrawWithParams:params success:^(CommonModelResult *responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils hideHud];
            [HUDUtils showAlert:@"提现申请成功"];
            
            
            UIViewController *vc = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:vc animated:YES];
        });
    } failure:^(id responseObj, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils hideHud];
            NSString *message = [responseObj objectForKey:@"message"];
            [HUDUtils showAlert:message];
//            [self.navigationController popViewControllerAnimated:YES];
        });
    }];

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
