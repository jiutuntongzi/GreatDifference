//
//  MeViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 16/11/1.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MeViewController.h"
#import "SetViewController.h"
#import "MyOrderViewController.h"
#import "MessageListViewController.h"

#import "MeCollectionViewCell.h"
#import "MeHeaderView.h"
#import "CollectionHeaderView.h"
#import "MeSectionBlankView.h"

#import "MeTopCollectionViewCell.h"
//#import "UIUtils.h"
#import "AccountUtils.h"
#import "PersonalHttpManager.h"
#import "UnpayNumModelResult.h"

@interface MeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) MeHeaderView          *headerView;
@property (nonatomic, strong) NSMutableArray        *dataSource;


@end

@implementation MeViewController
static NSString *cellIdentifier     = @"reuseCell";
static NSString *topCellIdentifier  = @"topReuseCell";
static NSString *sectionHeader      = @"sectionHeader";
static NSString *sectionBlankHeader      = @"sectionBlankHeader";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = nil;
    
    [self setupHeaderView];

    [self.view addSubview:self.collectionView];
    
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 10, 40, 40)];
    setBtn.backgroundColor = THEMECOLOR;
    [setBtn addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    [setBtn setImage:[UIImage imageNamed:@"me_icon_set"] forState:UIControlStateNormal];
    [self.view addSubview:setBtn];
    
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 10, 40, 40)];
    [messageBtn setImage:[UIImage imageNamed:@"me_icon_mas"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:messageBtn];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserInfo) name:KNOTIFICATION_UPDATE_USERINFO object:nil];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [PersonalHttpManager getUnpayNumWithParams:nil success:^(UnpayNumModelResult *responseObj) {
        [self configureUnpayNum:responseObj.data];
    } failure:^(id responseObj, NSError *error) {
        
    }];
//    UIImage *image = [UIUtils navigationBarFromColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds   = YES;
}

- (void)configureUnpayNum:(UnpayNumModel *)model{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    MeTopCollectionViewCell *cell = (MeTopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    NSInteger unPayNumbers = [model.unpayOrderNum integerValue];
    if (unPayNumbers > 0) {
        cell.iconLabel.hidden = NO;
        cell.iconLabel.text = model.unpayOrderNum;
        if (unPayNumbers >99) {
            cell.iconLabel.text = @"99+";
        }
    }else{
        cell.iconLabel.hidden = YES;
 
    }
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:1 inSection:0];
    MeTopCollectionViewCell *cell1 = (MeTopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath1];
    NSInteger unReceiveNumbers = [model.unReceiveNum integerValue];
    if (unReceiveNumbers > 0) {
        cell1.iconLabel.hidden = NO;
        cell1.iconLabel.text = model.unReceiveNum;
        if (unReceiveNumbers >99) {
            cell1.iconLabel.text = @"99+";
        }
    }else{
        cell1.iconLabel.hidden = YES;
        
    }
    
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:2 inSection:0];

    MeTopCollectionViewCell *cell2 = (MeTopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath2];
    
    NSInteger unEvaluteNum = [model.unEvaluteOrderNum integerValue];
    if (unEvaluteNum > 0) {
        cell2.iconLabel.hidden = NO;
        cell2.iconLabel.text = model.unEvaluteOrderNum;
        if (unEvaluteNum >99) {
            cell2.iconLabel.text = @"99+";
        }
    }else{
        cell2.iconLabel.hidden = YES;
        
    }
    
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:3 inSection:0];
    
    MeTopCollectionViewCell *cell3 = (MeTopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath3];
    
    NSInteger cancelingNum = [model.cancelingOrderNum integerValue];
    if (cancelingNum > 0) {
        cell3.iconLabel.hidden = NO;
        cell3.iconLabel.text = model.cancelingOrderNum;
        if (cancelingNum >99) {
            cell3.iconLabel.text = @"99+";
        }
    }else{
        cell3.iconLabel.hidden = YES;
        
    }

//    NSDictionary *dic = self.dataSource[0][2];

//    [cell setContentDic:dic];

    
}

