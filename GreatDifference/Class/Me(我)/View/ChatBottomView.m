//
//  ChatBottomView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/2/9.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "ChatBottomView.h"
#import "XDTextView.h"

@interface ChatBottomView ()
@property (nonatomic, strong) XDTextView         *textView;
@property (nonatomic, strong) UIButton           *submitBtn;
@end
@implementation ChatBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.textView];
    [self addSubview:self.submitBtn];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(140);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(40);
    }];
}

- (XDTextView *)textView{
    if (!_textView) {
        _textView = [[XDTextView alloc]init];
        _textView.placeholder = @"输入留言";
        _textView.layer.borderColor = LineColor.CGColor;
        _textView.layer.borderWidth = 1;
    }
    return _textView;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = THEMECOLOR;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)submitAction:(UIButton *)btn{
    if (self.submitBlock) {
        self.submitBlock(self.textView.text);
    }
}

- (void)clearText{
    self.textView.text = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
