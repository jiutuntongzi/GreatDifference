
//
//  BusinessLicenseViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/12/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "BusinessLicenseViewController.h"
#import "ImageUtils.h"

@interface BusinessLicenseViewController ()
@property (nonatomic, strong) UIImageView         *imageView;

@end

@implementation BusinessLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    [ImageUtils loadImageWithLastComponentUrl:self.url imageView:self.imageView placeHolder:nil];
    // Do any additional setup after loading the view.
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, SCREEN_WIDTH - 40)];
        _imageView.centerY = self.view.centerY;
        
    }
    return _imageView;
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
