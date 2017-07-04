//
//  GCD_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "GCD_ViewController.h"

@interface GCD_ViewController ()

@end

@implementation GCD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"开始执行" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 64, 100, 50);
    [self.view bringSubviewToFront:button];
    [button addTarget:self action:@selector(beginTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)beginTask:(UIButton *)btn {
//    [self GCD_Seamphone];
    
    [self gcd_test];
    NSLog(@"\n\n\n");
}


- (void)gcd_test {
    //队列分为串行与并行
    dispatch_queue_t serialQueue = dispatch_queue_create("com.163.cyfsoftwareSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.16.cyfsoftwareCon", DISPATCH_QUEUE_CONCURRENT);
    //线程分为同步与异步
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
//    dispatch_sync(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
    
    
    /* 当前是串行队列，当执行到 dispatch_sync 时，因为是同步操作，所以 dispatch_sync 需要等待 block 执行完之后才能向下执行;当执行 NSLog(@"222"),的时候会加入到主线程中，但是这个时候主现程正是 dispatch_sync 在执行，所以 block 的 NSLog(@"222") 需要等待 dispatch_sync 执行完之后才能向下执行。这样就你等我，我等你，造成了死锁---必蹦
     */
//    NSLog(@"111");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"222");
//    });
//    NSLog(@"3333");
    
    //首先建立了一个串行的自定义队列，执行任务1后，遇到异步线程dispatch_async，不会等待执行任务2便会往下走，从而执行任务5，网上说的 5 2 顺序不确定，但是我用模拟器及真机测试发现任务5确实在任务2之前执行。执行任务2之后，遇到了同步线程dispatch_sync，需要等待任务3执行完才能继续往下走，但此时任务3也串行队列中，而此时的串行队列正被 dispatch_sync 占用着，这样就你等我，我等你，造成了死锁

    
}

/**
 Seamphore 当value <= 0时一直等待  当>0时会执行并且信号量会减一
 */
- (void)GCD_Seamphone {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [self requestC];
    });
    dispatch_group_async(group, queue, ^{
        [self requestB];
    });
    dispatch_group_async(group, queue, ^{
        [self requestA];
    });
    dispatch_group_notify(group, queue, ^{
       NSLog(@"Game Over");
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)requestA {
    NSLog(@"start -requestA");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/designer/alphabetical" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(sema);
        NSLog(@"%@",error);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}
- (void)requestB {
    NSLog(@"start -requestB");
    dispatch_semaphore_t sema =  dispatch_semaphore_create(0);
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/product/list?k=w" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}
- (void)requestC {
    NSLog(@"start -requestC");
    dispatch_semaphore_t sema =  dispatch_semaphore_create(0);
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/product/list?k=o" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}
@end
