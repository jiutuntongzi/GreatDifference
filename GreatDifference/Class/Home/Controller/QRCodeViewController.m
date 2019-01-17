//
//  QRCodeViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/2.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "QRCodeViewController.h"
#import "ImageUtils.h"
@interface QRCodeViewController ()
@property (nonatomic, strong) UIImageView     *imgView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.imgView    = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    
    [self.view addSubview:self.imgView];
    
//    [self productQRCode];
    [ImageUtils loadImageWithLastComponentUrl:self.qrCodeUrl imageView:self.imgView placeHolder:nil];
}

- (void)productQRCode{
    CIFilter *filter    = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    // 将字符串转换成NSData
    NSData *data    = [@"www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVO设置滤镜inputMessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    // 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    //将CIImage转换成UIImage, 并放大显示
    _imgView.image = [self createNonInterpolatedUIImageFromCIImage:outputImage withSize:100];
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    
    _imgView.layer.shadowOffset = CGSizeMake(0, 0.5);
    _imgView.layer.shadowRadius = 1;
    _imgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _imgView.layer.shadowOpacity = 0.3;
}

- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withSize:(CGFloat )size{
    CGRect extent   = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width    = CGRectGetWidth(extent)*scale;
    size_t height   = CGRectGetHeight((extent))*scale;
    
    CGColorSpaceRef cs  = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context  = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
    
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
