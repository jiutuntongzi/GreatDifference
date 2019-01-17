//
//  SearchViewController.m
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHistoryCell.h"
#import "ShopStoreListViewController.h"
//#import "MessageListViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UISearchBar       *searchBar;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@end

@implementation SearchViewController

static NSString *cellIdentifier = @"reuseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self configureBaseUI];
    [self fetchData];
    [self.view addSubview:self.tableView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(kSpace, 0, SCREEN_WIDTH-30, 30)];
    _searchBar.placeholder = @"请输入关键字";
    _searchBar.showsCancelButton = YES;
    _searchBar.searchBarStyle = UISearchBarStyleProminent;
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = NO;
//    self.tableView.tableHeaderView = _searchBar;
    self.navigationItem.titleView = _searchBar;
    UIView *rightView = [UIView new];
    rightView.frame = CGRectMake(0, 0, 30, 20);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
    [self.tableView registerClass:[SearchHistoryCell class] forCellReuseIdentifier:cellIdentifier];
//改变searchBar上cancle按钮的属性
//    Class class = [UISearchBar class];

//
//    [[UIBarButtonItem appearanceWhenContainedIn:class, nil] setImage:[UIImage imageNamed:@"search_icon"]];
//    [[UIBarButtonItem appearanceWhenContainedIn:class, nil] setTitle:@"搜"];




//    for(UIView *view in  [[[_searchBar subviews] objectAtIndex:0] subviews]) {
//        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
//            UIButton * cancel =(UIButton *)view;
////            cancel.frame = CGRectMake(0, 0, 40, 40);
//            [cancel setTitle:@"" forState:UIControlStateNormal];
//            [cancel setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
//        }
//    }

    
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}
- (void)dealloc{
    
}

//- (void)configureBaseUI{
//    
//    self.navigationItem.titleView = self.searchBar;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickedSearchBtn:)];
//    
//}


- (void)fetchData{

    NSMutableArray *tempArray = [[NSMutableArray alloc]init];

    tempArray = [[MyUserDefaults objectForKey:SearchStoreHistory] mutableCopy];
        
    self.dataSource = tempArray;
    [self.tableView reloadData];
}
#pragma mark -- getter

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        _searchBar.barStyle = UISearchBarStyleDefault;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark -- tableDataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.dataSource[indexPath.row];
    SearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.titleLabel.text = name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeader = [[UIView alloc]init];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpace, kSpace, SCREEN_WIDTH/4, 20)];
    titleLabel.text = @"搜索历史";
    
    UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, kSpace, 70, 25)];
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearBtn setImage:[UIImage imageNamed:@"clear_searchHistory_icon"] forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearBtn addTarget:self action:@selector(clearHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [sectionHeader addSubview:titleLabel];
    [sectionHeader addSubview:clearBtn];
    
    
    return sectionHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * searchText = [self.dataSource objectAtIndex:indexPath.row];
    self.searchBar.text = searchText;
    [self searchBarCancelButtonClicked:self.searchBar];
}

#pragma mark -- searchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    [self didClickedSearchBtn:nil];
    [self searchBarCancelButtonClicked:searchBar];
}


- (void)clearHistoryAction:(UIButton *)btn{
    
    [MyUserDefaults setValue:nil forKey:SearchStoreHistory];
    [MyUserDefaults synchronize];
    
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    ShopStoreListViewController *shopListVc = [[ShopStoreListViewController alloc]init];
    shopListVc.shopName = searchBar.text;
    shopListVc.addressModel = self.address;
//    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:SearchStoreHistory]];
    if ([tempArray containsObject:self.searchBar.text]){
        [tempArray removeObject:self.searchBar.text];
    };
    
    [tempArray insertObject:self.searchBar.text atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:SearchStoreHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:shopListVc animated:YES];
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
