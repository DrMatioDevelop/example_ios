//
//  UIImage+MYKit.m
//  example
//
//  Created by d2c_cyf on 17/2/9.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "UIImage+MYKit.h"

@implementation UIImage (MYKit)
+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
