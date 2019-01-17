//
//  QuestionViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/20.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "H5WebViewController.h"

@interface H5WebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView       *webView;
@end

@implementation H5WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HUDUtils showLoading:@"正在加载"];

    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"courseId": @"1868036"} options:NSJSONWritingPrettyPrinted error:nil];
    //    request.HTTPBody = data;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    self.webView = webView;
    // Do any additional setup after loading the view.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [HUDUtils hideHud];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [HUDUtils showAlert:@"加载失败"];
    
}

- (void)dealloc{
    self.webView.delegate = nil;
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
