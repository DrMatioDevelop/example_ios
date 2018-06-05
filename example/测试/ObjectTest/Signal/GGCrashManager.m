//
//  GGCrashManager.m
//  example
//
//  Created by 陈雁锋 on 2018/5/23.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "GGCrashManager.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

@implementation GGCrashManager

// 系统信号截获处理方法
void signalHandler(int signal);
// 异常截获处理方法
void exceptionHandler(NSException *exception);
// 最大处理数
const int32_t _uncaughtExceptionMaximum = 10;

void signalHandler(int signal) {
    volatile int32_t _uncaughtExceptionCount = 0;
    
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    // 如果太多不用处理
    if (exceptionCount > _uncaughtExceptionMaximum) {
        return;
    }
    //获取堆栈信息
    NSArray *callStack = [GGCrashManager backtrace];
    for (id sss in callStack) {
        NSLog(@"%@",sss);
    }
    NSLog(@"crash--------error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    NSArray *models =CFBridgingRelease(CFRunLoopCopyAllModes(runLoop));
    while (!isExit) {
        for (NSString *mode in models) {
            //快速切换主线程的RunLoop模式 防止主线程的RunLoop在单一模式下运行 不响应用户的操作。
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}

static bool isExit = NO;

void exceptionHandler(NSException *exception) {
    
    NSLog(@"%@----%@----%@----",[exception userInfo],exception.name,exception.reason);
    NSLog(@"crash--------error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    
    volatile int32_t _uncaughtExceptionCount = 0;
    int32_t exceptionCount = OSAtomicIncrement32(&_uncaughtExceptionCount);
    if (exceptionCount > _uncaughtExceptionMaximum)  {
        return;
    }
    //获取堆栈信息
    NSArray *callStack = [GGCrashManager backtrace];
    for (id sss in callStack) {
        NSLog(@"%@",sss);
    }
    
    NSArray  *doDirArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doDir = [[doDirArray firstObject] stringByAppendingPathComponent:@"Bug"];
    NSDictionary *dic = @{@"bug1" : callStack};
    [dic writeToFile:doDir atomically:YES];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    NSArray *models =CFBridgingRelease(CFRunLoopCopyAllModes(runLoop));
    while (!isExit) {
        for (NSString *mode in models) {
            //快速切换主线程的RunLoop模式 防止主线程的RunLoop在单一模式下运行 不响应用户的操作。
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}
+ (GGCrashManager *)shareInstance {
    static GGCrashManager *crashManager  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        crashManager = [[GGCrashManager alloc]init];
    });
    return crashManager;
}
//获取调用堆栈
+ (NSArray *)backtrace {
    void * callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack,frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i=0;i<frames;i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}

// 注册崩溃拦截
-(void)installExceptionHandler {
    NSSetUncaughtExceptionHandler(&exceptionHandler);
    
    signal(SIGHUP, signalHandler);
    
    signal(SIGINT, signalHandler);
    
    signal(SIGQUIT, signalHandler);
    
    signal(SIGABRT, signalHandler);
    
    signal(SIGILL, signalHandler);
    
    signal(SIGSEGV, signalHandler);
    
    signal(SIGFPE, signalHandler);
    
    signal(SIGBUS, signalHandler);
    
    signal(SIGPIPE, signalHandler);
}

+ (void)exit {
    isExit = YES;
}
+ (void)startCatchCrash {
    GGCrashManager *crashManager = [GGCrashManager shareInstance];
    [crashManager installExceptionHandler];
}


@end

