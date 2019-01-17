//
//  EditAddressViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/18.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "EditAddressViewController.h"
#import "EditAddressCell.h"
#import "MapViewController.h"
#import "AddressModel.h"
#import "GlobalUtils.h"
#import "PersonalHttpManager.h"
#import "StringUtils.h"

@interface EditAddressViewController ()<UITableViewDataSource, UITableViewDelegate, MapViewControllerDelegate>
@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, strong) AddressModel      *locationModel;

@end

@implementation EditAddressViewController
static NSString *cellIdentifier =  @"normalCell";
static NSString *jumpCell       =  @"jumpCell";
static NSString *selectCell     =  @"selectCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self createDataSourceWithModel:self.addressModel];
    [self setupFooterView];
    
    if (!self.isAddAddress) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAddress)];
    }else{
        self.addressModel = [[AddressModel alloc]init];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCurrentLocation:) name:KNOTIFICATION_UPDATE_LOCATION object:nil];


    // Do any additional setup after loading the view.
}

- (void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.75];
    
    
    UIButton  *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, (SCREEN_WIDTH - 20), 40)];
    saveBtn.backgroundColor = THEMECOLOR;
    [saveBtn setTitle:@"保存收货地址" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.layer.cornerRadius  = 3;
    [saveBtn addTarget:self action:@selector(saveAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:lineView];
    [footerView addSubview:saveBtn];
    footerView.userInteractionEnabled = YES;
    self.tableView.tableFooterView = footerView;
}

- (void)getCurrentLocation:(NSNotification *)notification{
    BMKUserLocation *bmkLocation  = notification.object;
    if (self.locationModel) {
        return;
    }
    
    self.locationModel   = [GlobalUtils getUserLocationFromBMKLocation:bmkLocation];
    
}

- (void)createDataSourceWithModel:(AddressModel *)model{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"收货人" forKey:@"title"];
    [dic1 setValue:model.consignee forKey:@"detail"];
    [dic1 setValue:@"0" forKey:@"cellType"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"手机号码" forKey:@"title"];
    [dic2 setValue:model.mob forKey:@"detail"];
    [dic2 setValue:@"0" forKey:@"cellType"];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    NSString *city  = [NSString stringWithFormat:@"%@%@%@",model.province, model.city, model.district];
    if (!model.province) {
        city = @"";
    }
    [dic3 setValue:@"所在城市" forKey:@"title"];
    [dic3 setValue:city forKey:@"detail"];
    [dic3 setValue:@"1" forKey:@"cellType"];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setValue:@"收货地址" forKey:@"title"];
    [dic4 setValue:model.address forKey:@"detail"];
    [dic4 setValue:@"0" forKey:@"cellType"];
    
//    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
//    [dic5 setValue:@"楼号门牌" forKey:@"title"];
//    [dic5 setValue:@"28-9" forKey:@"detail"];
//    [dic5 setValue:@"0" forKey:@"cellType"];
//    
//    NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
//    [dic6 setValue:@"地址类型" forKey:@"title"];
//    [dic6 setValue:@"28-9" forKey:@"detail"];
//    [dic6 setValue:@"2" forKey:@"cellType"];
    
    [self.dataSource addObject:dic1];
    [self.dataSource addObject:dic2];
    [self.dataSource addObject:dic3];
    [self.dataSource addObject:dic4];

    [self.tableView reloadData];

}

#pragma mark -- getter
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

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:4];
    }
    return _dataSource;
}

#pragma mark -- tableViewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    EditAddressCellType cellType = [dic[@"cellType"] integerValue];
    EditAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];

    if (!cell) {
        cell = [[EditAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:cellType];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (cellType == EditAddressCellTypeJump) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setContentDic:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
        NSString *content = dic[@"detail"];
        CGFloat height = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        height = height>20?height:20;
        return height + 25;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSString *title = dic[@"title"];
    if ([title isEqualToString:@"所在城市"]) {
        MapViewController *mapVc = [[MapViewController alloc]init];

        mapVc.location = self.locationModel;
        mapVc.delegate = self;
        [self.navigationController pushViewController:mapVc animated:YES];
    }
}

#pragma mark -- clickedAction
- (void)didClickedLocation:(AddressModel *)addressModel{
    
    // 改变模型数据, 刷新tableView
//    self.addressModel.address = addressModel.address;
//    
    self.addressModel.province = addressModel.province;
    self.addressModel.city     = addressModel.city;
    self.addressModel.district = addressModel.district;
//
//    [self createDataSourceWithModel:self.addressModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    EditAddressCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@%@%@",addressModel.province, addressModel.city, addressModel.district];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:3 inSection:0];
    EditAddressCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
    cell1.detailTextView.text = addressModel.address;
}


- (void)saveAddressAction:(UIButton *)btn{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSInteger index = 0; index<self.dataSource.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        EditAddressCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([[cell getCellTitle] isEqualToString:@"收货人"]) {
            if ([StringUtils isEmpty:cell.detailTextView.text]) {
                [HUDUtils showAlert:@"请输入收货人"];
                return;
            }
            [params setValue:cell.detailTextView.text forKey:@"consignee"];
            
        }else if([[cell getCellTitle] isEqualToString:@"手机号码"]) {
            if ([StringUtils isEmpty:cell.detailTextView.text]) {
                [HUDUtils showAlert:@"请输入手机号码"];
                return;
            }
            [params setValue:cell.detailTextView.text forKey:@"mob"];
            
        }
        else if([[cell getCellTitle] isEqualToString:@"收货地址"]) {
            [params setValue:cell.detailTextView.text forKey:@"address"];
        }
        
    }
    [params setValue:self.addressModel.province forKey:@"province"];
    [params setValue:self.addressModel.city forKey:@"city"];
    [params setValue:self.addressModel.district forKey:@"district"];
    
    if (self.isAddAddress) {
        
        [HUDUtils showLoading:@"加载中"];
        [PersonalHttpManager addConsigneeAddressWithParams:params success:^(CommonModelResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_UPDATE_CONTACT_ADDRESS object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        } failure:^(id responseObj, NSError *error) {
            NSString *message = [responseObj objectForKey:@"message"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:message];
            });
        }];
        
    }else{
        [params setValue:self.addressModel.consigneeAddressId forKey:@"consigneeAddressId"];
        [HUDUtils showLoading:@"加载中"];
        
        [PersonalHttpManager modifyConsigneeAddressWithParams:params success:^(CommonModelResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_UPDATE_CONTACT_ADDRESS object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        } failure:^(id responseObj, NSError *error) {
            NSString *message = [responseObj objectForKey:@"message"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:message];
                
            });
        }];
    }
    
}



- (void)deleteAddress{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.addressModel.consigneeAddressId forKey:@"consigneeAddressId"];
    [PersonalHttpManager deleteConsigneeAddressWithParams:params success:^(CommonModelResult *responseObj) {
        [HUDUtils showAlert:@"删除成功"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [HUDUtils hideHud];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_UPDATE_CONTACT_ADDRESS object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } failure:^(id responseObj, NSError *error) {
        [HUDUtils showAlert:@"删除失败"];
        
    }];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
