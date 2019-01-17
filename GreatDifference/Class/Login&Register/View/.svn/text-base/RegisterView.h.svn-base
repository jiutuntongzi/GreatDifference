//
//  RegisterView.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/14.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlatformView.h"
#import "RegisterModel.h"

@interface RegisterView : UIView
@property (nonatomic, strong) UITextField       *phoneTextField;

@property (nonatomic, strong) PlatformView      *platformView;
@property (nonatomic, copy) dispatch_block_t    protocolBlock;
@property (nonatomic, copy) void(^registerBlock)(RegisterModel *model);
@property (nonatomic, copy) void(^getValidBlock)(NSString *phoneNum);

- (void)setValidCodeBtnTitle:(NSString *)title;
@end
