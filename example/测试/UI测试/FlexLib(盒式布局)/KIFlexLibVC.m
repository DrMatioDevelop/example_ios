//
//  KIFlexLibVC.m
//  example
//
//  Created by 陈雁锋 on 2018/6/11.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KIFlexLibVC.h"

@interface KIFlexLibVC ()
@property(nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic, strong)UIView       *imgParentView;
@end
@implementation KIFlexLibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)removeCell:(UITapGestureRecognizer *)tap {
    [self presentViewController:[UIViewController new] animated:YES completion:^{
        
    }];
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}
- (UIView *)imgParentView {
    if (!_imgParentView) {
        _imgParentView = [[UIView alloc] init];
        [self.view addSubview:_imgParentView];
    }
    return _imgParentView;
}
@end
