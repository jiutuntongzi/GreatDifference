//
//  SignInViewController.m
//  GreatDifference
//
//  Created by 杨旭根 on 2016/11/15.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SignInViewController.h"
#import "CalendarSignInView.h"
#import "SignInModelResult.h"
#import "SignInAlertView.h"
#import "PersonalHttpManager.h"

@interface SignInViewController ()<SignInDelegate>
@property (nonatomic, strong) NSMutableArray  *dataSource;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = [NSMutableArray array];

    [self configureData];

    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;

}

- (void)configureData{
    [PersonalHttpManager getSignInfoWithParams:nil success:^(SignInModelResult *responseObj) {
        SignInModel *signInModel = responseObj.data;
        
        [self setupSignInView:signInModel];
        
    } failure:^(id responseObj, NSError *error) {
        
    }];
}


- (void)setupSignInView:(SignInModel *)signInModel{

    CalendarSignInView *signView = [[CalendarSignInView alloc]initWithFrame:self.view.bounds];
    signView.signInModel = signInModel;
    signView.delegate = self;
    [self.view addSubview:signView];
}

- (void)signInView:(CalendarSignInView *)signInView didClickedSignBtn:(UIButton *)signBtn{
    if (signBtn.userInteractionEnabled) {
    
        [PersonalHttpManager SignInWithParams:nil success:^(CommonModelResult *responseObj) {
            
            SignInAlertView *alertView = [[SignInAlertView alloc]init];
            [alertView show];
            
            signBtn.selected = YES;
            signBtn.userInteractionEnabled = NO;
            signBtn.backgroundColor = [UIColor lightGrayColor];
            [self configureData];
        } failure:^(id responseObj, NSError *error) {
            
        }];

    }
}


- (NSInteger )weekdayStringFromDate:(NSDate*)inputDate {
    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return theComponents.weekday;
    
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
