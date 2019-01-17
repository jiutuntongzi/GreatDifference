//
//  StoreViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "StoreViewController.h"
#import "GoodsDetailViewController.h"
#import "StoreDetailViewController.h"

#import "StoreHeaderView.h"

#import "GoodsCell.h"
#import "GoodsTypeCell.h"
#import "GoodsModelListResult.h"
#import "GoodsTypeModel.h"
#import "UIUtils.h"
#import "StoreOverViewResult.h"

#import "HomeHttpManager.h"
#import "ScanViewController.h"
#import "ContactServiceViewController.h"

@interface StoreViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) StoreHeaderView   *storeHeaderView;
@property (nonatomic, strong) UITableView       *goodsTypeTableView; // 商品类型
@property (nonatomic, strong) UITableView       *goodsTableView; // 商品列表
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) NSMutableArray    *typeDataSource;

@property (nonatomic, assign) CGFloat           selectIndex;
//@property (nonatomic, assign) CGFloat           lastSelectIndex;
@property (nonatomic, strong) StoreModel        *storeModel;
@property (nonatomic, strong) UIView            *navigationBarView;
@property (nonatomic, strong) UIButton          *collectBtn;
@property (nonatomic, strong) GoodsTypeModel        *goodsType;

@end

@implementation StoreViewController
static NSString *goodsTypeCellId  = @"goodsTypeCell";
static NSString *goodsCellId      = @"goodsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = 0;

    self.view.backgroundColor = [UIColor whiteColor];

    
//    self.lastSelectIndex = 0;
    [self setuptoreHeaderView];
    [self setTableView];
    [self setNavigationBar];
//    [self addRefreshHeader:self.goodsTypeTableView];
//    [self addRefreshFooter:self.goodsTypeTableView];
    
    [self addRefreshHeader:self.goodsTableView];
    [self addRefreshFooter:self.goodsTableView];
//    [self configureData];

    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.shopId forKey:@"shopId"];
    [param setValue:@"1" forKey:@"pageIndex"];
    [param setValue:@"10" forKey:@"pageSize"];
    
    [HomeHttpManager getStoreOverViewWithParams:param success:^(StoreOverViewResult *responseObj) {
        self.storeModel = responseObj.data;
        _storeHeaderView.storeModel  = self.storeModel;
        if (self.storeModel.productTypeList.count < 1) {
            return ;
        }
        
        self.collectBtn.selected = [self.storeModel.isCollection integerValue];
        self.typeDataSource = [responseObj.data.productTypeList mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.goodsTypeTableView reloadData];
//            [self.goodsTableView reloadData];

            NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.goodsTypeTableView selectRowAtIndexPath:indexP animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self tableView:self.goodsTypeTableView didSelectRowAtIndexPath:indexP];

        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"];
    backgroundView.backgroundColor = XGCOLOR(255, 255, 255); // 颜色自己选
    backgroundView.alpha = 0; // 做渐变最好再设置一下
    self.navigationBarView = backgroundView;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    self.bckView.backgroundColor = XGCOLOR(255, 255, 255);
    self.navigationBarView.alpha = 0;


}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//    self.bckView.backgroundColor = THEMECOLOR;
    self.navigationBarView.alpha = 1.0;


}

- (void)refreshDataWithMore:(BOOL)more{

    NSInteger pageIndex = 1;
    if (more) {
        pageIndex = self.goodsType.pageIndex;
        pageIndex++;
    }

    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:self.goodsType.productTypeId forKey:@"productTypeId"];
    [params setValue:[NSNumber numberWithInteger:pageIndex] forKey:@"pageIndex"];
    [params setValue:@"10" forKey:@"pageSize"];
    [params setValue:self.shopId forKey:@"shopId"];
    
    [HomeHttpManager getGoodsListWithParams:params success:^(GoodsModelListResult *responseObj) {
        if (!more) {
            self.dataSource = [responseObj.data mutableCopy];
        }else{
            [self.dataSource addObjectsFromArray:responseObj.data];
            
        }
        
//        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.goodsType.pageIndex = pageIndex;

            [self.goodsTableView reloadData];
            [self endRefresh];

        });
    } failure:^(id responseObj, NSError *error) {
        [self endRefresh];

    }];
    
    
}




