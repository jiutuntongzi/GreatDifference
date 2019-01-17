//
//  IdentifyManagerViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "IdentifyManagerViewController.h"
#import "PersonalInfoCell.h"
#import "IdentifyManagerCell.h"
#import "SignInCollectionFooterView.h"
#import "IdentifyManagerHalfPicCell.h"
#import "UserInfo.h"
#import "PersonalHttpManager.h"
#import "IDIdentifyModelResult.h"
#import "PersonInfoDetailViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface IdentifyManagerViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) UIButton              *currentBtn;
@property (nonatomic, strong) NSMutableDictionary  *paramDic;
@end

@implementation IdentifyManagerViewController
static NSString *cellIdentifier     = @"reuseCell";
static NSString *halfPicIdentifier  = @"halfPicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.paramDic = [NSMutableDictionary dictionary];
    [PersonalHttpManager getUserIdIdentifyWithParams:nil success:^(IDIdentifyModelResult *responseObj) {
        [self createDataWithModel:responseObj.data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupFooterView];

            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
    }
    return _tableView;
}

- (void)createDataWithModel:(IDIdentifyModel *)model
{
        _dataSource = [NSMutableArray array];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        
        [dic1 setValue:@"姓名" forKey:@"title"];
        [dic1 setValue:model.realName forKey:@"detail"];
        [dic1 setValue:@"0" forKey:@"cellType"];
        [self.paramDic setValue:model.realName forKey:@"realName"];
    
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setValue:@"身份证号" forKey:@"title"];
        [dic2 setValue:model.idCard forKey:@"detail"];
        [dic2 setValue:@"0" forKey:@"cellType"];
        [self.paramDic setValue:model.idCard forKey:@"idCard"];

        NSMutableArray *tempArray1 = [NSMutableArray array];
        [tempArray1 addObject:dic1];
        [tempArray1 addObject:dic2];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setValue:@"身份证正反面照" forKey:@"title"];
        [dic3 setValue:@"" forKey:@"detail"];
        [dic3 setValue:model.idCardFrontImgUrl forKey:@"frontPic"];
        [dic3 setValue:model.idCardReverseImgUrl forKey:@"reversePic"];

        [dic3 setValue:@"1" forKey:@"cellType"];
        

        
        NSMutableArray *tempArray2 = [NSMutableArray array];
        [tempArray2 addObject:dic3];
        
        NSMutableArray *tempArray3 = [NSMutableArray array];
        
        NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
        [dic4 setValue:@"手机号" forKey:@"title"];
        [dic4 setValue:@"" forKey:@"detail"];
        [dic4 setValue:model.bodyIdCardImgUrl forKey:@"halfPic"];

        [dic4 setValue:@"2" forKey:@"cellType"];
        
        [tempArray3 addObject:dic4];
        
        [_dataSource addObject:tempArray1];
        [_dataSource addObject:tempArray2];
        [_dataSource addObject:tempArray3];

}

- (void)setupFooterView{
    SignInCollectionFooterView *signInFooterView = [[SignInCollectionFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135) footerType:@"IdentifierManager"];
    self.tableView.tableFooterView = signInFooterView;
    signInFooterView.title = nil;
    signInFooterView.detail = nil;
    
    signInFooterView.signInBlock = ^(){
        [HUDUtils showLoading:@"正在保存"];
        [PersonalHttpManager modityUserIdIdentifyWithParams:self.paramDic success:^(CommonModelResult *responseObj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils hideHud];
                [HUDUtils showAlert:@"保存成功"];
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
    CellType cellType   = [[content objectForKey:@"cellType"] integerValue];
    if (cellType == CellTypeNormal) {
        PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PersonalInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:cellType];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setContent:content];
        return cell;
    }
    
    if (cellType == 1) {
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
    if (indexPath.section<1) {
        return 40;
    }
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        WS(self);
        PersonalInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        PersonInfoDetailViewController *detailVc = [[PersonInfoDetailViewController alloc]initWithType:InputTypeTextField andText:cell.detailLabel.text];
        detailVc.saveBlock = ^(NSString *text){
            
            PersonalInfoCell *cell = [weakself.tableView cellForRowAtIndexPath:indexPath];
            cell.detailLabel.text = text;
            if (indexPath.row == 0) {
                [self.paramDic setValue:text forKey:@"realName"];
            }else{
                [self.paramDic setValue:text forKey:@"idCard"];
            }
            NSDictionary *dict = self.dataSource[indexPath.section][indexPath.row];
            [dict setValue:text forKey:@"detail"];

        };
        [self.navigationController pushViewController:detailVc animated:YES];
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
