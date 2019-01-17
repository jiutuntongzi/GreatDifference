//
//  CompleteUserInfoViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "CompleteUserInfoViewController.h"
#import "IdentifyManagerCell.h"
#import "SignInCollectionFooterView.h"
#import "IdentifyManagerHalfPicCell.h"
#import "UserInfo.h"
#import "IDIdentifyModel.h"
#import "IDIdentifySectionHeaderView.h"
#import "CompleteInfoCell.h"
#import "BindCardViewController.h"
#import "PersonalHttpManager.h"
#import "IDIdentifyModelResult.h"
#import <AVFoundation/AVFoundation.h>
#import "StringUtils.h"

@interface CompleteUserInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) UIButton              *currentBtn;
@property (nonatomic, strong) NSMutableDictionary      *paramDic;
@end

@implementation CompleteUserInfoViewController
static NSString *cellIdentifier     = @"completeCell";
static NSString *halfPicIdentifier  = @"halfPicCell";
static NSString *headerIdentifier   = @"headerIdentifier";

#pragma mark -- initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self createDataWithModel:nil];
    [self.tableView reloadData];
    [self.tableView registerClass:[IDIdentifySectionHeaderView class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    [self setupFooterView];
    
    [PersonalHttpManager getUserIdIdentifyWithParams:nil success:^(IDIdentifyModelResult *responseObj) {
        [self createDataWithModel:responseObj.data];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self setupFooterView];
            
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

#pragma mark -- getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
        _tableView.estimatedSectionHeaderHeight = 40;
    }
    return _tableView;
}

- (void)setupFooterView{
    SignInCollectionFooterView *signInFooterView = [[SignInCollectionFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135) footerType:@"IdentifierManager"];
    self.tableView.tableFooterView = signInFooterView;
    signInFooterView.title  = @"为什么要添加身份证信息?";
    signInFooterView.detail =  @"提现需要身份证信息验证";
    signInFooterView.signInBlock = ^(){
//        CompleteInfoCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        
//        CompleteInfoCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//        

         NSDictionary *realNameDic   = self.dataSource[0][0];
        NSDictionary  *idCardDic     = self.dataSource[0][1];

        NSString *idCard     = idCardDic[@"detail"];
        NSString *realName   = realNameDic[@"detail"];

        if ([StringUtils isEmpty:realName] ) {
            [HUDUtils showAlert:@"请输入您的真实姓名"];
            
            return ;
        }
        if ([StringUtils isEmpty:idCard] ) {
            [HUDUtils showAlert:@"输入你的身份证号码"];
            
            return ;
        }
        
        [HUDUtils showLoading:@"正在保存"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:realName forKey:@"realName"];
        [params setValue:idCard forKey:@"idCard"];
        
        [PersonalHttpManager modityUserIdIdentifyWithParams:params success:^(CommonModelResult *responseObj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:@"保存成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotification_completeUseInfo" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(id responseObj, NSError *error) {
            NSString *message = [responseObj objectForKey:@"message"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showError:message];
            });
        }];

    };
}

- (void)createDataWithModel:(IDIdentifyModel *)model
{
    _dataSource = [NSMutableArray array];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    
    [dic1 setValue:@"输入你的真实姓名" forKey:@"placeHolder"];
    [dic1 setValue:model.realName forKey:@"detail"];
    [dic1 setValue:@"1" forKey:@"cellType"];
    [dic1 setValue:@"填写身份信息" forKey:@"sectionTitle"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"输入你的身份证号码" forKey:@"placeHolder"];
    [dic2 setValue:model.idCard forKey:@"detail"];
    [dic2 setValue:@"1" forKey:@"cellType"];
    
    NSMutableArray *tempArray1 = [NSMutableArray array];
    [tempArray1 addObject:dic1];
    [tempArray1 addObject:dic2];
    
    NSMutableDictionary *dicAdd = [NSMutableDictionary dictionary];

    [dicAdd setValue:@"绑定银行卡" forKey:@"title"];
    [dicAdd setValue:@"Mywallet_card_icon" forKey:@"icon"];
    [dicAdd setValue:@"0" forKey:@"cellType"];
    [dicAdd setValue:@"提现方式" forKey:@"sectionTitle"];
    
    NSMutableDictionary *dicAdd1 = [NSMutableDictionary dictionary];
    [dicAdd1 setValue:@"绑定支付宝" forKey:@"title"];
    [dicAdd1 setValue:@"Mywallet_alipay_icon" forKey:@"icon"];
    [dicAdd1 setValue:@"0" forKey:@"cellType"];
    
    NSMutableArray *tempAddArray = [NSMutableArray array];
    [tempAddArray addObject:dicAdd];
//    [tempAddArray addObject:dicAdd1];
    
    
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setValue:@"身份证正反面照" forKey:@"title"];
    [dic3 setValue:@"" forKey:@"detail"];
    [dic3 setValue:model.idCardFrontImgUrl forKey:@"frontPic"];
    [dic3 setValue:model.idCardReverseImgUrl forKey:@"reversePic"];
    
    [dic3 setValue:@"2" forKey:@"cellType"];
    [dic3 setValue:@"上传身份证正反面照片" forKey:@"sectionTitle"];

    
    
    NSMutableArray *tempArray2 = [NSMutableArray array];
    [tempArray2 addObject:dic3];
    
    NSMutableArray *tempArray3 = [NSMutableArray array];
    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setValue:@"手机号" forKey:@"title"];
    [dic4 setValue:@"" forKey:@"detail"];
    [dic4 setValue:model.bodyIdCardImgUrl forKey:@"halfPic"];
    
    [dic4 setValue:@"3" forKey:@"cellType"];
    [dic4 setValue:@"上传手持身份证半身照" forKey:@"sectionTitle"];

    [tempArray3 addObject:dic4];
    
    [_dataSource addObject:tempArray1];
    [_dataSource addObject:tempAddArray];
    [_dataSource addObject:tempArray2];
    [_dataSource addObject:tempArray3];
    
    
}

