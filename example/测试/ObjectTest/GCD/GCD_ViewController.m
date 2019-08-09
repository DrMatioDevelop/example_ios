//
//  GCD_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "GCD_ViewController.h"
#pragma mark - dispatch_group_async_f  dispatch_group_notify_f
//定义C方法
//任务1
void showString4Task1(void *obj) {
    sleep(3);
    NSLog(@"异步调度组任务1:%@ 是否在主线程:%@ 线程:%@", (__bridge NSString *)obj, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}
//任务2
void showString4Task2(void *obj) {
    sleep(3);
    NSLog(@"异步调度组任务2:%@ 是否在主线程:%@ 线程:%@", (__bridge NSString *)obj, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}

//任务3
void showString4Task3(void *obj) {
    sleep(3);
    NSLog(@"异步调度组任务3:%@ 是否在主线程:%@ 线程:%@", (__bridge NSString *)obj, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}

//完成
void allTaskNofify(void *obj) {
    NSLog(@"分组任务添加完毕 是否在主线程:%@ 线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}

@interface GCD_ViewController ()

@end

@implementation GCD_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [KIUIContainerControl getButton:CGRectMake(0, 100, 100, 50) title:@"开始执行" tag:0 target:self action:@selector(beginTask:)];
    [self.view addSubview:button];

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 100, 0.1)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];

    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 220, 100, 0.2)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];

    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(10, 240, 100, 0.3)];
    view3.backgroundColor = [UIColor redColor];
    [self.view addSubview:view3];

    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(10, 260, 100, 0.5)];
    view5.backgroundColor = [UIColor redColor];
    [self.view addSubview:view5];

    UIView *view10 = [[UIView alloc] initWithFrame:CGRectMake(10, 280, 100, 1)];
    view10.backgroundColor = [UIColor redColor];
    [self.view addSubview:view10];

    [self gcdTest];
}

#pragma mark - 2019.05GCD测试
//参考(http://www.chuliangliang.com/2017/05/02/iOS-GCD-Grand-Central-Dispatch-3/)
/**
 Synchronous同步、Asynchronouse异步
 sync:完成了预定的任务后才返回，在任务执行期间会阻塞主线程
 async:任务完成不会等待完成，异步函数不会阻塞当前线程
 */

- (void)gcdTest {
    //    [self asyncConcurrent];

    //    [self asyncSerial];

    //    [self syncConcurrent];

    //    [self syncSerial];

    //    [self asyncMain];

    //    [self syncMain];

    //    [self autoGroup];

    //    [self manualGroup];

    //    [self dispatchGroup];

    //    [self dispatchGroupWait];

    //    [self dispatch_apply];

    [self suspendResume];
}
#pragma mark - 队列操作
/**
 调用dispatch_suspend会增加queue的引用计数 与 调用dispatch_Resume会减少queue的引用计数。当queue的引用计数大于0时仍然会挂起；
 dispatch_suspend可以挂起队列，已经开始的任务不会挂起；
 需要异步 串行队列中才可实现想要的效果
 */
- (void)suspendResume {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_SERIAL);
    for (NSInteger i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            NSLog(@"开始任务%ld 是否在主线程:%@ 线程:%@", (long)i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
            sleep(3);
            NSLog(@"结束任务%ld 是否在主线程:%@ 线程:%@", (long)i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
        });
    }

    NSLog(@"任务添加完成 是否在主线程:%@ 线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"队列延迟7秒挂起 是否主线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO");
        dispatch_suspend(queue);

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"队列延迟5秒解挂 是否主线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO");
            dispatch_resume(queue);
        });
    });
}

/**
 栅栏
 */
