//
//  MapViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "HomeHttpManager.h"
//#import "UserLocation.h"
#import "AddressListResult.h"
#import "AddressCell.h"
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import "AddressDetailResult.h"
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface MapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) BMKMapView            *mapView;
@property (nonatomic, strong) BMKLocationService    *locationService;
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) UISearchBar           *searchBar;

@end

@implementation MapViewController
static NSString *myAnnotation    = @"myAnnotation";
static NSString *cellIdentifier  = @"reuseCell";

#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AddressCell class] forCellReuseIdentifier:cellIdentifier];

//   CLAuthorizationStatus status =  [CLLocationManager authorizationStatus];
    //定位服务是否可用
    BOOL enable=[CLLocationManager locationServicesEnabled];
    //是否具有定位权限
    int status=[CLLocationManager authorizationStatus];
    if(!enable || status<3)
    {
        //请求权限
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
        {
            //由于IOS8中定位的授权机制改变 需要进行手动授权
            CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
            //获取授权认证
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
            message:@"无法定位到您所在的城市，请前去开启GPS定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"去设置", nil];
        alertView.tag = 1000;
        [alertView show];
        
    }
    [self startObserve];
    [self fetchData];
    self.navigationItem.titleView = self.searchBar;
    UIView *rightView = [UIView new];
    rightView.frame = CGRectMake(0, 0, 30, 20);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
//    [self.view addSubview:self.searchBar];
//    [self setupFooterView];
    
}


#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    
    else
    {
        [self jumpSetting];
    }
    
}

- (void)jumpSetting
{
    //打开设置页面，去设置定位
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
        
    }
}

- (void)setupFooterView{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton *addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 40)];
    [addAddressBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];

    addAddressBtn.backgroundColor = THEMECOLOR;
    [footer addSubview:addAddressBtn];
    
    self.tableView.tableFooterView  = footer;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    
    self.mapView.delegate   = self;
//    self.locationService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillDisappear];
    
    _mapView.delegate = nil; // 不用时，置nil
    [self.searchBar resignFirstResponder];
}

- (void)fetchData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!self.location) {
        self.location = [[AddressModel alloc]init];
        self.location.longitude = [MyUserDefaults objectForKey:CurrentLongitude];
        self.location.latitude = [MyUserDefaults objectForKey:CurrentLatitude];

    }
    [params setValue:self.location.longitude forKey:@"longitude"];
    [params setValue:self.location.latitude forKey:@"latitude"];
    
    [HomeHttpManager getNearLocationWithParams:params success:^(AddressListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        NSString *message = [responseObj objectForKey:@"message"];
        [HUDUtils showAlert:message];
    }];
}

- (void)startObserve{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserHeading:) name:KNOTIFICATION_UPDATE_USERHEAD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserLocation:) name:KNOTIFICATION_UPDATE_LOCATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocationFail:) name:KNOTIFICATION_LOCATION_FAIL object:nil];

}



#pragma mark    -- getter
- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView    = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.95)];
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.showsUserLocation  = YES;
        _mapView.zoomLevel   =  16;
        _mapView.showMapScaleBar = YES;
    }
    return _mapView;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH * 0.95, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH * 0.95) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-70, 30)];
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.showsCancelButton = YES;
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
        _searchBar.delegate = self;
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
//        Class class = [UISearchBar class];
//        
//        UIImage *image = [self imageWithColor:[UIColor clearColor]];
//        _searchBar.backgroundImage = image;
//        [[UIBarButtonItem appearanceWhenContainedIn:class, nil] setImage:[UIImage imageNamed:@"search_icon"]];
//        [[UIBarButtonItem appearanceWhenContainedIn:class, nil] setTitle:@"搜"];
        
    }
    return _searchBar;
}

- (UIImage *)imageWithColor:(UIColor *)color {
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
  UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
  CGContextFillRect(context, rect);//用这个颜色填充这个上下文
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
  UIGraphicsEndImageContext();
  
  return image;
}
#pragma mark -- LocationNotification
 /*用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)updateUserHeading:(NSNotification *)notification{
    BMKUserLocation *userLocation = notification.object;
    [self.mapView updateLocationData:userLocation];
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)updateUserLocation:(NSNotification *)notification{
    BMKUserLocation *userLocation = notification.object;
    
    [self.mapView updateLocationData:userLocation];
    
}

- (void)userLocationFail:(NSNotification *)notification{
    
}

#pragma mark -- BMKMapViewDelegate
// 点击某一个有信息的点
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi{
    
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D location = mapPoi.pt;
    annotation.coordinate = location;
    annotation.title = mapPoi.text;
    [_mapView removeAnnotations:_mapView.annotations];
    
    [_mapView addAnnotation:annotation];

}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:myAnnotation];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:myAnnotation];
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            annotationView.animatesDrop = YES;// 设置该标注点动画显示
        }
        
        return annotationView;
    }
    return nil;
}

#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
        
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel   *addressModel = [self.dataSource objectAtIndex:indexPath.row];
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row == 0) {
        addressModel.locationIcon = @"home_current_location";
    }else{
        addressModel.locationIcon = @"location_icon";
    }
    cell.addressModel = addressModel;

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel   *addressModel = [self.dataSource objectAtIndex:indexPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:addressModel.longitude forKey:@"longitude"];
    [params setValue:addressModel.latitude forKey:@"latitude"];
    
    [HomeHttpManager getAddressDetailWithParams:params success:^(AddressDetailResult *responseObj) {
        
        if ([self.delegate respondsToSelector:@selector(didClickedLocation:)]) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate didClickedLocation:responseObj.data];
        }
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

-(void)getNearLocation:(NSString *)text{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:text forKey:@"address"];
    [params setValue:self.location.longitude forKey:@"longitude"];
    [params setValue:self.location.latitude forKey:@"latitude"];
    
    [HomeHttpManager getNearLocationWithParams:params success:^(AddressListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            AddressModel *address = [self.dataSource firstObject];
            
            BMKPointAnnotation *ano = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D location;
            location.longitude = [address.longitude doubleValue];
            location.latitude = [address.latitude doubleValue];
            ano.coordinate = location;
            ano.title   = address.name;
            [self.mapView showAnnotations:@[ano] animated:YES];
            
            [_mapView removeAnnotations:_mapView.annotations];
            
            [_mapView addAnnotation:ano];
            self.mapView.userTrackingMode = BMKUserTrackingModeNone;
            
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self getNearLocation:searchBar.text];
    
//    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
//    citySearchOption.pageIndex = 0;
//    citySearchOption.pageCapacity = 10;
//    citySearchOption.city= _cityText.text;
//    citySearchOption.keyword = _keyText.text;
//    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];

    [self getNearLocation:searchBar.text];
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