#pragma mark -- tableDataSource && delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray = self.dataSource[section];
    return tempArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(self);
    NSDictionary *content   = [self.dataSource objectAtIndex:indexPath.section][indexPath.row];
    CompleteCellType cellType   = [[content objectForKey:@"cellType"] integerValue];
    if (cellType == CompleteCellTypeNormal || cellType == CompleteCellTypeTextField) {
        CompleteInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[CompleteInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:cellType];
        }
        [cell setContentDict:content];
        
        cell.accessoryType = UITableViewCellAccessoryNone;

        if (cell == CompleteCellTypeNormal) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    if (indexPath.section == 2) {
        IdentifyManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[IdentifyManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            //        cell
        }
        cell.addPictureBlock = ^(UIButton *btn){
            weakself.currentBtn = btn;
            [weakself didClickedUploadPicBtn];
        };
        [cell setContent:content];
        return cell;
    }
    
    IdentifyManagerHalfPicCell *cell = [tableView dequeueReusableCellWithIdentifier:halfPicIdentifier];
    if (cell == nil) {
        cell = [[IdentifyManagerHalfPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:halfPicIdentifier];
        //        cell
    }
    
    cell.addPictureBlock = ^(UIButton *btn){
        weakself.currentBtn = btn;
        [weakself didClickedUploadPicBtn];
    };
    [cell setContent:content];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<2) {
        return 40;
    }
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IDIdentifySectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    NSDictionary *dic = [self.dataSource[section] firstObject];
    header.title    = dic[@"sectionTitle"];
    return header;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        BindCardViewController *bindCardVc = [[BindCardViewController alloc]init];
        [self.navigationController pushViewController:bindCardVc animated:YES];
        
    }
}

- (void)didClickedUploadPicBtn{
    WS(self);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        BOOL isAvaliable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (!isAvaliable) {
            XGLog(@"当前设备不支持拍照功能");
            
            return ;
        }
        picker.delegate = weakself;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusDenied){
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未获得授权使用摄像头" message:@"请在iOS“设置”-“隐私”-“相机”中打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BOOL isAvaliable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
        if (!isAvaliable) {
            XGLog(@"当前设备不支持此功能");
            
            return ;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [alertController addAction:cancelAction];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image;
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        image = info[UIImagePickerControllerEditedImage];
        
    }else{
        image = info[UIImagePickerControllerOriginalImage];
    } //    self.avatarImage = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadPic:image];
    }];
}

- (void)uploadPic:(UIImage *)image{
    [HUDUtils showLoading:@"正在上传"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSNumber numberWithInteger:self.currentBtn.tag] forKey:@"iconType"];
    [params setValue:@"png" forKey:@"fixType"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *encodeResult = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [params setObject:encodeResult forKey:@"content"];
    
    [UserInfo uploadHeadImageWithUrl:UPLOAD_IMAGE_URL
                              params:params image:image completionHandle:^(id response, NSError *error) {
                                  NSString *resultCode = [[response objectForKey:@"state"] stringValue];
                                  [HUDUtils hideHud];
                                  if ([resultCode isEqualToString:@"1"]) {
                                      [self.currentBtn setImage:image forState:UIControlStateNormal];
                                  }else{
                                      NSString *message = [response objectForKey:@"message"];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [HUDUtils hideHud];
                                          [HUDUtils showError:message];
                                      });
                                  }
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
