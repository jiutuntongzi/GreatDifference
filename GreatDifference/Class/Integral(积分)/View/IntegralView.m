//
//  IntegralView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/17.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "IntegralView.h"
#import "MyWalletCell.h"
#import "WalletModel.h"
#import "MyWalletHeaderView.h"

@interface IntegralView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView             *tableView;
@property (nonatomic, strong) NSMutableArray          *dataSource;

@end
@implementation IntegralView
static NSString *cellIdentifier = @"reuseCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        MyWalletHeaderView *headerView = [[MyWalletHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*2/5- 20)];
        self.tableView.tableHeaderView = headerView;
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        [self.tableView registerClass:[MyWalletCell class] forCellReuseIdentifier:cellIdentifier];
        for (NSInteger index = 0; index < 3; index++) {
            WalletModel *model = [[WalletModel alloc]init];
            model.title = @"好友消费得分润";
            model.content   =   @"您的好友xx于2016年11.11光棍节成功消费500元,现返回xx分润，恭喜发财,红包拿来";
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];


    }
    return self;
}

- (instancetype)initWithDataSource:(NSMutableArray *)dataCourse{
    self = [super init];
    if (self) {
        _dataSource = dataCourse;
        
    }
    return self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWalletCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    WalletModel *model = self.dataSource[indexPath.row];
    cell.wallet = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    titleLabel.text = @"分润来源";
    titleLabel.textColor = THEMECOLOR;
    titleLabel.font     = XGFONT(15);
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
