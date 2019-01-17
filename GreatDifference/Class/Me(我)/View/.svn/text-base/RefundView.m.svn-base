//
//  RefundView.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "RefundView.h"

@interface RefundView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIButton        *titleBtn;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UILabel         *titleLabel;

@property (nonatomic, strong) UILabel         *reasonLabel;
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIView          *lineView1;
@property (nonatomic, strong) UITextField     *textField;
@property (nonatomic, strong) UIPickerView    *pickerView;
@property (nonatomic, strong) UIView          *pickerAccessoryView;

@property (nonatomic, strong) NSArray         *dataSource;

@property (nonatomic, strong) UIButton        *submitBtn;
@end
@implementation RefundView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview:self.reasonLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.titleBtn];
    [self addSubview:self.detailLabel];
    [self addSubview:self.addPictureBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.lineView1];
    [self addSubview:self.textField];
    [self addSubview:self.submitBtn];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self).offset(64);
//
//        make.height.mas_equalTo(0.5);
//    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self).offset(74);
    }];
    
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(64);

    }];
    
    [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel);
        make.left.equalTo(self).offset(SCREEN_WIDTH/2);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.lineView1.mas_bottom).offset(10);
    }];
    
    [self.addPictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.width.height.mas_equalTo(80);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.bottom.equalTo(@-20);
        make.height.mas_equalTo(40);
    }];
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = XGFONT(15);
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text = @"请选择退款/退货原因";
    }
    return _titleLabel;
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

- (UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [[UIButton alloc]init];
        [_titleBtn addTarget:self action:@selector(didClickeReason:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = XGFONT(15);
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.text = @"上传凭证";

    }
    return _detailLabel;

}

- (UILabel *)reasonLabel{
    if (!_reasonLabel) {
        _reasonLabel = [[UILabel alloc]init];
        _reasonLabel.font = XGFONT(15);
        
    }
    return _reasonLabel;
    
}

- (UIButton *)addPictureBtn{
    if (!_addPictureBtn) {
        _addPictureBtn = [[UIButton alloc]init];
        _addPictureBtn.backgroundColor = [UIColor redColor];
        [_addPictureBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPictureBtn;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.inputView = self.pickerView;
        _textField.inputAccessoryView = self.pickerAccessoryView;
    }
    return _textField;
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource  = self;
    }
    return _pickerView;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = THEMECOLOR;
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (UIView *)pickerAccessoryView
{
    if (!_pickerAccessoryView) {
        _pickerAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _pickerAccessoryView.backgroundColor = [UIColor grayColor];
        
        UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 25)];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
        [_pickerAccessoryView addSubview:finishBtn];
    }
    return _pickerAccessoryView;
}


- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"东西损坏", @"过了保质期", @"买错了", @"不想买了", @"其他"];
    }
    return _dataSource;
}

- (void)didClickeReason:(UIButton *)btn{
    [self.textField becomeFirstResponder];
}

- (void)finishAction:(UIButton *)btn
{
    [self.textField resignFirstResponder];

}

- (void)submitAction:(UIButton *)btn{
    
}

- (void)addPictureAction:(UIButton *)btn{
    if (self.addPictureBlock) {
        self.addPictureBlock(btn);
    }
}


#pragma mark -- UIPickerViewDataSource && delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *content = self.dataSource[row];
    self.reasonLabel.text = content;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
