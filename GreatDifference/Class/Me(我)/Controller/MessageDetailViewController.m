//
//  MessageDetailViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2017/1/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailCell.h"
#import "MessageModel.h"
#import "ChatBottomView.h"
#import "PersonalHttpManager.h"
#import "MessageDetailResult.h"
#import "GoodsInfoCell.h"

@interface MessageDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) ChatBottomView        *chatBottomView;
@end

@implementation MessageDetailViewController
static NSString  *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatBottomView];
    [self addTapAction];
    
//    for (NSInteger index = 0 ; index < 6; index++) {
//        MessageModel *model = [[MessageModel alloc]init];
//        if (index%2 == 1) {
//            model.username = @"我";
//            model.content = @"怎么搞的我爱你亲爱的姑娘见到你心就发凉哦恐龙拉接收到可令肌爱的姑娘见到你";
//            model.isSender = YES;
//            [self.dataSource addObject:model];
//            model.time = @"2017-1-26";
//            continue;
//        }
//        model.username = @"客户妹子";
//        model.content = @"不可能吧,这是不存在的";
//        model.isSender = NO;
//        model.time = @"2017-1-26";
//        [self.dataSource addObject:model];
//    }
//    
//    [self.tableView reloadData];
    // Do any additional setup after loading the view.
    [self addObserver];
    [self fetchData];

}

- (void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)fetchData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.messageId forKey:@"leaveMsgId"];
    
    [PersonalHttpManager getMessageDetailWithParams:param success:^(MessageDetailResult *responseObj) {
        MessageModel *messageModel = responseObj.data;
        
        self.dataSource = [messageModel.replyList mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 220) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = XGCOLOR(239, 239, 239);
        
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (ChatBottomView *)chatBottomView{
    if (!_chatBottomView) {
        _chatBottomView = [[ChatBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 220, SCREEN_WIDTH, 220)];
        _chatBottomView.backgroundColor = [UIColor whiteColor];
        WS(self);
        _chatBottomView.submitBlock = ^(NSString *text){
            [weakself replyMessage:text];
        };
    }
    return _chatBottomView;
}

#pragma mark -- tableViewDataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.goods) {
        return self.dataSource.count+1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.goods) {
        GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[GoodsInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.goodsModel = self.goods;
            return cell;
        }
    }
    MessageModel *model = [self.dataSource objectAtIndex:indexPath.row];

    MessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MessageDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    cell.contentView.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.message = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (self.goods) {
            return 80;
        }
    }
    MessageModel *model = [self.dataSource objectAtIndex:indexPath.row];
    CGFloat height = [MessageDetailCell getCellHeight:model];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *noti = notification.userInfo;
    CGRect beginFrame =  [[noti objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration    = [[noti objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (self.view.frame.origin.y<0) {
            return ;
        }
        self.view.frame = CGRectMake(0, -beginFrame.size.height + 60, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    NSDictionary *noti = notification.userInfo;
//    CGRect endFrame =  [[noti objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration    = [[noti objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)replyMessage:(NSString *)message{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:message forKey:@"content"];
    [params setValue:self.messageId forKey:@"leaveMsgId"];
    
    [PersonalHttpManager replyLeaveMessageWithParams:params success:^(CommonModelResult *responseObj) {
        [self fetchData];
        [self.chatBottomView clearText];
    } failure:^(id responseObj, NSError *error) {
        
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
