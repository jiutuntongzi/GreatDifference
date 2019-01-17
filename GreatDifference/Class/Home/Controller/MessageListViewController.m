//
//  MessageListViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/25.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageCell.h"
#import "EmptyView.h"
#import "HomeHttpManager.h"
#import "MessageModelResult.h"

@interface MessageListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) EmptyView         *emptyView;
@property (nonatomic, assign) NSInteger          page;
@end

@implementation MessageListViewController
static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"消息";
    [self.view addSubview:self.tableView];
    [self addRefreshHeader:self.tableView];
    [self addRefreshFooter:self.tableView];
    
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:cellIdentifier];
    
}

- (void)refreshDataWithMore:(BOOL)more{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"10" forKey:@"pageSize"];
    if (!more) {
        self.page = 1;
    }else{
        self.page++;
    }
    [params setValue:[NSNumber numberWithInteger:self.page] forKey:@"pageIndex"];
    
    [HomeHttpManager getSystemMessageListWithParams:params success:^(MessageModelResult *responseObj) {
        
        if (!more) {
            self.dataSource = [responseObj.data mutableCopy];
        }else{
            [self.dataSource addObjectsFromArray:responseObj.data];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self endRefresh];
            [self.tableView reloadData];
        });

    } failure:^(id responseObj, NSError *error) {
        
        [self endRefresh];
    }];
}

#pragma mark -- getter
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

- (EmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:self.view.bounds];
        
    }
    return _emptyView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    MessageModel *messageModel = [self.dataSource objectAtIndex:indexPath.row];
    cell.systemMsg = messageModel;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
