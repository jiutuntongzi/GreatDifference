//
//  MessageDetailCell.m
//  GreatDifference
//
//  Created by 杨旭根 on 2017/1/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import "MessageDetailCell.h"
#import "MessageModel.h"

@interface MessageDetailCell ()
//@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *detailLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UIImageView   *avatar;
@property (nonatomic, strong) UIImageView   *backImageView;



@end
@implementation MessageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.backImageView];
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.detailLabel];

}

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc]init];
        _avatar.layer.cornerRadius = 20;
        _avatar.layer.masksToBounds = YES;
        _avatar.backgroundColor = THEMECOLOR;
    }
    return _avatar;
}

//- (UILabel *)nameLabel{
//    if (!_nameLabel) {
//        _nameLabel = [[UILabel alloc]init];
//        _nameLabel.text = @"昵称";
//    }
//    return _nameLabel;
//}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = XGFONT(14);
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.text = @"怎么平台一直卡";
//        _detailLabel.backgroundColor = [UIColor redColor];
    }
    return _detailLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = XGFONT(12);
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"2017-1-12";
        _timeLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
        _timeLabel.layer.cornerRadius = 7;
        _timeLabel.font = XGFONT(12);
        _timeLabel.layer.masksToBounds = YES;

    }
    return _timeLabel;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView  = [[UIImageView alloc]init];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.multipleTouchEnabled = YES;
        _backImageView.image = [UIImage imageNamed:@"chat_receiver_bg"];
    }
    return _backImageView;
}

- (void)setMessage:(MessageModel *)message{
    _message = message;
    self.timeLabel.text     = message.createTime;
    self.detailLabel.text   = message.content;
//    
//    self.timeLabel.centerX = self.contentView.centerX;
//    self.timeLabel.top = 5;
    if (message.createTime) {
        CGSize timeSize = [self.timeLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.timeLabel.font} context:nil].size;
        self.timeLabel.frame = CGRectMake((SCREEN_WIDTH - timeSize.width - 8)/2, 5, timeSize.width+8, 14);
    }

    
    if (message.isSender) {
        CGFloat avatarY = 20;
        if (!message.createTime) {
            avatarY = 10;
        }
        self.avatar.frame = CGRectMake(SCREEN_WIDTH - 50, avatarY, 40, 40);
        self.avatar.backgroundColor = [UIColor greenColor];
        CGFloat detailY = CGRectGetMinY(self.avatar.frame)+10;
        CGSize size = [self.detailLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.detailLabel.font} context:nil].size;
        CGFloat detailX = SCREEN_WIDTH - 70 - size.width;
        self.detailLabel.frame = CGRectMake(detailX, detailY, size.width, size.height);

        self.backImageView.frame = CGRectMake(detailX - 10, detailY - 8, size.width + 20, size.height + 18);
        
        self.backImageView.image = [[UIImage imageNamed:@"chat_sender_bg"] stretchableImageWithLeftCapWidth:15 topCapHeight:35];


    }else{
        CGFloat avatarY = 20;
        if (!message.createTime) {
            avatarY = 10;
        }
        self.avatar.backgroundColor = THEMECOLOR;

        self.avatar.frame = CGRectMake(10, avatarY, 40, 40);
        CGFloat detailX = 70;
        CGFloat detailY = CGRectGetMinY(self.avatar.frame)+10;
        CGSize size = [self.detailLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.detailLabel.font} context:nil].size;
        self.detailLabel.frame = CGRectMake(detailX, detailY, size.width, size.height);
        self.backImageView.frame = CGRectMake(detailX - 10, detailY - 8, size.width + 20, size.height + 18);
        
        self.backImageView.image = [[UIImage imageNamed:@"chat_receiver_bg"] stretchableImageWithLeftCapWidth:35 topCapHeight:35];
    }
}

+ (CGFloat)getCellHeight:(MessageModel *)message{
    CGSize size = [message.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 160, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: XGFONT(14)} context:nil].size;
    if (!message.createTime) {
        return (size.height + 30)>60?size.height + 30:60;
    }else{
        return (size.height + 40)>60?size.height + 40:60;
 
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
