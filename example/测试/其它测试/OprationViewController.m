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
@property (nonatomic, strong)NSOperationQueue *operationQueue;
@property (nonatomic, strong)UIView           *animationView;
@end

@implementation OprationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.animationView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"添加任务" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 64, 100, 50);
    [self.view bringSubviewToFront:button];
    [button addTarget:self action:@selector(addOperation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"开始任务" forState:UIControlStateNormal];
    button1.frame = CGRectMake(200, 64, 100, 50);
    [self.view bringSubviewToFront:button1];
    [button1 addTarget:self action:@selector(startOperation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}


- (void)addOperation:(UIButton *)button {
    static int index = 0;
    index++;
    NSLog(@"调用添加任务:%d",index);
    
//    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"\n");
//        NSLog(@"添加第：%d 个任务",index);
//        NSLog(@"共-----------------------：%ld 个任务\n",self.operationQueue.operationCount);
//        [self myAnimation:index];
//    }];
//    [self.operationQueue addOperation:operation];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"\n");
        NSLog(@"添加第：%d 个任务",index);
        NSLog(@"共-----------------------：%ld 个任务\n",self.operationQueue.operationCount);
        [self myAnimation:index];
    }];
    
}
- (void)startOperation:(UIButton *)button {
}

- (void)myAnimation:(int)index {
    [UIView animateWithDuration:3 animations:^{
        self.animationView.transform = CGAffineTransformTranslate(self.animationView.transform, 100, 0);
    } completion:^(BOOL finished) {
        NSLog(@"完成第：%d个任务\n",index);
        self.animationView.transform = CGAffineTransformIdentity;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
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
