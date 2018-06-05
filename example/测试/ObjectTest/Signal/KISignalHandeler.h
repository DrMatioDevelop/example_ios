//
//  KISignalHandeler.h
//  example
//
//  Created by 陈雁锋 on 2018/5/23.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/signal.h>

@interface KISignalHandeler : NSObject <UIAlertViewDelegate>

+ (void)registerSignalhandler;

+ (instancetype)shareInstance;

- (void)HandleException:(NSException *)exception;
@end

