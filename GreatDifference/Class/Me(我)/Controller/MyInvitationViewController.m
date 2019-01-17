//
//  MyInvitationViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MyInvitationViewController.h"
#import "InvitationView.h"
#import "UIUtils.h"
#import "InviteTopView.h"
#import "InviteCollectionViewCell.h"
#import "PersonalHttpManager.h"
#import "InvitationModelResult.h"
#import "MyInvitatedListViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface MyInvitationViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView      *collectionView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) InviteTopView         *topView;
@property (nonatomic, strong) UILabel               *titleLabel;
@property (nonatomic, copy) NSString                *shareUrl;

@end

@implementation MyInvitationViewController
static NSString *cellIdentifier = @"reuseCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = nil;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 25, 25)];
    [backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.bgImageView];
    CGFloat height = 523;
    if (IS_IPHONE_6SPlus) {
        height = height * 1.1;
    }else if (IS_IPHONE_5){
        height = height * 0.853;
    }
    InviteTopView *topView = [[InviteTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    self.topView = topView;
    [self.view addSubview:topView];
    topView.inviteBlock = ^(){
        
        UIImage *image = [UIImage imageNamed:@"share_icon"];
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"大不同, 世界因你不同!"
                                         images:image  // 应用的的图片
                                            url:[NSURL URLWithString:self.shareUrl]                 // 应用的网址
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
        
    };
    
    [self.view addSubview:backBtn];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, height - 40, SCREEN_WIDTH - 20, 20)];
    titleLabel.text = @"我共邀请8人";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, height - 40, 60, 20)];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickedMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = XGFONT(15);
    [self.view addSubview:btn];
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:self.collectionView];
    
    [self fetchInvitationData];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)fetchInvitationData{
    
    [PersonalHttpManager getInvitationWithParams:nil success:^(InvitationModelResult *responseObj) {
        InvitationModel *invitation = responseObj.data;
        self.topView.invitationModel = invitation;
        self.dataSource = [invitation.invicateUsers mutableCopy];
        self.titleLabel.text = [NSString stringWithFormat:@"我共邀请了%@人", invitation.invicateCount];
        self.shareUrl = invitation.shareUrl;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}

#pragma mark -- getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/4, (SCREEN_WIDTH - 50)/3);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, (SCREEN_WIDTH - 50)/3) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[InviteCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];

    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InvitateUsersModel *model = self.dataSource[indexPath.row];
    InviteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.invitateModel = model;
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 50)/4, (SCREEN_WIDTH - 50)/3);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
}

- (void)backAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickedMoreBtn:(UIButton *)btn{
    MyInvitatedListViewController *invitaListVc = [[MyInvitatedListViewController alloc]init];
    [self.navigationController pushViewController:invitaListVc animated:YES];
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
