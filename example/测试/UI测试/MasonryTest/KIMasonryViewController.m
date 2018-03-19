//
//  KIMasonryViewController.m
//  example
//
//  Created by d2c_cyf on 2018/3/19.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KIMasonryViewController.h"

@interface KIMasonryViewController ()

@end

@implementation KIMasonryViewController {
    UIView *_animationView;
    UIButton *_cancelBtn;
    UIButton *_confirmBtn;
    UIButton *_confirmBtn2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    _animationView = [[UIView alloc] init];
    _animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animationView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"重置" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(clickCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setTitle:@"1.动画" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    _confirmBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn2 setTitle:@"2.动画" forState:UIControlStateNormal];
    [_confirmBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_confirmBtn2 addTarget:self action:@selector(clickConfirmBtn2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn2];
    
    [_animationView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = 100;
        make.height.offset = 100;
        make.left.offset = 50;
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = 100;
        make.height.offset = 30;
        make.centerX.equalTo(self.view.mas_centerX).offset = -(375 / 2.0 - 100) ;
        make.bottom.equalTo(self.view.mas_bottom).offset   = -50;
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = 100;
        make.height.offset = 30;
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset   = -50;
    }];
    
    [_confirmBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = 100;
        make.height.offset = 30;
        make.centerX.equalTo(self.view.mas_centerX).offset = (375 / 2.0 - 100) ;
        make.bottom.equalTo(self.view.mas_bottom).offset   = -50;
    }];
}

- (void)clickCancleBtn:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        _animationView.layer.cornerRadius = 0;

        [_animationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 100;
            make.height.offset = 100;
            make.left.offset = 50;
            make.centerY.equalTo(self.view.mas_centerY);
        }];
        [self.view layoutIfNeeded];
    }];

}
- (void)clickConfirmBtn:(UIButton *)btn {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        _animationView.layer.cornerRadius = 50.0;
        
        [_animationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 100;
            make.height.offset = 100;
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)clickConfirmBtn2:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        _animationView.layer.cornerRadius = 0;
        [_animationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 100;
            make.height.offset = 168;
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
        [self.view layoutIfNeeded];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
