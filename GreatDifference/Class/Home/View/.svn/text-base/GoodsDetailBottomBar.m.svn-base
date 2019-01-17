//
//  GoodsDetailBottomBar.m
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/28.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import "GoodsDetailBottomBar.h"


@interface GoodsDetailBottomBar ()
@property (nonatomic, strong) UIView             *lineView;
@property (nonatomic, strong) CustomButton        *leaveMessageBtn;
@property (nonatomic, strong) CustomButton        *shopCartBtn;
@property (nonatomic, strong) UIButton            *addShopCartBtn;
@property (nonatomic, strong) UIButton            *purchaseBtn;
//@property (nonatomic, strong) UILabel             *dotLabel;
@end
@implementation GoodsDetailBottomBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self addSubview: self.lineView];
//    [self addSubview:self.leaveMessageBtn];
    [self addSubview:self.collectBtn];
    [self addSubview:self.purchaseBtn];
    
    [self addSubview:self.addShopCartBtn];
    [self addSubview:self.shopCartBtn];
    [self.shopCartBtn addSubview:self.dotLabel];

    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
//    [self.leaveMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(self);
//        CGFloat width = 45;
//        if (IS_IPHONE_6S) {
//            width   = 50;
//        }else if (IS_IPHONE_6SPlus){
//            width = 60;
//        }
//        make.width.mas_equalTo(width);
//    }];
    
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.width.equalTo(self.leaveMessageBtn);
//        make.left.equalTo(self.leaveMessageBtn.mas_right);
        
        make.left.top.bottom.equalTo(self);
        CGFloat width = 60;
        if (IS_IPHONE_5) {
            width   = 0.853*width;
        }else if (IS_IPHONE_6SPlus){
            width = 1.1*width;
        }
        make.width.mas_equalTo(width);
        
    }];
    
    [self.shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.collectBtn);
        make.left.equalTo(self.collectBtn.mas_right);
        
    }];
    
    [self.addShopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopCartBtn.mas_right);
        make.top.bottom.equalTo(self);
    }];
    
    [self.purchaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addShopCartBtn.mas_right);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(self.addShopCartBtn);
    }];

    
    [self.dotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopCartBtn.mas_right).offset(-8);
        make.top.equalTo(self.shopCartBtn).offset(3);
        make.width.height.mas_equalTo(10);
    }];
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = LineColor;
    }
    return _lineView;
}

- (CustomButton *)leaveMessageBtn{
    if (!_leaveMessageBtn) {
        _leaveMessageBtn = [[CustomButton alloc]initWithTitle:@"留言" image:@"message_icon_gray" imageWidth:20];
        [_leaveMessageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _leaveMessageBtn.tag    = BottomBarTypeLeave;
        _leaveMessageBtn.titleLabel.font    = XGFONT(12);
        [_leaveMessageBtn addTarget:self action:@selector(didClickedGoodsDetailBottom:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _leaveMessageBtn;
}


- (CustomButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [[CustomButton alloc]initWithTitle:@"收藏" image:@"collect_icon_gray" imageWidth:20];
        [_collectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_icon_select"] forState:UIControlStateSelected];
        _collectBtn.titleLabel.font    = XGFONT(12);
        _collectBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _collectBtn.tag    = BottomBarTypeCollect;

        [_collectBtn addTarget:self action:@selector(didClickedGoodsDetailBottom:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _collectBtn;
}

- (CustomButton *)shopCartBtn{
    if (!_shopCartBtn) {
        _shopCartBtn = [[CustomButton alloc]initWithTitle:@"购物车" image:@"shopCart_icon_gray" imageWidth:20];
        [_shopCartBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _shopCartBtn.titleLabel.font    = XGFONT(12);
        _shopCartBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _shopCartBtn.tag    = BottomBarTypeShopCart;

        [_shopCartBtn addTarget:self action:@selector(didClickedGoodsDetailBottom:) forControlEvents:UIControlEventTouchUpInside];


    }
    return _shopCartBtn;
}

- (UIButton *)addShopCartBtn{
    if (!_addShopCartBtn) {
        _addShopCartBtn = [[UIButton alloc]init];
        _addShopCartBtn.backgroundColor = THEMECOLOR;
        [_addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addShopCartBtn.tag    = BottomBarTypeAddShopCart;

        [_addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addShopCartBtn addTarget:self action:@selector(didClickedGoodsDetailBottom:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addShopCartBtn;
}

- (UIButton *)purchaseBtn{
    if (!_purchaseBtn) {
        _purchaseBtn = [[UIButton alloc]init];
        _purchaseBtn.backgroundColor = [UIColor redColor];
        [_purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_purchaseBtn addTarget:self action:@selector(didClickedGoodsDetailBottom:) forControlEvents:UIControlEventTouchUpInside];
        _purchaseBtn.tag    = BottomBarTypeBuy;


    }
    return _purchaseBtn;
}

- (UILabel *)dotLabel{
    if (!_dotLabel) {
        _dotLabel = [[UILabel alloc]init];
        _dotLabel.backgroundColor = [UIColor redColor];
        _dotLabel.layer.cornerRadius = 5;
        _dotLabel.layer.masksToBounds = YES;
        _dotLabel.hidden = YES;
    }
    return _dotLabel;
}

#pragma mark -- clickedAction
- (void)didClickedGoodsDetailBottom:(UIButton *)btn{
    BottomBarType type = btn.tag;

    if (self.bottomBarBlock) {
        self.bottomBarBlock(nil, type);
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
