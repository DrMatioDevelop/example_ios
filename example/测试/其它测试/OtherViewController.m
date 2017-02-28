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

@property(nonatomic, strong)UITableView             *tableView;
@property(nonatomic, strong)NSArray                 *arrayDS;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor yellowColor];

    [self.view addSubview:self.tableView];
    self.arrayDS = @[
                     @"正则表达式与代码片段显示",
                     @"项目列表测试"
                     ];
    
    
    
//    [self predicateTest];
//    [self zhengze];

    
    
    
//    _button = [UIButton buttonWithType:UIButtonTypeSystem];
//    _button.frame = CGRectMake(38, 64, 100, 61);
//    [_button addTarget:self action:@selector(clickBtn1:) forControlEvents:UIControlEventTouchUpInside];
//    _button.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.618];
//    [self.view addSubview:_button];
//
//    [self.view addSubview:self.owerView];
//    [self.owerView loadLiveProductListWithModel:@""];
//    __weak typeof(self) weakSelf = self;
//    self.owerView.liveProductCloseBlock = ^(){
//        weakSelf.owerView.isShow = NO;
//
//        [UIView animateWithDuration:0.3 animations:^{
//            weakSelf.owerView.transform = CGAffineTransformIdentity;
//
//        }];
//    };
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayDS.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.arrayDS[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.arrayDS[indexPath.row] isEqualToString:@"正则表达式与代码片段显示"]) {
        Class cla = NSClassFromString(@"RegurOrHtmlViewController");
        [self.navigationController pushViewController:[[cla alloc] init] animated:YES];

    }
    else if ([self.arrayDS[indexPath.row] isEqualToString:@"项目列表测试"]) {
        Class cla = NSClassFromString(@"OtherViewController");
        [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
    }
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
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SSize.width, SSize.height - 64.0) style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
@end
