//
//  GCD.m
//  example
//
//  Created by d2c_cyf on 17/3/16.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "GCD.h"

@implementation GCD
+ (void)GCDGlobalTask:(void (^)(void))globalTask mainTask:(void(^)(void))mainTask {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        globalTask();
        dispatch_async(dispatch_get_main_queue(), ^{
            mainTask();
        });
    });
}
@end
