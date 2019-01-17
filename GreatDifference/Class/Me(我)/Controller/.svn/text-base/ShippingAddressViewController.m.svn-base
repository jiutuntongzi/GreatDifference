//
//  ShippingAddressViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "MyAddressCell.h"
#import "EditAddressViewController.h"
#import "AddressModel.h"
#import "PersonalHttpManager.h"

#import "AddressListResult.h"

@interface ShippingAddressViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;
@end

@implementation ShippingAddressViewController
static NSString *cellIdentifier = @"reuseCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:cellIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addAddress)];
    self.dataSource = [NSMutableArray array];
    
    [self configureData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureData) name:KNOTIFICATION_UPDATE_CONTACT_ADDRESS object:nil];

    // Do any additional setup after loading the view.
}

- (void)configureData{
    [PersonalHttpManager getAddressListWithParams:nil success:^(AddressListResult *responseObj) {
        self.dataSource = [responseObj.data mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (void)addAddress{
    
    EditAddressViewController *editAddressVc = [[EditAddressViewController alloc]init];
    editAddressVc.isAddAddress = YES;
    editAddressVc.title = @"新增地址";
    [self.navigationController pushViewController:editAddressVc animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel *addressModel = [self.dataSource objectAtIndex:indexPath.row];
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.address = addressModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressModel *address = self.dataSource[indexPath.row];
    if (self.isSelectAddress) {
        if (self.selectAddressBlock) {
            self.selectAddressBlock(address);
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    EditAddressViewController *editAddressVc = [[EditAddressViewController alloc]init];
    editAddressVc.isAddAddress = NO;
    editAddressVc.addressModel   = [self.dataSource objectAtIndex:indexPath.row];
    editAddressVc.title = @"地址详情";
    [self.navigationController pushViewController:editAddressVc animated:YES];
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
