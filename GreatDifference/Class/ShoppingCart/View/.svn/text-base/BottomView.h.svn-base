//
//  BottomView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  全选按钮状态
 */
typedef NS_ENUM(NSInteger, UIButtonStatus) {
    UIButtonStatusNormal,
    UIButtonStatusSelect,
};
@class BottomView;
@protocol BottomViewDelegate <NSObject>

- (void)bottomView:(BottomView *)bottom didSelectAllButton:(BOOL) isSelect;
- (void)bottomView:(BottomView *)bottom didSelectCashButton:(UIButton *)btn;
- (void)bottomView:(BottomView *)bottom didSelectDeleteButton:(UIButton *)btn;

@end
@interface BottomView : UIView
@property (nonatomic, strong) UIView          *deleteView;

@property (nonatomic, weak) id<BottomViewDelegate>  delegate;
@property (nonatomic, assign) BOOL     showDeleteBtn; // 是否显示删除按钮
- (UIButtonStatus )getButtonStats;
- (void)setSelectAllStatus:(UIButtonStatus )status;
- (void)setTotalPrice:(float )price totalQuantity:(NSInteger)num;

@end
