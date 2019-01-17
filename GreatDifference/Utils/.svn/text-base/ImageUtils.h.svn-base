//
//  ImageUtils.h
//  GreatDifference
//
//  Created by xiaodou_yxg on 2016/11/9.
//  Copyright © 2016年 xiaodou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject
/** 加载图片 不带默认图片 */
+(void)loadImageWithUrl:(NSString *)imageUrl
              imageView:(UIImageView *)imageView;

/** 加载图片 带默认图片 */
+(void)loadImageWithUrl:(NSString *)imageUrl
              imageView:(UIImageView *)imageView
            placeHolder:(UIImage *)image;

/** 给按钮加载图片 不带默认图片 */
+(void)loadImageWithUrl:(NSString *)imageUrl
                 button:(UIButton *)button;

/** 给按钮加载图片 带默认图片 */
+(void)loadImageWithUrl:(NSString *)imageUrl
                 button:(UIButton *)button
            placeHolder:(UIImage *)image;

/** 给给大不同加载图片 带默认图片   只需传入图片名称*/
+(void)loadImageWithLastComponentUrl:(NSString *)imageUrl
                 imageView:(UIImageView *)imageView
            placeHolder:(UIImage *)image;

/** 给给大不同加载图片 带默认图片   只需传入图片名称*/
+(void)loadImageWithLastComponentUrl:(NSString *)imageUrl
                           button:(UIButton *)button
                         placeHolder:(UIImage *)image;
@end
