//
//  LeaveMessageRecordViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "LeaveMessageRecordViewController.h"
#import "MessageCell.h"
#import "PersonalHttpManager.h"
#import "MessageDetailViewController.h"
#import "MessageModelResult.h"

@interface LeaveMessageRecordViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;@end

@implementation LeaveMessageRecordViewController
static NSString *cellIdentifier = @"leaveMessageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"留言记录";
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self fetchData];
}

- (void)fetchData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    [PersonalHttpManager getLeaveMessageListWithParams:params success:^(MessageModelResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *message = [self.dataSource objectAtIndex:indexPath.row];
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.message = message;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageModel *message = [self.dataSource objectAtIndex:indexPath.row];
    MessageDetailViewController *messageDetailVc = [[MessageDetailViewController alloc]init];
    messageDetailVc.messageId = message.leaveMsgId;
    [self.navigationController pushViewController:messageDetailVc animated:YES];
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
