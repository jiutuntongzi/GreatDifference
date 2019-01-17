
//
//  PayTypeView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/5.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "PayTypeView.h"

@interface PayTypeView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@end
@implementation PayTypeView

#pragma mark -- initialization
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createDataSource];
        [self addSubview:self.tableView];
    }
    return self;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionHeaderHeight = 50;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)createDataSource{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"run_icon" forKey:@"icon"];
    [dic setValue:@"分润支付" forKey:@"title"];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"zhifuBao_logo" forKey:@"icon"];
    [dic1 setValue:@"支付宝" forKey:@"title"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"weChatLogo" forKey:@"icon"];
    [dic2 setValue:@"微信支付" forKey:@"title"];
    
    [self.dataSource addObject:dic];
    [self.dataSource addObject:dic1];
    [self.dataSource addObject:dic2];
}

#pragma mark -- tableViewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"reuseCell";

    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = dic[@"title"];
    cell.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = XGFONT(18);
    titleLabel.text     = @"选择支付方式";
    titleLabel.userInteractionEnabled = YES;
    UIButton *closeBtn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 40, 40)];
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [closeBtn setImage:[UIImage imageNamed:@"quality_close_icon"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
//    closeBtn.backgroundColor = [UIColor redColor];
    
    [titleLabel addSubview:closeBtn];
    return titleLabel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didClickedPayTypeBlock) {
        self.didClickedPayTypeBlock(tableView, indexPath);
    }
}

- (void)closeAction:(UIButton *)btn{
    if (self.closeBlock) {
        self.closeBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
