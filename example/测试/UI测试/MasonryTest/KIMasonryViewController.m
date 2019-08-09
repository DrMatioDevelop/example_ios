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
    UIStackView *_stackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self UIStackViewTest];
   
}


- (void)masonryTest {
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
        make.bottom.equalTo(self.view.mas_bottom).offset   = -100;
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = 100;
        make.height.offset = 30;
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset   = -100;
    }];
    
    [_confirmBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = 100;
        make.height.offset = 30;
        make.centerX.equalTo(self.view.mas_centerX).offset = (375 / 2.0 - 100) ;
        make.bottom.equalTo(self.view.mas_bottom).offset   = -100;
    }];
}

- (void)UIStackViewTest {
    //如果只是单纯的视图 宽度会被缩小为0，所以测试时使用UILable进行测试
    //@available 大于等于当前版本
    if (@available(iOS 9.0, *)) {
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 150, SSize.width - 30, 180)];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor lightGrayColor];
        
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionEqualCentering;
        _stackView.spacing = 8;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.frame = CGRectMake(0, 0, SSize.width - 30, 180);
        [view addSubview:_stackView];

        
//        UIView *v1 = [[UIView alloc] init];
//        v1.backgroundColor = [UIColor redColor];
////        v1.frame = CGRectMake(10, 30, 50, 50);
//
////        UIView *v2 = [[UIView alloc] init];
////        v2.backgroundColor = [UIColor purpleColor];
////        v2.frame = CGRectMake(10, 30, 50, 50);
//
//        UIView *v3 = [[UIView alloc] init];
//        v3.backgroundColor = [UIColor blueColor];
////        v3.frame = CGRectMake(10, 30, 50, 50);
//
//        [_stackView addArrangedSubview:v1];
////        [stackView addArrangedSubview:v2];
//        [_stackView addArrangedSubview:v3];
//        [_stackView layoutIfNeeded];

        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setBackgroundColor:[UIColor greenColor]];
        [addBtn setTitle:@"增加一个" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(100, 400, 100, 50);
        [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addBtn];
        
        UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [removeBtn setBackgroundColor:[UIColor redColor]];
        [removeBtn setTitle:@"减少一个" forState:UIControlStateNormal];
        [removeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        removeBtn.frame = CGRectMake(240, 400, 100, 50);
        [removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:removeBtn];
    }
}

- (void)addClick {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
    NSString *str = [NSString stringWithFormat:@"视图%u", arc4random() % 100];
    for (int i = 0; i < random() % 2; i++) {
        str = [str stringByAppendingString:str];
    }
    label.text = str;
    [_stackView addArrangedSubview:label];
    [UIView animateWithDuration:1.0
                     animations:^{
                         [_stackView layoutIfNeeded];
                     }];
    NSLog(@"---%lu", (unsigned long)_stackView.subviews.count);

    //    NSLog(@"添加之前 : %zd",_stackView.subviews.count);
    //    UILabel *label = [[UILabel alloc] init];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    NSString *str = [NSString stringWithFormat:@"视图%ld",(long)index];
    //    for (int i = 0; i < random() % 2; i ++) {
    //        str = [str stringByAppendingString:str];
    //    }
    //    label.text = str;
    //    label.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
    //    [_stackView addArrangedSubview:label];
    //    [UIView animateWithDuration:1.0 animations:^{
    //        [_stackView layoutIfNeeded];
    //    }];
    //
    //    NSLog(@"添加之后 : %zd",_stackView.subviews.count);

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
    [UIView animateWithDuration:10 animations:^{
//        _animationView.layer.cornerRadius = 50.0;
        
        [_animationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset = 100;
            make.height.offset = 100;
//            make.centerX.equalTo(self.view.mas_centerX);
//            make.centerY.equalTo(self.view.mas_centerY);
            make.left.offset = 200;
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
