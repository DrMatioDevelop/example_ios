//
//  UIImage+MYKit.h
//  example
//
//  Created by d2c_cyf on 17/2/9.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MYKit)
+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;
@end