- (void)refreshUserInfo{
    
    UserInfo *user = [AccountUtils account];
    self.headerView.user = user;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 3)/4, (SCREEN_WIDTH - 3)/4);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.30];
        _collectionView.dataSource  = self;
        _collectionView.delegate    = self;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[MeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [_collectionView registerClass:[MeTopCollectionViewCell class] forCellWithReuseIdentifier:topCellIdentifier];
        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeader];
        [_collectionView registerClass:[MeSectionBlankView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionBlankHeader];

    }
    return _collectionView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:7];
        NSMutableDictionary *top1 = [NSMutableDictionary dictionary];
        [top1 setValue:@"待付款" forKey:@"title"];
        [top1 setValue:@"PersonInfoViewController" forKey:@"class"];
        [top1 setValue:@"me_wait_pay" forKey:@"icon"];

        NSMutableDictionary *top2 = [NSMutableDictionary dictionary];
        [top2 setValue:@"待收货" forKey:@"title"];
        [top2 setValue:@"PersonInfoViewController" forKey:@"class"];
        [top2 setValue:@"me_icon_che" forKey:@"icon"];
        
        NSMutableDictionary *top3 = [NSMutableDictionary dictionary];
        [top3 setValue:@"待评价" forKey:@"title"];
        [top3 setValue:@"PersonInfoViewController" forKey:@"class"];
        [top3 setValue:@"me_icon_finish" forKey:@"icon"];
        
        NSMutableDictionary *top4 = [NSMutableDictionary dictionary];
        [top4 setValue:@"退款/退货" forKey:@"title"];
        [top4 setValue:@"PersonInfoViewController" forKey:@"class"];
        [top4 setValue:@"me_icon_order" forKey:@"icon"];
        
        NSMutableArray *tempArray1 = [NSMutableArray array];
        [tempArray1 addObject:top1];
        [tempArray1 addObject:top2];
        [tempArray1 addObject:top3];
        [tempArray1 addObject:top4];
        
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setValue:@"基础信息" forKey:@"title"];
        [dic1 setValue:@"PersonInfoViewController" forKey:@"class"];
        [dic1 setValue:@"me_icon_idcard" forKey:@"icon"];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setValue:@"我的邀请函" forKey:@"title"];
        [dic2 setValue:@"MyInvitationViewController" forKey:@"class"];
        [dic2 setValue:@"me_icon_invite" forKey:@"icon"];

        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setValue:@"我的钱包" forKey:@"title"];
        [dic3 setValue:@"MyWalletViewController" forKey:@"class"];
        [dic3 setValue:@"me_icon_wallet" forKey:@"icon"];

        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setValue:@"每日签到" forKey:@"title"];
        [dic4 setValue:@"SignInViewController" forKey:@"class"];
        [dic4 setValue:@"me_icon_signin" forKey:@"icon"];

        NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
        [dic5 setValue:@"我的关注" forKey:@"title"];
        [dic5 setValue:@"MyAttentionViewController" forKey:@"class"];
        [dic5 setValue:@"me_icon_guanz" forKey:@"icon"];

        NSMutableDictionary *dic6 = [NSMutableDictionary dictionary];
        [dic6 setValue:@"收货地址" forKey:@"title"];
        [dic6 setValue:@"ShippingAddressViewController" forKey:@"class"];
        [dic6 setValue:@"me_icon_address" forKey:@"icon"];

        NSMutableDictionary *dic7 = [NSMutableDictionary dictionary];
        [dic7 setValue:@"联系客服" forKey:@"title"];
        [dic7 setValue:@"ContactServiceViewController" forKey:@"class"];
        [dic7 setValue:@"me_icon_kefu" forKey:@"icon"];

        NSMutableArray *tempArray2 = [NSMutableArray array];
        [tempArray2 addObject:dic1];
        [tempArray2 addObject:dic2];
        [tempArray2 addObject:dic3];
//        [tempArray2 addObject:dic4];
        [tempArray2 addObject:dic5];
        [tempArray2 addObject:dic6];
        [tempArray2 addObject:dic7];

        [_dataSource addObject:tempArray1];
        [_dataSource addObject:tempArray2];
    }
    return _dataSource;
}

- (void)setupHeaderView{
    MeHeaderView *header = [[MeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    UserInfo *user = [AccountUtils account];
    header.user = user;
    
    [self.view addSubview:header];
    self.headerView = header;
    
}

#pragma mark -- collectionViewDataSource  && Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *tempArray  = self.dataSource[section];
    return tempArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        
        MeTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topCellIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.contentDic = dic;
        return cell;
    }
    
    MeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.contentDic = dic;
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
    MeSectionBlankView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionBlankHeader forIndexPath:indexPath];
    
        return header;
    }
    CollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeader forIndexPath:indexPath];
    header.lookAllOrdersBlock = ^(){
        MyOrderViewController *MyOrderVc = [[MyOrderViewController alloc]init];
        [self.navigationController pushViewController:MyOrderVc animated:YES];
        MyOrderVc.navigationController.navigationBarHidden = NO;
    };
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((SCREEN_WIDTH - 3)/4, (SCREEN_WIDTH - 3)/4*0.75);
        
    }
    return CGSizeMake((SCREEN_WIDTH - 3)/4, (SCREEN_WIDTH - 3)/4);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return CGSizeMake(SCREEN_WIDTH, 20);

    }
    return CGSizeMake(SCREEN_WIDTH, 40);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MyOrderViewController *MyOrderVc = [[MyOrderViewController alloc]init];
        MyOrderVc.currentIndex = indexPath.row + 1;
        [self.navigationController pushViewController:MyOrderVc animated:YES];
        MyOrderVc.navigationController.navigationBarHidden = NO;
        return;
        
    }
    NSDictionary *dic = self.dataSource[indexPath.section][indexPath.row];
    NSString *className = dic[@"class"];
    Class class = NSClassFromString(className);
    if (class) {
//        if ([className isEqualToString:@"MyAttentionViewController"]) {
//            [self presentViewController:[class new] animated:YES completion:nil];
//            return;
//        }
        UIViewController *vc = [[class alloc]init];
        vc.title    = dic[@"title"];
        [self.navigationController pushViewController:vc animated:YES];
        if ([vc.title isEqualToString:@"联系客服"]) {
            
        }
        vc.navigationController.navigationBarHidden = NO;

    }
}

- (void)setAction:(UIButton *)btn{
    SetViewController *setVc = [[SetViewController alloc]init];
    
    [self.navigationController pushViewController:setVc animated:YES];
    setVc.navigationController.navigationBarHidden = NO;

}

- (void)messageAction:(UIButton *)btn{
    MessageListViewController *messageListVc = [[MessageListViewController alloc]init];

    [self.navigationController pushViewController:messageListVc animated:YES];
    messageListVc.navigationController.navigationBarHidden = NO;

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
