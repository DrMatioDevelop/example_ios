 //
//  KISignalHandeler.m
//  example
//
//  Created by 陈雁锋 on 2018/5/23.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KISignalHandeler.h"

#include <libkern/OSAtomic.h>
#include <execinfo.h>

//当前处理的异常个数
volatile int32_t UncaughExceptionCount = 0;
//最大能够处理的异常个数
volatile int32_t UncaughExceptionMaximum = 10;

void HandleException(int signo) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughExceptionCount);
    if (exceptionCount > UncaughExceptionMaximum) {
        return;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signo] forKey:@"signal"];
    //创建一个OC异常对象
    NSException *exception = [NSException exceptionWithName:@"SignalExceptionName" reason:[NSString stringWithFormat:@"Signal %d was raised.\n",signo] userInfo:userInfo];
    //异常处理
    [[KISignalHandeler shareInstance] performSelectorOnMainThread:@selector(HandleException:) withObject:exception waitUntilDone:YES];
}

@implementation KISignalHandeler

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static KISignalHandeler *signal = nil;
    dispatch_once(&onceToken, ^{
        signal = [[self alloc] init];
    });
    return signal;
}

+ (void)registerSignalhandler {
//    //1.注册程序由于abort()函数调用发生的程序中止信号(程序中止命令中止信号)
//    signal(SIGABRT, HandleException);
//    
//    //2.注册程序由于非法指令产生的中止信号(程序非法指令信号)
//    signal(SIGILL, HandleException);
//    
//    //3.注册程序由于无效内存的引用导致的程序中止信号(程序内无效内存中止信号)
//    signal(SIGSEGV, HandleException);
//    
//    //4.注册程序由于内存地址未对齐导致的程序中止信号(程序浮点异常信号)
//    signal(SIGFPE, HandleException);
//    
//    //5.注册程序由于内存地址未对齐导致的程序中止信号(程序内存字节未对齐中止信号)
//    signal(SIGBUS, HandleException);
//    
//    //6.注册通过端口发送消息是被导致的程序中止信号(程序Socket发送失败中止信号)
//    signal(SIGPIPE, HandleException);
    
    signal(SIGHUP, HandleException);
    
    signal(SIGINT, HandleException);
    
    signal(SIGQUIT, HandleException);
    
    signal(SIGABRT, HandleException);
    
    signal(SIGILL, HandleException);
    
    signal(SIGSEGV, HandleException);
    
    signal(SIGFPE, HandleException);
    
    signal(SIGBUS, HandleException);
    
    signal(SIGPIPE, HandleException);
    
    //7.SIGALRM (程序超时信号)
    //8.SIGHUP  (程序终端中止信号)
    //9.SIGINT  (程序键盘中断信号)
    //10.SIGKILL(程序结束接收中止信号)
    //11.SIGTERM(程序kill中止信号)
    //12.SIGSTOP(程序键盘中止信号)
    
    
    // SIGKILL ,SIGSTOP无法被截获并处理
}

BOOL isDismissed = NO;

- (void)HandleException:(NSException *)exception {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"程序出现问题" message:@"崩溃信息" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    [alertView show];
    
    //当接受到异常处理消息时,让程序开始runLoop,防止程序死亡
    while (!isDismissed) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
        }
    }
    
    //当电机弹出试图的Cancel按钮, isDismiss = YES,上边的循环跳出
    CFRelease(allModes);
    NSSetUncaughtExceptionHandler(NULL);
    
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //因为这个弹出试图只有一个Cancel按钮,所以直接进行修改isDismissed这个变量
    isDismissed = YES;
}


@end