- (void)setNavigationBar{
    
    // 创建扫描按钮
    UIButton *saomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [saomBtn setImage:[UIImage imageNamed:@"store_sao_icon"] forState:UIControlStateNormal];
    saomBtn.tag = 101;
    [saomBtn addTarget:self action:@selector(topBarAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saoItem = [[UIBarButtonItem alloc]initWithCustomView:saomBtn];
    
    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [collectBtn setImage:[UIImage imageNamed:@"store_collect_icon"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"collect_icon_select"] forState:UIControlStateSelected];
    
    collectBtn.tag  = 102;
    self.collectBtn = collectBtn;
    [collectBtn addTarget:self action:@selector(topBarAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collectBtn];
    
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [messageBtn setImage:[UIImage imageNamed:@"store_message_icon"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(topBarAction:) forControlEvents:UIControlEventTouchUpInside];
    messageBtn.tag  = 103;
//    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
    
    self.navigationItem.rightBarButtonItems = @[collectItem, saoItem];
    UIView *navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:navigationBar];
}

- (UITableView *)goodsTypeTableView
{
    if (!_goodsTypeTableView) {
        _goodsTypeTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTypeTableView.tableFooterView = [UIView new];
        _goodsTypeTableView.dataSource = self;
        _goodsTypeTableView.delegate = self;
    }
    return _goodsTypeTableView;
}


- (UITableView *)goodsTableView
{
    if (!_goodsTableView) {
        _goodsTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _goodsTableView.tableFooterView = [UIView new];
        _goodsTableView.dataSource = self;
        _goodsTableView.delegate = self;
//        _goodsTableView.backgroundColor = [UIColor greenColor];
    }
    return _goodsTableView;
}

- (void)setuptoreHeaderView{
    _storeHeaderView = [[StoreHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    WS(self);
    _storeHeaderView.clickedAvatarBlock = ^(id model){
        
        StoreDetailViewController *storeDetailVc    = [[StoreDetailViewController alloc]init];
        storeDetailVc.shopId    = weakself.shopId;
        [weakself.navigationController pushViewController:storeDetailVc animated:YES];

    };
    [self.view addSubview:_storeHeaderView];
}

- (void)setTableView{
    [self.view addSubview:self.goodsTableView];
    [self.view addSubview:self.goodsTypeTableView];

    CGFloat goodsTypeY = CGRectGetMaxY(self.storeHeaderView.frame);
    CGFloat goodsTypeW = SCREEN_WIDTH/4+1;
    CGFloat goodsTypeH = SCREEN_HEIGHT - goodsTypeY;
    
    self.goodsTypeTableView.frame = CGRectMake(0, goodsTypeY, goodsTypeW, goodsTypeH);
    self.goodsTableView.frame = CGRectMake(goodsTypeW , goodsTypeY, SCREEN_WIDTH - goodsTypeW, goodsTypeH);
    
    [self.goodsTypeTableView registerClass:[GoodsTypeCell class] forCellReuseIdentifier:goodsTypeCellId];
    [self.goodsTableView registerClass:[GoodsCell class] forCellReuseIdentifier:goodsCellId];

    //    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(goodsTypeW - 5, 0, 1, goodsTypeH)];
//    lineView.backgroundColor = [UIColor redColor];
//    [self.goodsTypeTableView addSubview:lineView];
}

#pragma mark -- tableViewDataSource && delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.goodsTypeTableView) {
        return self.typeDataSource.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.goodsTypeTableView) {
        GoodsTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:goodsTypeCellId];
        GoodsTypeModel *model = [self.typeDataSource objectAtIndex:indexPath.row];

        cell.goodsType = model;
        return cell;
    }else{
      GoodsCell  *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellId];
        GoodsModel *goodsModel = [self.dataSource objectAtIndex:indexPath.row];
        cell.goodsModel = goodsModel;
        cell.addGoodsBlock = ^(GoodsModel *model){
            [self addShopCart:model];
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.goodsTypeTableView) {
        return 50;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.goodsTypeTableView) {
        self.selectIndex = indexPath.row;
//        GoodsTypeCell  *cell = (GoodsTypeCell  *)[tableView cellForRowAtIndexPath:indexPath];
//        cell.titleLabel.textColor = [UIColor magentaColor];
        GoodsTypeModel *typeModel = self.typeDataSource[indexPath.row];
        self.goodsType = typeModel;

        [self refreshDataWithMore:NO];
        return;
    }
    
    GoodsDetailViewController *goodsDetailVc = [[GoodsDetailViewController alloc]init];
    GoodsModel *goodsModel = [self.dataSource objectAtIndex:indexPath.row];
    goodsDetailVc.productId = goodsModel.productId;
    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)viewDidLayoutSubviews {
    
    if ([self.goodsTypeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.goodsTypeTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.goodsTypeTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.goodsTypeTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([self.goodsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.goodsTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.goodsTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.goodsTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark -- clickedAction


- (void)topBarAction:(UIButton *)btn{
    switch (btn.tag) {
        case 101:{
            ScanViewController *scanVc = [[ScanViewController alloc]init];
            scanVc.shopId = self.shopId;
            [self.navigationController pushViewController:scanVc animated:YES];
        }
            break;
        case 102:{
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setValue:self.storeModel.shopId forKey:@"shopId"];
            [HomeHttpManager collectStoreWithParams:param success:^(CommonModelResult *responseObj) {
                self.collectBtn.selected = !self.collectBtn.selected;
            } failure:^(id responseObj, NSError *error) {
                
            }];
        }
            break;
        case 103:{
            ContactServiceViewController *contactServiceVc = [[ContactServiceViewController alloc]init];
            [self.navigationController pushViewController:contactServiceVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)addShopCart:(GoodsModel *)goods{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:goods.productId forKey:@"productId"];
    [HomeHttpManager addShopCartWithParams:param success:^(CommonModelResult *responseObj) {
        XGLog(@"%@", responseObj);
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils showAlert:@"添加成功"];
            
        });
        
    } failure:^(id responseObj, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils showError:@"添加失败"];
            
        });
    }];
}

- (void)dealloc{
    
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
