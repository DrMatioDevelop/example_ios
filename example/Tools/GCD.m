//
//  GCD.m
//  example
//
//  Created by d2c_cyf on 17/3/16.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "GCD.h"

@implementation GCD
+ (void)ddd {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}
@end
