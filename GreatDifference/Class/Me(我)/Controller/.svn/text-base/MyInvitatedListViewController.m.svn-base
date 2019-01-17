//
//  MyInvitatedListViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/20.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "MyInvitatedListViewController.h"
#import "InviteUserCell.h"
#import "PersonalHttpManager.h"
#import "InviteListResult.h"

@interface MyInvitatedListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, assign) CGFloat                page;
@end

@implementation MyInvitatedListViewController

static NSString *cellIdentifier = @"reuseCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"邀请人列表";
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[InviteUserCell class] forCellReuseIdentifier:cellIdentifier];
    
//    [self fetchData];
    [self addRefreshFooter:self.tableView];
    [self addRefreshHeader:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)refreshDataWithMore:(BOOL )more{
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"10" forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:self.page] forKey:@"pageIndex"];
    
    [PersonalHttpManager getInvitateUserListWithParams:params success:^(InviteListResult *responseObj) {
        if (!more) {
            self.dataSource = [responseObj.data mutableCopy];;
        }else{
            [self.dataSource addObjectsFromArray:responseObj.data];
        }
        [self endRefresh];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        [self endRefresh];
        NSString *message = [responseObj objectForKey:@"message"];
        [HUDUtils showAlert:message];
    }];
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
    InvitateUsersModel   *model = [self.dataSource objectAtIndex:indexPath.row];
    InviteUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.invitateModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
