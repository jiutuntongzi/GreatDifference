//
//  SetViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SetViewController.h"
#import "LoginViewController.h"
#import "XGNavigationViewController.h"
#import "ChangePasswordViewController.h"
#import "AccountUtils.h"

@interface SetViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, assign) BOOL              notificationOpen;

@end



@interface NotificationCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end


@implementation NotificationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        topView.backgroundColor = XGCOLOR(204, 204, 209);
        [self.contentView addSubview:topView];
        
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = @"消息提醒设置";
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 60, 20, 50, 20)];
        
        detailLabel.font = [UIFont systemFontOfSize:15];
        detailLabel.textColor = [UIColor grayColor];
        self.detailLabel = detailLabel;
        [self.contentView addSubview:detailLabel];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 40)];
        bgView.backgroundColor = XGCOLOR(204, 204, 209);
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20)];
        
        contentLabel.text = @"请在iPhone的\"设置\" - \"通知\"中进行修改";
        contentLabel.font = [UIFont systemFontOfSize:11];
        contentLabel.textColor = [UIColor grayColor];
        
        [bgView addSubview:contentLabel];
        [self.contentView addSubview:bgView];
        
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH/2, 20)];
    }
    return _titleLabel;
}
@end

@implementation SetViewController
static NSString *cellIdentifier = @"reuseCell";
static NSString *notiCell = @"notiCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self setupFooterView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            NSLog(@"推送关闭");
            self.notificationOpen = NO;
        }else{
            NSLog(@"推送打开");
            self.notificationOpen = YES;
        }
    }else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type){
            self.notificationOpen = NO;
        }else{
            self.notificationOpen = YES;
        }
    }
    [self.tableView registerClass:[NotificationCell class] forCellReuseIdentifier:notiCell];

    // Do any additional setup after loading the view.
}

- (void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton *quitBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSpace * 2, kSpace * 4, (SCREEN_WIDTH - 4 * kSpace), 40)];
    quitBtn.backgroundColor = [UIColor redColor];
    [quitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    quitBtn.layer.cornerRadius = 5;
    [quitBtn addTarget:self action:@selector(quitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:quitBtn];
    
    self.tableView.tableFooterView  = footerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.estimatedSectionHeaderHeight = 64;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"" forKey:@"icon"];
        [dic setObject:@"推送通知" forKey:@"title"];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:@"icon_cleanup" forKey:@"icon"];
        [dic1 setObject:@"修改密码" forKey:@"title"];
        [dic1 setObject:[NSString stringWithFormat:@"%@M",@"100"] forKey:@"detail"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:@"" forKey:@"icon"];
        [dic2 setObject:@"版本信息" forKey:@"title"];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:@"about" forKey:@"icon"];
        [dic3 setObject:@"联系我们" forKey:@"title"];
        [dic3 setObject:@"0755-86836541" forKey:@"detail"];

        
        
        [_dataSource addObject:dic];
        [_dataSource addObject:dic1];

        [_dataSource addObject:dic2];

        [_dataSource addObject:dic3];

        
    }
    return _dataSource;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];

    if (indexPath.row == 0) {
        NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:notiCell];
        cell.titleLabel.text = @"消息设置";
        cell.detailLabel.text = self.notificationOpen?@"已开启":@"已关闭";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;


    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = dic[@"title"];
    if (indexPath.row == 1 || indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 2) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2 - 10, 20)];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.text = [NSString stringWithFormat:@"V %@",app_Version];
        detailLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:detailLabel];
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 95;
    }
    return 40;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        ChangePasswordViewController *changePwdVc = [[ChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:changePwdVc animated:YES];
    }

}

#pragma mark -- handleAction
- (void)netSwitchAction:(UISwitch *)newSwitch
{
    [[NSUserDefaults standardUserDefaults] setBool:newSwitch.on forKey:@"isPushNoti"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)quitAction:(UIButton *)btn{
    [MyUserDefaults setBool:NO forKey:LoginState];
//    UserInfo *user = [UserInfo alloc]init
    [AccountUtils save:nil];
    [MyUserDefaults setValue:nil forKey:Access_token];
    [MyUserDefaults synchronize];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    XGNavigationViewController *nav = [[XGNavigationViewController alloc]initWithRootViewController:[LoginViewController new]];
    window.rootViewController   = nav;

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



