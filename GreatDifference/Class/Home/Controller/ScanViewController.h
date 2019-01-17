//
//  ScanViewController.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/24.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanViewController : UIViewController
@property (nonatomic, assign) BOOL     fromHome; // 从首页进去的只能扫店铺
@property (nonatomic, copy) NSString  *shopId;

@end
