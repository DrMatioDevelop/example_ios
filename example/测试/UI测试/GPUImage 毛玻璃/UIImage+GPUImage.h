//
//  UIImage+GPUImage.h
//  iOS-UIImageBoxBlur
//
//  Created by d2c_cyf on 17/3/16.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GPUImage)

/**
 高斯模糊

 @param image 图片
 @param blur  模糊数值（0-n）
 @return 重新绘制新的图片
 */
+ (UIImage *)applayGaussianSelectiveBlur:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
