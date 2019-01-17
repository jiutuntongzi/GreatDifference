//
//  ShopEvaluationView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/23.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "ShopEvaluationView.h"
#import "TggStarEvaluationView.h"
#import "XDTextView.h"
#import "EvaluateModel.h"

@interface ShopEvaluationView ()
@property (strong ,nonatomic) TggStarEvaluationView *tggStarEvaView;
//@property (nonatomic, strong) XDTextView      *textView;
@property (nonatomic, strong) UILabel         *totalScoresLabel;
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIView          *lineView1;
@property (nonatomic, strong) UIButton        *publicBtn;
@property (nonatomic, assign) NSUInteger      starCount;

@end
@implementation ShopEvaluationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.totalScoresLabel];
    [self addSubview:self.tggStarEvaView];
    [self addSubview:self.lineView];
//    [self addSubview:self.textView];
//    [self addSubview:self.lineView1];
    [self addSubview:self.publicBtn];
    
    [self.totalScoresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(33 + 64));
        make.left.equalTo(@10);
    
    }];
    
    [self.tggStarEvaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalScoresLabel.mas_right).offset(20);
        make.top.equalTo(@85);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(230);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.tggStarEvaView.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.totalScoresLabel);
//        make.top.equalTo(self.lineView.mas_bottom).offset(10);
//        make.right.equalTo(self).offset(-10);
//        make.height.mas_equalTo(110);
//    }];
    
//    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.textView.mas_bottom);
//        make.height.mas_equalTo(0.5);
//    }];

    [self.publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.lineView).offset(30);
        make.height.mas_equalTo(40);
    }];
}


//- (XDTextView *)textView{
//    if (!_textView) {
//        _textView = [[XDTextView alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH - 20, 100)];
//        _textView.placeholder = @"商品质量怎么样,卖家服务态度好吗?敬请吐槽";
//    }
//    return _textView;
//}

- (TggStarEvaluationView *)tggStarEvaView{
    if (_tggStarEvaView) {
        return _tggStarEvaView;
    }
    
    _tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        NSLog(@"\n\n给了铁哥哥：%ld星好评！！!\n\n",count);
        self.starCount = count;
    }];
    self.tggStarEvaView.frame = (CGRect){80,50,23 * 10,45};
    [self.tggStarEvaView setSpacing:0.3];

    return _tggStarEvaView;
}

- (UILabel *)totalScoresLabel{
    if (!_totalScoresLabel) {
        _totalScoresLabel = [[UILabel alloc]init];
        _totalScoresLabel.text     = @"总分";
        _totalScoresLabel.textColor = [UIColor grayColor];
    }
    return _totalScoresLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = LineColor;
    }
    return _lineView1;
}

- (UIButton *)publicBtn{
    if (!_publicBtn) {
        _publicBtn = [[UIButton alloc]init];
        _publicBtn.backgroundColor = THEMECOLOR;
        [_publicBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_publicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_publicBtn addTarget:self action:@selector(publicAction) forControlEvents:UIControlEventTouchUpInside];
        _publicBtn.layer.cornerRadius = 3;
    }
    return _publicBtn;
}

- (void)publicAction{
    EvaluateModel *model = [[EvaluateModel alloc]init];
    model.score = [NSString stringWithFormat:@"%lu",(unsigned long)self.starCount];
//    model.remark = self.textView.text;
    
    if (self.evaluateBlock) {
        self.evaluateBlock(model);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
