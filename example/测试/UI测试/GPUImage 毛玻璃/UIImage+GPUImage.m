//
//  UIImage+GPUImage.m
//  iOS-UIImageBoxBlur
//
//  Created by d2c_cyf on 17/3/16.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "UIImage+GPUImage.h"
@implementation UIImage (GPUImage)
+ (UIImage *)applayGaussianSelectiveBlur:(UIImage *)image withBlurNumber:(CGFloat)blur {
//    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
//    filter.texelSpacingMultiplier = blur;
//    filter.blurRadiusInPixels = 1;
//    [filter forceProcessingAtSize:image.size];
//    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
//    [pic addTarget:filter];
//    [pic processImage];
//    [filter useNextFrameForImageCapture];
//    return [filter imageFromCurrentFramebuffer];
    

    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = blur; //(0-n)
    
    //创建一个亮度滤镜
    GPUImageBrightnessFilter *passthroughGilter = [[GPUImageBrightnessFilter alloc] init];
    passthroughGilter.brightness = 0.05; // -1 --0-- 1
    [passthroughGilter forceProcessingAtSize:image.size];
    
    //??
    [passthroughGilter useNextFrameForImageCapture];
    
    //图片转换为能处理的数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:[blurFilter imageByFilteringImage:image]];
    
    //添加滤镜
    [stillImageSource addTarget:passthroughGilter];
    
    //开始渲染图片
    [stillImageSource processImage];
    
    UIImage *returnImg = [passthroughGilter imageFromCurrentFramebuffer];
    return returnImg;
    
    
}
@end
