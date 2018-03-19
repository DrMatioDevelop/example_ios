//
//  KINSTestViewController.m
//  example
//
//  Created by d2c_cyf on 2018/2/27.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KINSTestViewController.h"

//参考链接  http://www.cocoachina.com/ios/20161025/17303.html
@interface KINSTestViewController ()
@end

@implementation KINSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    KIWeakStrongVC *vc = [[KIWeakStrongVC alloc] init];
    vc.block();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


@implementation KIWeakStrongVC
- (void)dealloc {
    NSLog(@"%s",__func__);
}


/**
 weakSelf   为弱引用当释放之后 就为nil
 strongSelf 在变量的作用域结束之前防止weakSelf被释放

 @return <#return value description#>
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) weakSelf = self;
        self.block = ^{
//            __strong typeof(weakSelf) strongSelf = weakSelf;

            dispatch_async(dispatch_get_global_queue(0, 0), ^{

                [NSThread sleepForTimeInterval:1];
                NSLog(@"weakSelf:%@",weakSelf);
//                NSLog(@"strongSelf:%@",strongSelf);
            });
        };
    }
    return self;
}

@end
