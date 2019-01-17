//
//  ScanViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import "TLTiltHighlightView.h"
#import "HomeHttpManager.h"
#import "GoodsDetailViewController.h"
#import "GoodsModelResult.h"
#import "StoreModelResult.h"
#import "StoreViewController.h"

#define kBoxWidth           SCREEN_WIDTH * 0.64
#define kLeftMargin         (SCREEN_WIDTH - kBoxWidth)*0.5

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVCaptureDevice                 * captureDevice;
@property (strong,nonatomic)AVCaptureDeviceInput            * captureInput;
@property (strong,nonatomic)AVCaptureMetadataOutput         * captureOutput;
@property (strong,nonatomic)AVCaptureSession                * captureSession;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer      * preview;
//@property (nonatomic, strong) TLTiltHighlightView           *lineView;
@property (nonatomic, strong) UIImageView                   *scanLine;
@property (nonatomic, strong) UIImageView                   *scanBox;


@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"二维码/条码";
    
    self.view.backgroundColor = [UIColor blackColor];
    [self setSubviews];
    [self setScan];
    // Do any additional setup after loading the view.
}

- (void)setSubviews{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35f];
    CGFloat height  = SCREEN_HEIGHT * 0.25f;
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35f];
//    CGFloat leftWidth  = SCREEN_WIDTH * 0.18f;
    leftView.frame = CGRectMake(0, height, kLeftMargin, SCREEN_HEIGHT - height);
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35f];
    rightView.frame = CGRectMake(kBoxWidth + kLeftMargin, height, kLeftMargin, SCREEN_HEIGHT - height);
    
    UIView *downView = [[UIView alloc]init];
    downView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35f];
    downView.frame = CGRectMake(kLeftMargin, height + kBoxWidth, kBoxWidth, SCREEN_HEIGHT - height - kBoxWidth);
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(downView.frame) + 10, SCREEN_WIDTH, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    NSString *remindText = @"请将商品条码放入取景框中即可自动扫描";
    if (self.fromHome) {
        remindText = @"请将店铺二维码放入取景框中即可自动扫描";
    }
    titleLabel.text = remindText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = XGFONT(12);
    
    
    
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:downView];
    [self.view addSubview:titleLabel];
    [self.view addSubview:self.scanLine];
    
    self.scanBox.frame = CGRectMake(kLeftMargin, height, kBoxWidth, kBoxWidth);
    [self.view addSubview:self.scanBox];

}

//- (TLTiltHighlightView *)lineView{
//    if (!_lineView) {
//        _lineView = [[TLTiltHighlightView alloc]init];
//        _lineView.highlightColor = THEMECOLOR;
////        _lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
//
//    }
//    return _lineView;
//}

- (UIImageView *)scanLine{
    if (!_scanLine) {
        _scanLine = [[UIImageView alloc]init];
        _scanLine.image = [UIImage imageNamed:@"scanLine_icon"];
    }
    return _scanLine;
}

- (UIImageView *)scanBox{
    if (!_scanBox) {
        _scanBox = [[UIImageView alloc]init];
        _scanBox.image = [UIImage imageNamed:@"scanBox"];
    
    }
    return _scanBox;
}

- (void)moveScanLine{

    self.scanLine.frame = CGRectMake(kLeftMargin, SCREEN_HEIGHT * 0.25f, kBoxWidth, 6);

    [UIView animateWithDuration:3.0 delay:0.5 options:UIViewAnimationOptionRepeat animations:^{
        self.scanLine.frame = CGRectMake(kLeftMargin, SCREEN_HEIGHT * 0.25f + kBoxWidth-7, kBoxWidth, 6);
    } completion:^(BOOL finished) {
    }];
}

- (void)setScan{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusDenied){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未获得授权使用摄像头" message:@"请在iOS“设置”-“隐私”-“相机”中打开" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    
    // Output
    _captureOutput = [[AVCaptureMetadataOutput alloc]init];
    [_captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    

    // Session
    _captureSession = [[AVCaptureSession alloc]init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_captureSession canAddInput:self.captureInput])
    {
        [_captureSession addInput:self.captureInput];
    }
    
//    BOOL iscan = [_captureSession canAddOutput:self.captureOutput];
    
    if ([_captureSession canAddOutput:self.captureOutput])
    {
        [_captureSession addOutput:self.captureOutput];
    }
    
    CGRect rect = [self getScanCrop:CGRectMake(0.18 * SCREEN_WIDTH, 0.25 * SCREEN_HEIGHT, 0.64 * SCREEN_WIDTH, SCREEN_WIDTH * 0.64) readerViewBounds:self.view.bounds];
    
    _captureOutput.rectOfInterest = rect;
    
//    NSArray *availab =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    NSArray *suppportArray  = self.captureOutput.availableMetadataObjectTypes;
//    if ([suppportArray containsObject:availab]) {
        self.captureOutput.metadataObjectTypes =suppportArray;
//    }

    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    if (!suppportArray.count) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备不支持二维码扫描" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self.captureSession startRunning];
    [self performSelector:@selector(moveScanLine) withObject:nil afterDelay:0.5];

    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [self.captureSession stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        [self getGoodsDetailWithSerialNo:stringValue];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringValue]];
    }
}


-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetMinY(rect))/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}

- (void)getGoodsDetailWithSerialNo:(NSString *)serialno{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    if ([serialno hasSuffix:@"_#_"]) {
        serialno = [serialno stringByReplacingOccurrencesOfString:@"_#_" withString:@""];

        StoreViewController *storeVc = [[StoreViewController alloc]init];
        storeVc.shopId = serialno;
        [self.navigationController pushViewController:storeVc animated:YES];
    }else{
        [param setValue:serialno forKey:@"serialno"];
        [param setValue:self.shopId forKey:@"shopId"];
        //    if (self.shopId) {
        [HomeHttpManager scanQrcodeGetDetailWithParams:param success:^(GoodsModelResult *responseObj) {
            GoodsDetailViewController *goodsDetailVc = [[GoodsDetailViewController alloc]init];
            GoodsModel *model = responseObj.data;
            goodsDetailVc.productId = model.productId;
            [self.navigationController pushViewController:goodsDetailVc animated:YES];
            
        } failure:^(id responseObj, NSError *error) {
            NSString *message = [responseObj objectForKey:@"message"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils showAlert:message];
            });
        }];
    }

//    }else{
//        
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [param setValue:serialno forKey:@"shopId"];
//        
//        [HomeHttpManager getStoreDetailWithParams:param success:^(StoreModelResult *responseObj) {
////            self.storeModel = responseObj.data;
////            [self createDataWithModel:responseObj.data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                StoreDetailViewController *storeDetailVc = [[StoreDetailViewController alloc]init];
//                storeDetailVc.storeModel    = responseObj.data;
//                storeDetailVc.fromScan = YES;
//                [self.navigationController pushViewController:storeDetailVc animated:YES];
////                [self.tableView reloadData];
//            });
//        } failure:^(id responseObj, NSError *error) {
//            NSString *message = [responseObj objectForKey:@"message"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [HUDUtils showAlert:message];
//            });
//        }];
//    }

}

- (void)dealloc{
    [self.captureSession stopRunning];

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
