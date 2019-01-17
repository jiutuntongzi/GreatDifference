//
//  XDTextView.m
//  XDET
//
//  Created by xiaodou_yxg on 16/5/16.
//  Copyright © 2016年 Xiaodou. All rights reserved.
//

#import "XDTextView.h"

@interface XDTextView ()<UITextViewDelegate>

@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,strong) UILabel *placeholdLabel;

@end
@implementation XDTextView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.textView];
    [self.textView addSubview:self.placeholdLabel];
    

}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.font = XGFONT(15);
//        _textView.layer.borderWidth = 1.f;
//        _textView.layer.cornerRadius = 3;
    }
    return _textView;
}

- (UILabel *)placeholdLabel
{
    if (!_placeholdLabel) {
        _placeholdLabel = [[UILabel alloc]init];
        _placeholdLabel.textColor = [UIColor lightGrayColor];
        _placeholdLabel.font = [UIFont systemFontOfSize:15];
        _placeholdLabel.numberOfLines   = 0;
        
    }
    return _placeholdLabel;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    
    CGRect textViewFrame = self.textView.frame;
    textViewFrame.origin.x = self.edgeInsets.left;
    textViewFrame.origin.y = self.edgeInsets.top;
    CGFloat width = self.bounds.size.width - self.edgeInsets.left*2;
    CGFloat height = self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom;
    
    textViewFrame.size = CGSizeMake(width, height);
    self.textView.frame = textViewFrame;
    CGRect placeholderFrame;
    CGFloat holderX = 5;
    CGFloat holderY = 5;
    CGSize size = [_placeholder boundingRectWithSize:CGSizeMake(self.bounds.size.width - 2*holderX, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.placeholdLabel.font} context:nil].size;
    placeholderFrame = CGRectMake(holderX, holderY, size.width, size.height);
    self.placeholdLabel.frame = placeholderFrame;


}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholdLabel.text = placeholder;
    
    XGLog(@"%@",self.placeholdLabel);
    
}
- (NSString *)text
{
    return self.textView.text;
}

- (void)setText:(NSString *)text
{
//    _text = text;
    self.textView.text = text;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    self.textView.font = font;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.textView.backgroundColor = backgroundColor;
}

#pragma mark -- textViewDelegate


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        self.placeholdLabel.text = @"";
        
    }else
    {
        self.placeholdLabel.text = _placeholder;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
