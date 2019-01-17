//
//  HomeViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeCenterView.h"
#import "AppDelegate.h"
#import "ShopStoreListViewController.h"
#import "LifeServiceViewController.h"

#import "ScanViewController.h"
#import "MessageListViewController.h"
#import "MapViewController.h"
#import "StoreViewController.h"

#import "LoginViewController.h"
#import "StoreModel.h"
#import "HomeHttpManager.h"
#import "UserLocationResult.h"
#import "BannerModelResult.h"

#import "BMKManager.h"
#import "ImageUtils.h"

#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, BMKLocationServiceDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) BMKLocationService    *locationService;
@property (nonatomic, assign) BOOL              isCity;
@property (nonatomic, strong) UIButton          *cityBtn;
@property (nonatomic, strong) AddressModel      *addressModel;
@property (nonatomic, strong) UIButton          *footerBtn;
@property (nonatomic, strong) HomeHeaderView    *headerView;
@property (nonatomic, strong) Banners           *banners;

@end

@implementation HomeViewController
static NSString *cellIdentifier     = @"reuseCell";

#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self setNavigationBar];
    [self setupTableFooterView];
    [self setupTableHeaderView];
    
    [[BMKManager sharedInstance] startLocationService];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCurrentCity:)name:KNOTIFICATION_UPDATE_LOCATION object:nil];
    [self fetchData];

//    _locationService = [[BMKLocationService alloc]init];
//    [self.locationService startUserLocationService];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"demo" style:UIBarButtonItemStyleDone target:self action:@selector(testAction)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isCity = NO;
}

#pragma mark -- configureData
- (void)fetchData{
    
    [HomeHttpManager getHomeDataWithParams:nil success:^(BannerModelResult *responseObj) {
        Banners *banners = responseObj.data;
        NSString *imageUrl = banners.mall.bannerIcon;
        [self.headerView setDataSources:banners.banners];
        self.banners = banners;
        [ImageUtils loadImageWithLastComponentUrl:imageUrl button:self.footerBtn placeHolder:[UIImage imageNamed:@"home_oversea"]];
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (void)getCurrentCity:(NSNotification *)notification{
    BMKUserLocation *userLocation = notification.object;
    CLLocationCoordinate2D coordinate  = userLocation.location.coordinate;
    NSString *longitudeStr  = [NSString stringWithFormat:@"%.7f", coordinate.longitude];
    NSString *latitudeStr  = [NSString stringWithFormat:@"%.7f", coordinate.latitude];
    
    if (!_addressModel) {
        _addressModel = [[AddressModel alloc]init];
    }
    _addressModel.longitude = longitudeStr;
    _addressModel.latitude  = latitudeStr;
    
    if (self.isCity) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.addressModel.longitude forKey:@"longitude"];
    [params setValue:self.addressModel.latitude forKey:@"latitude"];
    
    [MyUserDefaults setObject:longitudeStr forKey:CurrentLongitude];
    [MyUserDefaults setObject:latitudeStr forKey:CurrentLatitude];
    [MyUserDefaults synchronize];
    
    [HomeHttpManager getCurrentCityWithParams:params success:^(UserLocationResult *responseObj) {
        NSString *city  = responseObj.data;
        self.isCity = YES;

        [self.cityBtn setTitle:city forState:UIControlStateNormal];
        
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
}


- (void)setNavigationBar{
    UIButton *locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [locationBtn setImage:[UIImage imageNamed:@"home_location_icon"] forState:UIControlStateNormal];
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -0, 0, 5);
    [locationBtn setTitle:@"深圳市" forState:UIControlStateNormal];
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(didClickedLocationButton) forControlEvents:UIControlEventTouchUpInside];
    self.cityBtn        = locationBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:locationBtn];
    
    UIButton *scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [scanBtn setImage:[UIImage imageNamed:@"home_scan_icon"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithCustomView:scanBtn];

    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [messageBtn setImage:[UIImage imageNamed:@"home_messages_icon"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];

    self.navigationItem.rightBarButtonItems = @[messageItem, scanItem];
}


- (void)setupTableHeaderView{
    CGFloat height = 209;
    if (IS_IPHONE_5) {
        height = height *0.853;
    }else if (IS_IPHONE_6SPlus){
        height = 1.1 *height;
    }
    HomeHeaderView *headerView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) bannerType:BannerTypeHome];
    self.headerView = headerView;
    self.tableView.tableHeaderView  = headerView;

}

- (void)setupTableFooterView{
    CGFloat height = 209;
    if (IS_IPHONE_5) {
        height = height *0.853;
    }else if (IS_IPHONE_6SPlus){
        height = 1.1 *height;
    }
    
    _footerBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - ((SCREEN_WIDTH - 80)/3*2+30)- height - 64 - 49)];
    [_footerBtn addTarget:self action:@selector(didClickedFooterBtn) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.footerBtn;
}

#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedSectionHeaderHeight =  (SCREEN_WIDTH - 80)/3*2+30;
    }
    return _tableView;
}

#pragma mark    -- tableViewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = @"hello";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeCenterView *sectionView = [[HomeCenterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 80)/3*2+30)];
    sectionView.backgroundColor = [UIColor whiteColor];
    sectionView.centerCellBlock = ^(NSIndexPath *indexPath, StoreModel *model){
        ShopStoreListViewController *vc = [[ShopStoreListViewController alloc]init];
        vc.title = model.shopName;
        vc.addressModel = self.addressModel;
        vc.type     = indexPath.row + 1;
        if ([model.shopName isEqualToString:@"生活服务"]) {
            LifeServiceViewController *lifeServiceVc = [[LifeServiceViewController alloc]init];
            lifeServiceVc.sellerTypeId = model.storeTypeId;
            lifeServiceVc.addressModel  = self.addressModel;
            [self.navigationController pushViewController:lifeServiceVc animated:YES];
            return ;
        }
        [self.navigationController pushViewController:vc animated:YES];
    };
    return sectionView;
}

#pragma mark -- clickedAction

- (void)testAction{
    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
}

- (void)didClickedLocationButton{
    MapViewController *mapVc    = [[MapViewController alloc]init];
    mapVc.location  = self.addressModel;
    [self.navigationController pushViewController:mapVc animated:YES];
}
- (void)scanAction{
    
    ScanViewController *scanVc = [[ScanViewController alloc]init];
    scanVc.fromHome = YES;
    [self.navigationController pushViewController:scanVc animated:YES];
    
}

- (void)messageAction{
    
    [self.navigationController pushViewController:[MessageListViewController new] animated:YES];
}

- (void)didClickedFooterBtn{
    StoreViewController *storeVc = [[StoreViewController alloc]init];
    storeVc.shopId = self.banners.mall.targetShopId;
    [self.navigationController pushViewController:storeVc animated:YES];
    
}
//- tableView
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
