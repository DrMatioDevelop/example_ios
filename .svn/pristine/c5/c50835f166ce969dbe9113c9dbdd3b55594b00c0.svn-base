//
//  OtherViewController.m
//  example
//
//  Created by d2c_cyf on 16/12/20.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "OtherViewController.h"
#import "ESLiveSearchProductView.h"
#import "ESLiveProductCollectionView.h"
#import "ESLiveProductView.h"
@interface OtherViewController ()
@property(nonatomic, strong)ESLiveSearchProductView *myView;
@property(nonatomic, strong)ESLiveProductView       *owerView;
@property(nonatomic, strong)UIButton                *button;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self predicateTest];
//    [self zhengze];
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(38, 64, 100, 61);
    [_button addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
    _button.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.618];
    [self.view addSubview:_button];
//
//    [self.view addSubview:self.myView];
//    [self.myView setLiveSearchList:@""];
//    
//    __weak typeof(self) weakSelf = self;
//    self.myView.liveSearchProductBlock = ^(){
//        weakSelf.myView.isShow = NO;
//        [UIView animateWithDuration:0.3 animations:^{
//            weakSelf.myView.transform = CGAffineTransformIdentity;
//        }];
//    };
    
    [self.view addSubview:self.owerView];
    [self.owerView loadLiveProductListWithModel:@""];
    __weak typeof(self) weakSelf = self;
    self.owerView.liveProductCloseBlock = ^(){
        weakSelf.owerView.isShow = NO;

        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.owerView.transform = CGAffineTransformIdentity;

        }];
    };
}

- (void)clickBtn1:(UIButton *)button {
//    if (self.myView.isShow) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.myView.transform = CGAffineTransformIdentity;
//        }];
//    }
//    else {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.myView.transform = CGAffineTransformTranslate(self.myView.transform, -SSize.width, 0);
//        }];
//    }
//    self.myView.isShow = !self.myView.isShow;
    
    if (self.owerView.isShow) {
        [UIView animateWithDuration:0.3 animations:^{
            self.owerView.transform = CGAffineTransformIdentity;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.owerView.transform = CGAffineTransformTranslate(self.owerView.transform, 0, -SSize.height);
        }];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
#pragma mark - 正则表达式
- (void)zhengze {
    NSString *searchText = @"123rangeOfString";
    NSRange range = [searchText rangeOfString:@"^[0-9]+$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSLog(@"range ：%@", [searchText substringWithRange:range]);
    }
    [@"" compare:@""];
}
#pragma mark - NSPredicate
- (void)predicateTest {
//    NSArray *array1 = [NSArray arrayWithObjects:@1,@2,@3,@4,@5,@5,@6,@7, nil];
//    NSArray *array2 = [NSArray arrayWithObjects:@3,@5, nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"shanghai",@"guangzhou",@"wuhan",@"jinan",@"anhui", nil];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"self  like [c] 'an*'"];
    NSArray *temp1 = [array3 filteredArrayUsingPredicate:predicate1];
    NSLog(@"%@, %@",predicate1,temp1);
    // >, ==,  !=, like, contains, beginswith , endswith
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ESLiveSearchProductView *)myView {
    if (!_myView) {
        _myView = [[ESLiveSearchProductView alloc] initWithFrame:CGRectMake(SSize.width, 0, SSize.width, SSize.height)];
    }
    return _myView;
}

- (ESLiveProductView *)owerView {
    if (!_owerView) {
        _owerView = [[ESLiveProductView alloc] initWithFrame:CGRectMake(0, SSize.height, SSize.width, SSize.height)];
    }
    return _owerView;
}
@end
