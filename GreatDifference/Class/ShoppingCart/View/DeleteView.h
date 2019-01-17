//
//  DeleteView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/12/16.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeleteView;

@protocol DeleteViewDelegate <NSObject>

- (void)deleteView:(DeleteView *)bottom didSelectAllButton:(BOOL) isSelect;

- (void)deleteView:(DeleteView *)bottom didSelectDeleteButton:(UIButton *)btn;


@end
@interface DeleteView : UIView
@property (nonatomic, weak) id<DeleteViewDelegate>  delegate;


@end
