//
//  GCD.h
//  example
//
//  Created by d2c_cyf on 17/3/16.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject
+ (void)GCDGlobalTask:(void (^)(void))globalTask mainTask:(void(^)(void))mainTask;
@end