- (void)dispatch_barrier {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    for (NSInteger i = 0; i < 5; i++) {
        if (i == 2) {
            dispatch_barrier_async(queue, ^{
                NSLog(@"开始任务%ld 是否在主线程:%@ 线程:%@", (long)i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
                //使用GCD计时器代替sleep可以更明显看出
                __block int count_t = 0;
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
                dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
                int64_t interval = (int64_t)(0.5 * NSEC_PER_SEC);
                dispatch_source_set_timer(timer, start, interval, 0);
                dispatch_source_set_event_handler(timer, ^{
                    CGFloat p = count_t / 10.0;
                    p = p > 1 ? 1 : p;
                    if (p == 1) {
                        //取消定时器
                        dispatch_cancel(timer);
                        NSLog(@"任务%ld执行完成 是否在主线程:%@ 线程:%@", (long)i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
                    }
                    count_t++;
                });
                dispatch_resume(timer);
            });
        } else {
            dispatch_async(queue, ^{
                NSLog(@"开始任务%ld 是否在主线程:%@ 线程:%@", (long)i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
                sleep(3);
                NSLog(@"结束任务%ld 是否在主线程:%@ 线程:%@", (long)i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
            });
        }
    }

    NSLog(@"任务添加完成 是否在主线程:%@ 线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}

#pragma mark - 线程组合

/**
 1.自动调度组
 DISPATCH_QUEUE_CONCURRENT顺序不一定是1.2.3.4.5 因为在并发队列中进行，如果在串行队列中则会按照加入顺序执行;串行队列会阻塞当前线程
 */
- (void)autoGroup {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    //调度组
    dispatch_group_t group = dispatch_group_create();

    for (NSInteger i = 0; i < 5; i++) {
        dispatch_group_async(group, concurrentQueue, ^{
            sleep(3);
            NSLog(@"任务%ld 是否在主线程:%@ 线程:%@", i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
        });
    }

    dispatch_group_notify(group, concurrentQueue, ^{
        NSLog(@"任务结束 是否在主线程:%@  线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
    });

    NSLog(@"任务分配结束 是否在主线程:%@  线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}

/**
 2.手动调度组
 DISPATCH_QUEUE_CONCURRENT顺序不一定是1.2.3.4.5 因为在并发队列中进行，如果在串行队列中则会按照加入顺序执行;串行队列会阻塞当前线程;
 dispatch_group_enter 与 dispatch_group_leave 配合使用
 */
- (void)manualGroup {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    for (NSInteger i = 0; i < 5; i++) {
        //进组
        dispatch_group_enter(group);
        //开启异步线程任务
        dispatch_async(queue, ^{
            sleep(3);
            NSLog(@"任务%ld 是否在主线程:%@ 线程:%@", i, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);

            //任务执行完毕出组
            dispatch_group_leave(group);
        });
    }

    dispatch_group_notify(group, queue, ^{
        NSLog(@"任务结束 是否在主线程:%@  线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
    });

    NSLog(@"任务分配结束 是否在主线程:%@  线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
}

//dispatch_group_async是dispatch_group_async_f的封装
- (void)dispatch_F_Group {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async_f(group, queue, @"我是参数", showString4Task1);
    dispatch_group_async_f(group, queue, @"你是🐷", showString4Task2);
    dispatch_group_async_f(group, queue, @"今天小龙虾", showString4Task3);
    dispatch_group_notify_f(group, queue, nil, allTaskNofify);
    NSLog(@"分组任务添加完毕 是否主线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO");
}

/**
 群组等待超时
 */
- (void)dispatchGroupWait {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async_f(group, queue, @"我是参数", showString4Task1);
    dispatch_group_async_f(group, queue, @"你是🐷", showString4Task2);
    dispatch_group_async_f(group, queue, @"今天小龙虾", showString4Task3);
    dispatch_group_notify_f(group, queue, nil, allTaskNofify);
    NSLog(@"分组任务添加完毕 是否主线程:%@", [NSThread currentThread].isMainThread ? @"YES" : @"NO");
    long ret = dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)));
    if (ret == 0) {
        NSLog(@"群组任务全部执行完成");
    } else {
        NSLog(@"群组任务全部执行失败|超时");
    }
}

/**
 提交一个block块到一个分发队列里，以供多次调用
 
 DISPATCH_QUEUE_CONCURRENT 不按照顺序执行,DISPATCH_QUEUE_SERIAL 按照顺序执行
 */
- (void)dispatch_apply {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(5, queue, ^(size_t index) {
        NSLog(@"任务%ld 是否在主线程:%@ 线程:%@", index, [NSThread currentThread].isMainThread ? @"YES" : @"NO", [NSThread currentThread]);
    });
}

#pragma mark - 简单线程
/**
 1.异步+并行
 
 异步：可开启新的线程，任务可以先绕过不执行回头再执行
 并行：任务之间不需要排队，执行顺序不定
 组合后结果：开辟三个新线程，三个任务同时执行不区分先后顺序
 */
- (void)asyncConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"--start--");

    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);

    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });

    NSLog(@"--end--");
}

/**
 2.异步+串行队列
 异步：可开启新的线程，任务可以先绕过不执行回头再执行
 串行：任务必须按照进入queue的顺序执行
 组合结果:开辟一个新的子线程，函数函数按照加入queue的顺序执行
 */
- (void)asyncSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_SERIAL);
    NSLog(@"--start--");

    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);

    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });

    NSLog(@"--end--");
}

