//
//  StoreDetailViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "QRCodeViewController.h"
#import "BusinessLicenseViewController.h"

#import "StoreDetailCell.h"
#import "UIUtils.h"

#import "HomeHttpManager.h"

@interface StoreDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;

@end

@implementation StoreDetailViewController

static NSString *normalIdentifier =     @"normalCell";
static NSString *avatarIdentifier =     @"avatarCell";
static NSString *pickerIdentifier =     @"pickerCell";
static NSString *qrCodeIdentifier =     @"qrCodeCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    if (self.fromScan) {
        [self createDataWithModel:self.storeModel];
        [self.tableView reloadData];

        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.shopId forKey:@"shopId"];
    
    [HomeHttpManager getStoreDetailWithParams:param success:^(StoreModelResult *responseObj) {
        self.storeModel = responseObj.data;
        [self createDataWithModel:responseObj.data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
//    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.translucent = YES;
    
//    UIColor *color = THEMECOLOR;
//    UIImage *image = [UIUtils navigationBarFromColor:color];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds   = NO;
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)createDataWithModel:(StoreModel *)store
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        
        [dic1 setValue:@"店招" forKey:@"title"];
        [dic1 setValue:store.shopIcon forKey:@"detail"];
        [dic1 setValue:@"1" forKey:@"cellType"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setValue:@"店铺名称" forKey:@"title"];
        [dic2 setValue:store.shopName forKey:@"detail"];
        [dic2 setValue:@"0" forKey:@"cellType"];
        
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setValue:@"店铺二维码" forKey:@"title"];
        [dic3 setValue:@"" forKey:@"detail"];
        [dic3 setValue:@"3" forKey:@"cellType"];
        
        
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setValue:@"店铺地址" forKey:@"title"];
        [dic4 setValue:store.shopAddress forKey:@"detail"];
        [dic4 setValue:@"0" forKey:@"cellType"];
        
        
        NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
        [dic5 setValue:@"营业执照" forKey:@"title"];
        [dic5 setValue:@"" forKey:@"detail"];
        [dic5 setValue:@"0" forKey:@"cellType"];
        

        NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
        [dic6 setValue:@"营业时间" forKey:@"title"];
        [dic6 setValue:store.shopHours forKey:@"detail"];
        [dic6 setValue:@"0" forKey:@"cellType"];
        
        NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
        [dic7 setValue:@"联系方式" forKey:@"title"];
        [dic7 setValue:store.telphone forKey:@"detail"];
        [dic7 setValue:@"0" forKey:@"cellType"];
        
        [_dataSource addObject:dic1];
        [_dataSource addObject:dic2];
        [_dataSource addObject:dic3];
        [_dataSource addObject:dic4];

        [_dataSource addObject:dic6];

        [_dataSource addObject:dic7];
        [_dataSource addObject:dic5];


        
    }
    return _dataSource;
}


#pragma mark -- tableViewDataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSString *type = [dic valueForKey:@"cellType"];
    NSString *cellIdentifier;
    CellType celltype = CellTypeNormal;
    
    switch ([type integerValue]) {
        case 0:{
            cellIdentifier = normalIdentifier;
            celltype = CellTypeNormal;
        }
            break;
        case 1:{
            cellIdentifier = avatarIdentifier;
            celltype = CellTypeAvatar;
        }
            break;
        case 2:{
            cellIdentifier = pickerIdentifier;
            celltype = CellTypePicker;
        }
            break;
        case 3:{
            cellIdentifier = qrCodeIdentifier;
            celltype = CellTypeqrCode;
        }
            break;
            //            default:
            ////            celltype = CellTypeNormal
    }
    StoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[StoreDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:celltype];
    }
    if (indexPath.row == self.dataSource.count - 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setContent:dic];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    if (indexPath.row == 3) {
        NSMutableDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        static StoreDetailCell *cell;
        if (!cell) {
            cell = [[StoreDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalIdentifier cellType:CellTypeNormal];
        }
        [cell setContent:dic];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        if (height<40) {
            return 40;
        }
        return height + 1;
    }
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSString *title = dic[@"title"];
    if ([title isEqualToString:@"店铺二维码"]) {
        QRCodeViewController *qrCodeVc  = [[QRCodeViewController alloc]init];
        qrCodeVc.qrCodeUrl = self.storeModel.qrCode;
        qrCodeVc.title  =   @"店铺二维码";
        [self.navigationController pushViewController:qrCodeVc animated:YES];
        
    }else if ([title isEqualToString:@"营业执照"]){
        BusinessLicenseViewController *licenseVc = [[BusinessLicenseViewController alloc]init];
        licenseVc.title = @"营业执照";
        licenseVc.url = self.storeModel.businessLicenseImgUrl;
        [self.navigationController pushViewController:licenseVc animated:YES];

    }
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
