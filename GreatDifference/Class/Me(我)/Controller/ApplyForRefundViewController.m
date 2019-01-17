//
//  RefundViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ApplyForRefundViewController.h"
#import "RefundView.h"
#import "RefundViewCell.h"
#import "AddPictureCollectionViewCell.h"
#import "UserInfo.h"
#import "XDTextView.h"
#import "PersonalHttpManager.h"
#import "ExpressListResult.h"
#import <AVFoundation/AVFoundation.h>


@interface ApplyForRefundViewController ()<UITableViewDataSource, UITableViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView             *tableView;
@property (nonatomic, strong) NSMutableArray          *dataSource;
@property (nonatomic, strong) UICollectionView        *collectionView;
@property (nonatomic, strong) UIButton                *currentBtn;
@property (nonatomic, strong) NSArray                 *pickerDataSource;
@property (nonatomic, strong) NSArray                 *reasonDataSource;
@property (nonatomic, strong) NSMutableDictionary     *params;
@property (nonatomic, strong) NSArray          *picArray;
@end

@implementation ApplyForRefundViewController
static NSString *cellIdentifier = @"reuseCell";
static NSString *cellCollection = @"cellCollection";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self createDataSource];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellCollection];
    [self.tableView reloadData];
    [self setupFooterView];
       // Do any additional setup after loading the view.
    [PersonalHttpManager getExpressListWithParams:nil success:^(ExpressListResult *responseObj) {
        self.pickerDataSource = responseObj.data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(id responseObj, NSError *error) {
        
    }];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (NSArray *)reasonDataSource{
    if (!_reasonDataSource) {
        _reasonDataSource = @[@"东西损坏", @"过了保质期", @"买错了", @"不想买了", @"其他"];
    }
    return _reasonDataSource;
}

- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (NSArray *)picArray{
    if (!_picArray) {
        _picArray = @[@"商品问题图片", @"快递面单图片", @"包裹图片"];
    }
    return _picArray;
}

- (void)createDataSource{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:@"物流公司:" forKey:@"title"];
    [dic1 setValue:@"韵达快递" forKey:@"detail"];
    [dic1 setValue:@"1" forKey:@"cellType"];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setValue:@"运单号:" forKey:@"title"];
    [dic2 setValue:@"20161218153615648" forKey:@"detail"];
    [dic2 setValue:@"0" forKey:@"cellType"];

    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setValue:@"退款原因:" forKey:@"title"];
    [dic3 setValue:@"" forKey:@"detail"];
    [dic3 setValue:@"1" forKey:@"cellType"];

    
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setValue:@"上传凭证:" forKey:@"title"];
    [dic4 setValue:@"" forKey:@"detail"];
    [dic4 setValue:@"2" forKey:@"cellType"];
    
    
    [self.dataSource addObject:dic1];
    [self.dataSource addObject:dic2];

    [self.dataSource addObject:dic3];
    [self.dataSource addObject:dic4];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 45)/2, (SCREEN_WIDTH - 45)/2*3/4);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:flowLayout];
        _collectionView.dataSource  = self;
        _collectionView.delegate    = self;
        _collectionView.bounces = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[AddPictureCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        //        _collectionView sets
    }
    return _collectionView;
}

- (void)setupFooterView{
//    XDTextView *textView = [[XDTextView alloc]initWithFrame:CGRectMake(-1, 0, SCREEN_WIDTH+2, 90)];
//    textView.edgeInsets = UIEdgeInsetsMake(10, 10, 0, 10);
//    textView.placeholder = @"退货说明";
//    textView.layer.borderWidth = 0.5;
//    textView.layer.borderColor = LineColor.CGColor;
//    self.tableView.tableHeaderView = textView;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 60, SCREEN_WIDTH, 60)];
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 40)];
    submitBtn.backgroundColor = THEMECOLOR;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerView addSubview:submitBtn];
    [self.view addSubview:footerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    CellType cellType = [dic[@"cellType"] integerValue];
    if (cellType == CellTypePicker) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellCollection];
