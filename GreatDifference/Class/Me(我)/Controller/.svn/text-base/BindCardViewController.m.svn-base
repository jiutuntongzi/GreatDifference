//
//  BindCardViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "BindCardViewController.h"
#import "CommonReuseCell.h"
#import "StringUtils.h"
#import "PersonalHttpManager.h"
#import "BankCardResult.h"
#import "LoginHttpManager.h"

@interface BindCardViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) BankCardModel         *bankModel;
@property (nonatomic, strong) UIButton              *validBtn;

@end

@implementation BindCardViewController
static NSString *cellIdentifier = @"reuseCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定银行卡";
    
    [self.view addSubview:self.tableView];
//    [self configureData];
    [self setupFooterView];
    [PersonalHttpManager getBindCardInfoWithParams:nil success:^(BankCardResult *responseObj) {
        self.bankModel = responseObj.data;
        [self configureData:responseObj.data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

- (void)configureData:(BankCardModel *)bankModel{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    
    [dic1 setValue:@"开户银行" forKey:@"title"];
    [dic1 setValue:@"请输入开户银行" forKey:@"placeHolder"];
    [dic1 setValue:@"1" forKey:@"cellType"];
    [dic1 setValue:bankModel.bankName forKey:@"detail"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"分支行" forKey:@"title"];
    [dic2 setValue:@"请输入分支行" forKey:@"placeHolder"];
    [dic2 setValue:@"1" forKey:@"cellType"];
    [dic2 setValue:bankModel.branchBank forKey:@"detail"];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    
    [dic3 setValue:@"银行卡号" forKey:@"title"];
    [dic3 setValue:@"请输入银行卡号" forKey:@"placeHolder"];
    [dic3 setValue:@"1" forKey:@"cellType"];
    [dic3 setValue:bankModel.bankNo forKey:@"detail"];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setValue:@"户主姓名" forKey:@"title"];
    [dic4 setValue:@"请输入姓名" forKey:@"placeHolder"];
    [dic4 setValue:@"1" forKey:@"cellType"];
    [dic4 setValue:bankModel.bankUser forKey:@"detail"];
    
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setValue:bankModel.mob forKey:@"title"];
    //    [dic5 setValue:@"18680346615" forKey:@"detail"];
    [dic5 setValue:@"0" forKey:@"cellType"];
    
    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    [dic6 setValue:@"验证码" forKey:@"title"];
    [dic6 setValue:@"请输入验证码" forKey:@"placeHolder"];
    [dic6 setValue:@"1" forKey:@"cellType"];
    
    //
    //    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
    //    [dic6 setValue:@"请设置提现密码" forKey:@"title"];
    //    [dic6 setValue:@"请输入密码" forKey:@"placeHolder"];
    
    NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
    [dic7 setValue:@"提现密码" forKey:@"title"];
    [dic7 setValue:@"请输入密码" forKey:@"placeHolder"];
    [dic7 setValue:@"1" forKey:@"cellType"];
    
    [self.dataSource addObject:dic1];
    [self.dataSource addObject:dic2];
    [self.dataSource addObject:dic3];
    [self.dataSource addObject:dic4];
    
    [self.dataSource addObject:dic5];
    [self.dataSource addObject:dic6];
    
    [self.dataSource addObject:dic7];

}

- (void)setupFooterView{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60)];
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 40)];
    submitBtn.backgroundColor = THEMECOLOR;
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerView addSubview:submitBtn];
    self.tableView.tableFooterView =  footerView;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 40;
    
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonReuseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *dict = self.dataSource[indexPath.row];
    CommonCellType cellType = [dict[@"cellType"] integerValue];
    if (!cell) {
        cell = [[CommonReuseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier cellType:cellType];
    }
    if (cellType == CommonCellTypeNormal) {
        UIButton *validBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 10, 100, 25)];
        validBtn.backgroundColor = THEMECOLOR;
        [validBtn setTitle:@" 获取验证码 " forState:UIControlStateNormal];
        [validBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        validBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [validBtn addTarget:self action:@selector(validCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        validBtn.layer.cornerRadius = 3;
        self.validBtn = validBtn;
        [cell.contentView addSubview:validBtn];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setContentDict:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)submitAction{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSInteger index = 0; index < self.dataSource.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        CommonReuseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *title = [cell getCellTitle];
        NSString *detail = [cell getCellDetail];
        
        if ([title isEqualToString:@"开户银行"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入开户银行"];
                return;
            }
            [params setValue:detail forKey:@"bankName"];
        }else if ([title isEqualToString:@"分支行"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入分支行"];
                return;
            }
            [params setValue:detail forKey:@"branchBank"];
        }else if ([title isEqualToString:@"银行卡号"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入银行卡号"];
                return;
            }
            [params setValue:detail forKey:@"bankNo"];
        }
        else if ([title isEqualToString:@"户主姓名"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入户主姓名"];
                return;
            }
            [params setValue:detail forKey:@"bankUser"];
        }
        else if ([title isEqualToString:@"验证码"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入验证码"];
                return;
            }
            [params setValue:detail forKey:@"verifyCode"];
        }
        else if ([title isEqualToString:@"提现密码"]) {
            if ([StringUtils isEmpty:detail]) {
                [HUDUtils showAlert:@"请输入提现密码"];
                return;
            }
            [params setValue:detail forKey:@"payPwd"];
        }
        
    }
    
    [HUDUtils showLoading:@"正在提交"];
    [PersonalHttpManager bindCardWithParams:params success:^(CommonModelResult *responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils hideHud];

            [HUDUtils showAlert:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        });
    } failure:^(id responseObj, NSError *error) {
        NSString *message = [responseObj objectForKey:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils hideHud];
            [HUDUtils showError:message];
        });
    }];
}

- (void)validCodeBtnClicked:(UIButton *)btn{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.bankModel.mob forKey:@"mob"];
    
    [LoginHttpManager getValidCodeWithParams:params success:^(CommonModelResult *responseObj) {
        [self startTime];
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                UIButton *rightBtn = (UIButton *)self.validBtn;
                [rightBtn setTitle:@" 获取验证码 " forState:UIControlStateNormal];
                rightBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                UIButton *rightBtn = (UIButton *)self.validBtn;
                
                [rightBtn setTitle:[NSString stringWithFormat:@"重新发送(%@s)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                rightBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
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
