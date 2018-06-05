//
//  KISignal_VC.m
//  example
//
//  Created by 陈雁锋 on 2018/5/23.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KISignal_VC.h"
#import "GGCrashManager.h"

@implementation KISignal_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [GGCrashManager exit];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self arrayOrDicCrashTest];
}

//字典或者数组崩溃
- (void)arrayOrDicCrashTest {
    NSArray *array = @[@(0),@(1),@(2),@(3),@(4)];
    [array objectAtIndex:15];

}
@end