//        cell.backgroundColor = [UIColor whiteColor];
        [cell addSubview:self.collectionView];
        return cell;

    }
    RefundViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RefundViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier cellType:cellType];
    }
    if (cellType == CellTypeAvatar) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell setContentDict:dic];
    WS(self);
    cell.finishBlock = ^(NSString *detail){
        if (indexPath.row == 0) {
            [weakself.params setValue:detail forKey:@"processCompanyId"];
        }else if(indexPath.row == 2){
            [weakself.params setValue:detail forKey:@"returnReason"];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return SCREEN_WIDTH + 10;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    NSString *title = dic[@"title"];
    if ([title isEqualToString:@"运单号:"]) {
        return;
    }
    RefundViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([title isEqualToString:@"物流公司:"]) {
        [cell setDataSource:self.pickerDataSource];
    }else{
        [cell setDataSource:self.reasonDataSource];

    }
    [cell.tapTextField becomeFirstResponder];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *title = self.picArray[indexPath.row];
    cell.titleLabel.text = title;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddPictureCollectionViewCell *cell = (AddPictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.currentBtn = cell.addPicBtn;
    if (indexPath.row == 0) {
        self.currentBtn.tag = 11;  //商品问题图片
    }else if (indexPath.row == 1){
        self.currentBtn.tag = 13;   // 退货快递面单图片
    }else{
        self.currentBtn.tag = 12; // 货快递包裹图片
    }
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
    }     //    self.avatarImage = image;
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
          NSString *imgId = [[response objectForKey:@"data"]objectForKey:@"imgUrl"];
          
          if (self.currentBtn.tag == 11) {
              [self.params setValue:imgId forKey:@"problemImg"];
          }
          else if (self.currentBtn.tag == 12) {
              [self.params setValue:imgId forKey:@"expressPackageImg"];

          }
          else if (self.currentBtn.tag == 13) {
              [self.params setValue:imgId forKey:@"expressNoImg"];

          }
      }else{
          NSString *message = [response objectForKey:@"message"];
          dispatch_async(dispatch_get_main_queue(), ^{
              [HUDUtils hideHud];
              [HUDUtils showError:message];
          });
      }
  }];
    
    
}

- (void)submitAction:(UIButton *)btn{
    [self.params setValue:self.Order.orderId forKey:@"orderId"];
    RefundViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *orderNo = [cell getCellDetail];
    if (!orderNo) {
        [HUDUtils showAlert:@"请填写快递单号"];
        return;
    }
    [self.params setValue:orderNo forKey:@"processNo"];
    
    NSString *str = [self.params objectForKey:@"processCompanyId"];
    if (!str) {
        [HUDUtils showAlert:@"请填写物流公司"];
        return;
    }
    
//    NSString *str1 = [self.params objectForKey:@"processNo"];
//    if (!str1) {
//        [HUDUtils showAlert:@"请填写快递单号"];
//        return;
//    }
    
    NSString *str2 = [self.params objectForKey:@"returnReason"];
    if (!str2) {
        [HUDUtils showAlert:@"请填写退货原因"];
        return;
    }
    
    NSString *str3 = [self.params objectForKey:@"problemImg"];
    if (!str3) {
        [HUDUtils showAlert:@"请上传商品问题图片"];
        return;
    }
    
    NSString *str4 = [self.params objectForKey:@"expressNoImg"];
    if (!str4) {
        [HUDUtils showAlert:@"请上传快递单图片"];
        return;
    }
    
    NSString *str5 = [self.params objectForKey:@"expressPackageImg"];
    if (!str5) {
        [HUDUtils showAlert:@"请上传快递包裹图片"];
        return;
    }
    
    if (self.selectArrays.count == self.Order.products.count && self.selectArrays.count != 0) {
        NSMutableArray *tempArray = [NSMutableArray array];

        [self.selectArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GoodsModel *goods = (GoodsModel *)obj;
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:goods.productId forKey:@"orderProductId"];
            [tempArray addObject:dict];
        }];
        
        [self.params setValue:tempArray forKey:@"products"];
    }
    
    [HUDUtils showLoading:@"正在提交申请"];
    [PersonalHttpManager refundOrderWithParams:self.params success:^(CommonModelResult *responseObj) {
        [HUDUtils hideHud];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_HAD_RECEIVE object:nil];

            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_REFUND_ORDERS object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
            [self.navigationController popViewControllerAnimated:YES];

        });
    } failure:^(id responseObj, NSError *error) {
        [HUDUtils hideHud];
        [HUDUtils showError:@"提交失败"];

    }];
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
