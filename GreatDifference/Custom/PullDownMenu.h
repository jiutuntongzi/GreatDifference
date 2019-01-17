//
//  PopView.h
//  SweePea
//
//  Created by xiaodou_yxg on 16/6/29.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)(NSString *storeTypeId);
@interface PullDownMenu : UIView

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) CallBack callBack;

- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray;

@end
