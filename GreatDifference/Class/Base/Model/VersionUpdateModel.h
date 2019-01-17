//
//  VersionUpdateModel.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2017/3/15.
//  Copyright © 2017年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionUpdateModel : NSObject
@property (nonatomic, copy) NSString  *versionName;         //最新版本，例如：V1.1
@property (nonatomic, copy) NSString  *downloadPath;
@property (nonatomic, copy) NSString  *upgradeInstructions;  // 更新内容；
@property (nonatomic, copy) NSString  *isMandatoryUpgrade;  //是否强制更新；1-是；0-否；暂不做强制更新处理。


@end
