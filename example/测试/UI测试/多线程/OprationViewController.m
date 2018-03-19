//
//  OprationViewController.m
//  example
//
//  Created by d2c_cyf on 17/2/20.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//


/**
 NSOperationQueue 通过设置max-xxx属性可以实现串行  但是不能动态的添加一个线程到queue里面；  如queue里面目前有两个opreation
 并且是在执行的状态   这两个设置max-xx属性是串行的 如果继续添加新加的一个会变成并行

 阻塞suspended 并不会使queue里面的operation一个一个的执行
 下面的测试代码说明问题
 */
#import "OprationViewController.h"

@interface OprationViewController ()
@property (nonatomic, strong)NSOperationQueue *operationQueueRequest;
@property (nonatomic, strong)NSOperationQueue *operationQueue;
@property (nonatomic, strong)UIView           *animationView;
@end

@implementation OprationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"开始执行" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 64, 100, 50);
    [self.view bringSubviewToFront:button];
    [button addTarget:self action:@selector(beginTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//
//    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
//    button1.backgroundColor = [UIColor redColor];
//    [button1 setTitle:@"开始任务" forState:UIControlStateNormal];
//    button1.frame = CGRectMake(200, 64, 100, 50);
//    [self.view bringSubviewToFront:button1];
//    [button1 addTarget:self action:@selector(startOperation:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button1];
    
    
//    [self operationSerial];
}
#pragma mark - Click
- (void)beginTask:(UIButton *)button {
    //按照顺序完成(1,2,3)task 使用NSOperation的暂停功能与 GCD的信号都是可以的
    //如果不使用只是在调用的时候会是按照依赖的顺序  但是执行的时候还是并发执行
    //suspend 暂停只会暂定队列 不会暂停当前的task，只是简单的阻止调用显得operation（可以继续加入 减少？）
    //semaphone 信号量 当不为<=0的时候会一直等待   当信号量 > 0时会执行  并且会让信号量减1
    
    
    //所有的任务都完成后  再出发新的任务
//    [self GCD_allFinish];
    
//    //一个任务完成之后再完成另一个任务
    [self operationSerial];
}
#pragma mark - GCD
- (void)GCD_allFinish {
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
        NSLog(@"good game");
    });
}
#pragma mark - NSOperation
- (void)operationSerial {
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        [self operaRequestC];
    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        [self operaRequestB];
    }];
    
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        [self operaRequestA];
    }];
    
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    [self.operationQueueRequest addOperations:@[operationC, operationB, operationA] waitUntilFinished:NO];
}

#pragma mark - GCD  Request
- (void)requestA {
    NSLog(@"1");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    //    [self.operationQueue setSuspended:YES];
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/designer/alphabetical" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

- (void)requestB {
    NSLog(@"2");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //    [self.operationQueue setSuspended:YES];
    
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
    NSLog(@"3");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //    [self.operationQueue setSuspended:YES];
    
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/product/list?k=o" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        
        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        dispatch_semaphore_signal(sema);
        
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}
#pragma mark - NSOperation Request
//按照顺序完成(1,2,3)task 使用NSOperation的暂停功能与 GCD的信号都是可以的
//如果不使用只是在调用的时候会是按照依赖的顺序  但是执行的时候还是并发执行
//suspend 暂停只会暂定队列 不会暂停当天的task，只是简单的阻止调用显得operation（可以继续加入 减少？）
//semaphone 信号量 当不为<=0的时候会一直等待   当信号量 > 0时会执行  并且会让信号量减1
- (void)operaRequestA {
    NSLog(@"1");
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);  //创建信号量
    
        [self.operationQueueRequest setSuspended:YES];
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/product/list?k=li" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        [self.operationQueueRequest setSuspended:NO];
        
//        dispatch_semaphore_signal(sema);                       //提高信号量
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
//        dispatch_semaphore_signal(sema);                       //提高信号量
        [self.operationQueueRequest setSuspended:NO];
    }];
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);      //等待降低信号量
    
}

- (void)operaRequestB {
    NSLog(@"2");
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self.operationQueueRequest setSuspended:YES];
    
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/product/list?k=w" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        [self.operationQueueRequest setSuspended:NO];
        
//        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.operationQueueRequest setSuspended:NO];
        
//        dispatch_semaphore_signal(sema);
        
    }];
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

- (void)operaRequestC {
    NSLog(@"3");
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self.operationQueueRequest setSuspended:YES];
    
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://appserver.d2cmall.com/v2/api/product/list?k=o" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        [self.operationQueueRequest setSuspended:NO];
        
//        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.operationQueueRequest setSuspended:NO];
        
//        dispatch_semaphore_signal(sema);
    }];
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

#pragma mark - Getter
- (void)myAnimation:(int)index {
    [UIView animateWithDuration:3 animations:^{
        self.animationView.transform = CGAffineTransformTranslate(self.animationView.transform, 100, 0);
    } completion:^(BOOL finished) {
        NSLog(@"完成第：%d个任务\n",index);
        self.animationView.transform = CGAffineTransformIdentity;
    }];
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

- (NSOperationQueue *)operationQueueRequest {
    if (!_operationQueueRequest) {
        _operationQueueRequest = [[NSOperationQueue alloc] init];
    }
    return _operationQueueRequest;
}
- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 100, 50)];
        _animationView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:_animationView];
    }
    return _animationView;
}
@end
