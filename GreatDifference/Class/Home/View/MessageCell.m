//
//  MessageCell.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/25.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"

@interface MessageCell ()
@property (nonatomic, strong) UIImageView     *icon;
@property (nonatomic, strong) UIImageView     *indicateView;

@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIView          *lineView1;

@property (nonatomic, strong) UILabel         *titleLabel;
@property (nonatomic, strong) UILabel         *detailLabel;
@property (nonatomic, strong) UILabel         *timeLabel;
@property (nonatomic, strong) UILabel         *lookupLabel;
@property (nonatomic, copy) NSString          *identifier;
@end
@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _identifier = reuseIdentifier;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.lineView1];

    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.lookupLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.indicateView];

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(20);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.icon);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(1);
    }];

    
    if (![self.identifier isEqualToString:@"leaveMessageCell"]) {
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(30);
            make.top.equalTo(self.icon);
            make.height.mas_equalTo(20);
        }];
        
    }

    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        if (![self.identifier isEqualToString:@"leaveMessageCell"]) {
            make.top.height.equalTo(self.titleLabel);
        }else{
            make.left.equalTo(self.lineView.mas_right).offset(30);
            make.top.equalTo(self.icon);
            make.height.mas_equalTo(20);
        }
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(30);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-30);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(55);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(kSpace);
        make.right.equalTo(self.contentView).offset(-25);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.lookupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLabel);
        make.top.equalTo(self.lineView1.mas_bottom).offset(kSpace * 0.8);
        
    }];
    
    [self.indicateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.lookupLabel);
        make.width.height.mas_equalTo(20);
    }];

}


- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"icon_add"];
    }
    return _icon;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView1;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"订单通知";
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = [UIColor lightGrayColor];
        _detailLabel.font = XGFONT(14);
        _detailLabel.text   = @"亲爱的用户您购买的手机订单已经生成,返还您通用积分19,海淘积分20";
//        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = XGFONT(12);
        _timeLabel.text   = @"16/11/26";

    }
    return _timeLabel;
}

- (UILabel *)lookupLabel{
    if (!_lookupLabel) {
        _lookupLabel = [[UILabel alloc]init];
        _lookupLabel.textColor = [UIColor lightGrayColor];
        _lookupLabel.font = XGFONT(14);
        _lookupLabel.text = @"查看详情";
    }
    return _lookupLabel;
}

- (UIImageView *)indicateView{
    if (!_indicateView) {
        _indicateView = [[UIImageView alloc]init];
//        _indicateView.backgroundColor = [UIColor lightGrayColor];
        _indicateView.image = [UIImage imageNamed:@"right_arrow"];
    }
    return _indicateView;
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
    CGContextSetFillColorWithColor(context, THEMECOLOR.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGPoint aPoint[8];
    aPoint[0]   = CGPointMake(50, 110);
    aPoint[1]   = CGPointMake(SCREEN_WIDTH - 20, 110);
    aPoint[2]   = CGPointMake(SCREEN_WIDTH - 20, 15);
    aPoint[3]   = CGPointMake(50, 15);
    aPoint[4]   = CGPointMake(50, 20);
    aPoint[5]   = CGPointMake(42, 25);
    aPoint[6]   = CGPointMake(50, 33);
    aPoint[7]   = CGPointMake(50, 110);
    
    CGContextAddLines(context, aPoint, 8);
    CGContextDrawPath(context, kCGPathStroke);
    
}

- (void)setMessage:(MessageModel *)message{
    _message = message;
    self.titleLabel.text        = message.subject;
    self.timeLabel.text         = message.createTime;
    self.detailLabel.text       = message.content;
    
}

- (void)setSystemMsg:(MessageModel *)systemMsg{
    _systemMsg = systemMsg;
    self.titleLabel.text        = systemMsg.subject;
    self.timeLabel.text         = systemMsg.createTime;
    self.detailLabel.text       = systemMsg.message;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
