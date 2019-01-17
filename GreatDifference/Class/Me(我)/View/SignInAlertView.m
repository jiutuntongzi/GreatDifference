//
//  SignInAlertView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/25.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "SignInAlertView.h"

#define titleWidth                  110
#define kAlertViewWidth             (SCREEN_WIDTH-80)
@interface SignInAlertView ()
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) UILabel           *detailLabel;
@property (nonatomic, strong) UIButton          *closeBtn;
@property (nonatomic, strong) UIView            *backDimView;
@property (nonatomic, strong) UIImageView       *backImageView;

@end
@implementation SignInAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backImageView];
//        [self addSubview:self.titleLabel];
//        [self addSubview:self.detailLabel];
        [self addSubview:self.closeBtn];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;

        _titleLabel.text    = @"签到成功";
        _titleLabel.layer.cornerRadius  = titleWidth*0.5;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font      = [UIFont boldSystemFontOfSize:23];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text   = @"今日签到成功,奖励1积分";
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = XGFONT(15);
    }
    return _detailLabel;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
//        [_closeBtn setImage:[UIImage imageNamed:@"cha_icon"] forState:UIControlStateNormal];
//        [_closeBtn setTitle:@"X" forState:UIControlStateNormal];
//        [_closeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _closeBtn.titleLabel.font   = XGFONT(18);
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIView *)backDimView{
    if (!_backDimView) {
        _backDimView = [[UIView alloc]init];
        _backDimView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        
    }
    return _backDimView;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.image = [UIImage imageNamed:@"signIn_success_bg"];
    }
    return _backImageView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat titleY  = 40;
    CGFloat titleX  = (self.width - titleWidth) * 0.5;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleWidth, titleWidth);
    
    self.detailLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+ 20, self.width, 40);
    
//    self.closeBtn.frame = CGRectMake(self.width - 30, 10, 20, 20);
    self.closeBtn.frame = self.bounds;
    self.backImageView.frame = self.bounds;

}

- (void)show{
    UIViewController *rootVc = [self appRootViewController];
    self.frame = CGRectMake((SCREEN_WIDTH - kAlertViewWidth)*0.5, 0, kAlertViewWidth, kAlertViewWidth*1.06);
    self.centerY = rootVc.view.centerY;
    [rootVc.view addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview == nil) {
        return;
    }
    
    UIViewController *rootVc = [self appRootViewController];
    self.backDimView.frame= rootVc.view.bounds;
    [rootVc.view addSubview:self.backDimView];
    
    [super willMoveToSuperview:newSuperview];
    
}

- (void)removeFromSuperview{
    [self.backDimView removeFromSuperview];
    self.backDimView = nil;
    
    [super removeFromSuperview];
}

- (void)closeBtnClicked:(UIButton *)btn{
    [self dismiss];
}


- (UIViewController *)appRootViewController{
    
    UIViewController *rootViewController =  [UIApplication sharedApplication].keyWindow.rootViewController;
    while (rootViewController.presentedViewController) {
        rootViewController = rootViewController.presentedViewController;
    }
    return rootViewController;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
