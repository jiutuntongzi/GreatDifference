//
//  BaseViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"

@interface BaseViewController ()

@property (nonatomic, strong) MJRefreshHeader *headerView;
@property (nonatomic, strong) MJRefreshFooter *footerView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    // Do any additional setup after loading the view.
}

- (void)addRefreshHeader:(UIScrollView *)tableView{
    
//    WS(self);
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      [self refreshDataWithMore:NO];
    }];
    [tableView.mj_header beginRefreshing];
    self.headerView = tableView.mj_header;
}

- (void)addRefreshFooter:(UIScrollView *)tableView{
    
    WS(self);
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself refreshDataWithMore:YES];
    }];
    self.footerView = tableView.mj_footer;
}

- (void)refreshDataWithMore:(BOOL )more{
    
}

/** 结束刷新 */
-(void)endRefresh
{
    if (self.headerView != nil) {
        [self.headerView endRefreshing];
    }
    if (self.footerView != nil) {
        [self.footerView endRefreshing];
        
    }
}

/** footer 提示没有更多数据 */
- (void)setNoMoreData
{
    if(self.footerView != nil){
        [self.footerView endRefreshingWithNoMoreData];
    }
}

/** 隐藏footer */
- (void)setFooterHidden:(BOOL)isHidden
{
    if(self.footerView != nil){
        self.footerView.hidden = isHidden;
    }
}

- (void)addTapAction{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    
}     // 添加弹起键盘手势

- (void)tapAction{
    [self.view endEditing:YES];
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
