//
//  GoodsDetailViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/26.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ConfirmOrderViewController.h"
#import "UIUtils.h"

#import "HomeHeaderView.h"
#import "GoodsDetailCell.h"
#import "GoodsDetailBottomBar.h"
#import "QualityView.h"
#import "HomeHttpManager.h"
#import "GoodsModelResult.h"
#import "MessageDetailViewController.h"

#import "BigOrderDetailResult.h"
#import "ShoppingCartViewController.h"

#import "ShoppingHttpManager.h"
#import "BannerModel.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "CompleteUserInfoViewController.h"

@interface GoodsDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) UITextField           *textField;
@property (nonatomic, strong) QualityView           *qualityView;
@property (nonatomic, strong) UIView                *coverView;
@property (nonatomic, strong) GoodsModel            *goodsModel;
@property (nonatomic, strong) UIView                *navigationBarView;
@property (nonatomic, strong) GoodsDetailBottomBar  *bottomBar;
@property (nonatomic, strong) GoodsDetailCell        *reuseCell;


@end

@implementation GoodsDetailViewController

static NSString *cellIdentifier = @"reuseCell";
#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[GoodsDetailCell class] forCellReuseIdentifier:cellIdentifier];
    self.reuseCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [self.view addSubview:self.textField];
    [self setupBottomBar];
    [self handleQualityView];
    [self configuraData];
    
    UIView *backgroundView = [[self.navigationController valueForKey:@"_navigationBar"] valueForKey:@"_backgroundView"];
    backgroundView.backgroundColor = XGCOLOR(255, 255, 255); // 颜色自己选
    backgroundView.alpha = 0; // 做渐变最好再设置一下
    self.navigationBarView = backgroundView;

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction:)];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBarView.alpha = 0;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationBarView.alpha = 1.0;
    [self.textField resignFirstResponder];

//    self.
}

- (void)configuraData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.productId forKey:@"productId"];
    [HomeHttpManager getGoodsDetailWithParams:param success:^(GoodsModelResult *responseObj) {
        self.goodsModel = responseObj.data;
        [self setupHeaderView];
        
        [self createDataWithGoodsModel:responseObj.data];
        if ([self.goodsModel.isCollection isEqualToString:@"1"]) {
            self.bottomBar.collectBtn.selected = YES;
        }else{
            self.bottomBar.collectBtn.selected = NO;

        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}


- (void)createDataWithGoodsModel:(GoodsModel *)model{
    self.dataSource = [NSMutableArray array];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"商品名称" forKey:@"title"];
    [dic1 setValue:model.name forKey:@"detail"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"商品价格" forKey:@"title"];
    [dic2 setValue:[NSString stringWithFormat:@"￥%@",model.price] forKey:@"detail"];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setValue:@"产品规格" forKey:@"title"];
    [dic3 setValue:model.standard forKey:@"detail"];
    
    
    [self.dataSource addObject:dic1];
    [self.dataSource addObject:dic2];
    [self.dataSource addObject:dic3];

    
}

- (void)setupBottomBar{
    GoodsDetailBottomBar *bottom = [[GoodsDetailBottomBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    self.bottomBar = bottom;
    bottom.bottomBarBlock = ^(id model, BottomBarType type){
        switch (type) {
            case BottomBarTypeLeave:
            {
                MessageDetailViewController *messageDetailVc = [[MessageDetailViewController alloc]init];
//                contactVc.navigationBarHidden = YES;
                messageDetailVc.goods   = self.goodsModel;
                [self.navigationController pushViewController:messageDetailVc animated:YES];
            }
                break;
            case BottomBarTypeCollect:
            {
                [self collectGoods]; // 收藏商品
            }
                break;
                
            case BottomBarTypeShopCart:
            {
                ShoppingCartViewController *shoppingCartVc = [[ShoppingCartViewController alloc]init];
                shoppingCartVc.fromGoodsDetail = YES;
                [self.navigationController pushViewController:shoppingCartVc animated:YES];
            }
                break;
                
            case BottomBarTypeAddShopCart:
            {
                [self addShopCart];
            }
                break;
                
            case BottomBarTypeBuy:
            {
                [self.textField becomeFirstResponder];
                [self.navigationController.view addSubview:self.coverView];
                
                
            }
                break;
        }
    };
    [self.view addSubview:bottom];
}

- (void)handleQualityView{
    WS(self);
    
    self.qualityView.closeBlock = ^{
        [weakself.textField resignFirstResponder];
        [weakself.coverView removeFromSuperview];
    };
    
    
    // 购买
    self.qualityView.sureBlock = ^(NSInteger num){
        [weakself.textField resignFirstResponder];
        [weakself.coverView removeFromSuperview];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:[NSNumber numberWithInteger:num] forKey:@"num"];
        [params setValue:weakself.productId forKey:@"productId"];
        
        [ShoppingHttpManager purchaseGoodsWithParams:params success:^(BigOrderDetailResult *responseObj) {
            
            ConfirmOrderViewController *confirmOrderVc = [[ConfirmOrderViewController alloc]init];
            weakself.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:weakself action:@selector(backAction)];
            confirmOrderVc.bigOrder = responseObj.data;
            [weakself.navigationController pushViewController:confirmOrderVc animated:YES];
        } failure:^(id responseObj, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *resultState = [responseObj objectForKey:@"state"];
                if ([resultState integerValue] == -3) {
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未完善个人信息,需完善信息才可结算商品" delegate:weakself cancelButtonTitle:@"取消" otherButtonTitles:@"去完善", nil];
//                    alert.delegate = weakself;
//                    [alert show];
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还未完善个人信息,需完善信息才可结算商品" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction  *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去完善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        CompleteUserInfoViewController *completeVc = [[CompleteUserInfoViewController alloc]init];
                        [weakself.navigationController pushViewController:completeVc animated:YES];
                    }];
                    
                    [alertController addAction:cancelAction];
                    [alertController addAction:sureAction];
                    [weakself presentViewController:alertController animated:YES completion:nil];
                    
                    return;
                    
                }
                
                NSString *resultMessage = [responseObj objectForKey:@"message"];
                XGLog(@"错误信息:%@", resultMessage);
                [HUDUtils showAlert:resultMessage];
            });

        }];
        
        
    };
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.view endEditing:YES];
        
        CompleteUserInfoViewController *completeVc = [[CompleteUserInfoViewController alloc]init];
        [self.navigationController pushViewController:completeVc animated:YES];
    }
}


