//
//  GGCrashManager.h
//  example
//
//  Created by 陈雁锋 on 2018/5/23.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GGCrashManager : NSObject <UIAlertViewDelegate>

/**
 *  开启捕获crash
 */
+ (void)startCatchCrash;

/**
 *  应用进入后天 调用此方法crash应用 防止用户正在操作崩溃，影响体验
 */
+ (void)exit;

@end
