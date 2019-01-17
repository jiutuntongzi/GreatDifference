//
//  ShopEvaluationViewController.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/23.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShopEvaluationViewController.h"
#import "TggStarEvaluationView.h"
#import "XDTextView.h"
#import "ShopEvaluationView.h"
#import "EvaluateModel.h"
#import "PersonalHttpManager.h"
#import "HUDUtils.h"
#import "StringUtils.h"

@interface ShopEvaluationViewController ()
@property (strong ,nonatomic) TggStarEvaluationView *tggStarEvaView;
@property (nonatomic, strong) XDTextView      *textView;
@end

@implementation ShopEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"店铺评价";
//    [self setupSubviews];
    ShopEvaluationView *shopEvaluationView = [[ShopEvaluationView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:shopEvaluationView];
    [self addTapAction];

    shopEvaluationView.evaluateBlock = ^(EvaluateModel *model){
        if ([StringUtils isEmpty:model.score]) {
            [HUDUtils showAlert:@"请您给此订单打分, 谢谢"];
            return ;
        }
//        if ([StringUtils isEmpty:model.remark]) {
//            [HUDUtils showAlert:@"请给出您的评价, 谢谢"];
//            return ;
//        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:model.score forKey:@"score"];
//        [params setValue:model.remark forKey:@"remark"];
        [params setValue:self.orderId forKey:@"orderId"];

        [PersonalHttpManager evaluateOrderWithParams:params success:^(CommonModelResult *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUDUtils showAlert:@"评价成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_ALL_ORDERS object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_HAD_RECEIVE object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_REFRESH_FINISH_ORDERS object:nil];

                UIViewController *vc = self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:vc animated:YES];
                
//                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        } failure:^(id responseObj, NSError *error) {
            [HUDUtils showAlert:@"评价失败"];
            
        }];
    };
    
    
    // Do any additional setup after loading the view.
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
