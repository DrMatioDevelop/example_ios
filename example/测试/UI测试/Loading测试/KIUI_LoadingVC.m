//
//  KIUI_LoadingVC.m
//  example
//
//  Created by 陈雁锋 on 2019/6/11.
//  Copyright © 2019 d2c_cyf. All rights reserved.
//

#import "KIUI_LoadingVC.h"

@interface KIUI_LoadingVC ()<UITextViewDelegate>

@end

@implementation KIUI_LoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, 100, 68);
    [btn setTitle:@"全部取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ckiclAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 400, 100, 68);
    [btn1 setTitle:@"不全部取消" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(ckiclHalf:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(200, 200, 100, 68)];
    textView.placeholder = @"键盘隐藏设置";
    textView.delegate = self;
    textView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textView];
    
    NSLog(@"--%@",[UIApplication sharedApplication].windows);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
}


#pragma mark - keyboard测试
- (void)keyBoardShow:(NSNotification *)notifacation {
    NSLog(@"++%@",[UIApplication sharedApplication].windows);
    UIWindow *temp = [[UIApplication sharedApplication].windows lastObject];
    temp.hidden = YES;
    temp.alpha = 0;
}

#pragma mark - HUD
//不全部取消
- (void)ckiclHalf:(UIButton *)btn {
    //显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------1");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------2");
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------3");
    });
    
    //隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] stopLoadingAnimation];
        
        //取消
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[FSLoadingHUD shareInstance] stopAllLoadingAnimation];
        });
    });
    

}

//全部取消
- (void)ckiclAll:(UIButton *)btn {
    //显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------1");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------2");

    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------3");
    });
    
    //隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] stopAllLoadingAnimation];
    });
}


//逐个取消
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------1");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------2");
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] showAnimationWhenLoadingWith:nil];
        NSLog(@"----------3");
    });

    //隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[FSLoadingHUD shareInstance] stopLoadingAnimation];
        [[FSLoadingHUD shareInstance] stopLoadingAnimation];
        [[FSLoadingHUD shareInstance] stopLoadingAnimation];
    });
}

@end