#pragma mark -- getter
- (void)setupHeaderView{
    NSMutableArray *images = [NSMutableArray array];
    if (self.goodsModel.productIcon) {
        BannerModel *banner = [[BannerModel alloc]init];
        banner.bannerIcon = self.goodsModel.productIcon;
        [images addObject:banner];
    }
    HomeHeaderView *header = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) bannerType:BannerTypeProduct];
    [header setDataSources:images];
    self.tableView.tableHeaderView = header;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
//        _tableView.estimatedRowHeight   = 50;
//        _tableView.estimatedSectionHeaderHeight = 80;
        
    }
    return _tableView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.inputView = self.qualityView;

    }
    return _textField;
}

- (QualityView *)qualityView{
    if (!_qualityView) {
        _qualityView = [[QualityView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 256)];
        
    }
    return _qualityView;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverView)];
        [_coverView addGestureRecognizer:tap];
//        _coverView.hidden = YES;
    }
    return _coverView;
}



#pragma mark -- tableViewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *content   = [self.dataSource objectAtIndex:indexPath.row];
    GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setContentDic:content];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *content   = [self.dataSource objectAtIndex:indexPath.row];
    [self.reuseCell setContentDic:content];
    CGSize cellSize = [self.reuseCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (cellSize.height < 40) {
        return 40;
    }
    return cellSize.height + 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20)];
    titleLabel.text = self.goodsModel.name;
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 20, 20)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsModel.price];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = XGFONT(20);
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 10)];
    backView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.35];
    
    UIView *header = [[UIView alloc]init];
    [header addSubview:titleLabel];
    [header addSubview:priceLabel];
    [header addSubview:backView];
    
    return header;
    
}

#pragma mark -- clickedAction

- (void)collectGoods{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.goodsModel.productId forKey:@"productId"];
    [HomeHttpManager collectGoodsWithParams:param success:^(CommonModelResult *responseObj) {
        self.bottomBar.collectBtn.selected = !self.bottomBar.collectBtn.selected;
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

- (void)addShopCart{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.goodsModel.productId forKey:@"productId"];
    [HomeHttpManager addShopCartWithParams:param success:^(CommonModelResult *responseObj) {
        XGLog(@"%@", responseObj);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bottomBar.dotLabel.hidden = NO;
            [HUDUtils showAlert:@"添加成功"];
 
        });

    } failure:^(id responseObj, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDUtils showError:@"添加失败"];
            
        });
    }];
}

- (void)shareAction:(UIBarButtonItem *)item{
    
    UIImage *image = [UIImage imageNamed:@"share_icon"];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"大不同, 世界因你不同!"
                                     images:image  // 应用的的图片
                                        url:[NSURL URLWithString:@""]                 // 应用的网址
                                      title:@"大不同"
                                       type:SSDKContentTypeAuto];
    // 2.分享(可以弹出我们的分享菜单和编辑界面)
    [ShareSDK showShareActionSheet:nil
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateSuccess:
                           [HUDUtils showAlert:@"分享成功"];
                           break;
                       case SSDKResponseStateFail:
                           //                               [HUDUtils showErrorAlert:@"分享失败"];
                           XGLog(@"错误:error%@ 错误:content%@  错误:userdata%@  ",error,contentEntity , userData );
                           break;
                       default:
                           break;
                   }
               }];
    

}


- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapCoverView{
    [self.textField resignFirstResponder];
    [self.coverView removeFromSuperview];
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