/**
 3.同步+并行
 
 同步：不开启新线程，任务创建后必须执行完才能往下走
 并行：任务不必按照执行顺序执行
 组合结果：所有任务在主线程中执行，函数执行时不必按照执行顺序执行
 */
- (void)syncConcurrent {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"--start--");
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务4---%@", [NSThread currentThread]);

    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"--end--");
}

/**
 4.同步+串行
 同步：不开启新线程，任务创建后必须执行完才能往下走
 串行：任务必须按照进入queue的顺序执行
 组合结果：所有任务在主线程中执行，函数执行时按照加入queue的顺序进行执行
 */
- (void)syncSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.cyf", DISPATCH_QUEUE_SERIAL);
    NSLog(@"--start--");
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务4---%@", [NSThread currentThread]);

    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"--end--");
}

/**
 5.异步+主队列
 异步：可开启新的线程，任务可以先绕过不执行回头再执行
 主队列跟串行队列的区别：主队列在主线程中执行，不允许在子线程中执行
 组合结果：所有任务先跳过，再按顺序执行
 */
- (void)asyncMain {
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"--start--");
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务4---%@", [NSThread currentThread]);

    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"--end--");
}

/**
 6.同步+主队列
 同步：不开启新线程，任务创建后必须执行完才能往下走
 组合结果：同步执行任务会阻塞当前线程，待到block执行完成后再释放当前线程。主线程被阻塞，没有线程去执行blcok主线程永远不会被释放
 异步执行不会阻塞当前线程
 */
- (void)syncMain {
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"--start--");
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务4---%@", [NSThread currentThread]);

    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"--end--");
}

#pragma mark - 之前的测试
- (void)beginTask:(UIButton *)btn {
    [self GCD_Seamphone];

    //    [self gcd_test];
    //    NSLog(@"\n\n\n");
}

- (void)gcd_test {
    //队列分为串行与并行
    //串行
    dispatch_queue_t serialQueue = dispatch_queue_create("com.163.cyfsoftwareSerial", DISPATCH_QUEUE_SERIAL);
    //并行
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
 Seamphore 当value < 0时一直等待  当>0时会执行并且信号量会减一
 */
- (void)GCD_Seamphone {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //    //1⃣️队列异步执行 不使用信号量
    //    //异步并行发起 接收到任务完成的回调，只做到了并行发起，没有做到全部完成的回调。
    //    dispatch_group_async(group, queue, ^{
    //        [self requestC];
    //    });
    //    dispatch_group_async(group, queue, ^{
    //        [self requestB];
    //    });
    //    dispatch_group_async(group, queue, ^{
    //        [self requestA];
    //    });
    //    dispatch_group_notify(group, queue, ^{
    //        NSLog(@"Game Over");
    //    });

    //2⃣️队列异步执行 使用信号量 1⃣️与2⃣️相互对比
    //异步并行发起 接收到任务完成回调，使用信号量各个任务全部执行完成
    dispatch_group_async(group, queue, ^{
        [self requestC_sema];
    });
    dispatch_group_async(group, queue, ^{
        [self requestB_sema];
    });
    dispatch_group_async(group, queue, ^{
        [self requestA_sema];
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"Game Over");
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 测试网络请求 requestA不含有信号量，requestA_sema含有信号量
- (void)requestA {
    NSLog(@"start -requestA");
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v3/api/product/list?k=liwei" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"");
}
- (void)requestB {
    NSLog(@"start -requestB");
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v3/api/product/list?k=w" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"");
    
}
- (void)requestC {
    NSLog(@"start -requestC");
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v3/api/product/list?k=o" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    NSLog(@"");
}

- (void)requestA_sema {
    NSLog(@"start -requestA_sema");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v3/api/product/list?k=liwei" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(sema);
        NSLog(@"%@",error);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"");
}
- (void)requestB_sema {
    NSLog(@"start -requestB_sema");
    dispatch_semaphore_t sema =  dispatch_semaphore_create(0);
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v3/api/product/list?k=w" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"");
    
}
- (void)requestC_sema {
    NSLog(@"start -requestC_sema");
    dispatch_semaphore_t sema =  dispatch_semaphore_create(0);
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v3/api/product/list?k=o" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"");
}
@end
