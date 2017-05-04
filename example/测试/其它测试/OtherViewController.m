//
//  OtherViewController.m
//  example
//
//  Created by d2c_cyf on 16/12/20.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "OtherViewController.h"
@interface OtherViewController ()
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
                     @"项目列表测试",
                     @"玻璃效果,虚化(GPUImage)",
                     @"UI测试",
                     @"SharpLayer Bezier",
                     @"瀑布流"
                     ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
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
    else if ([self.arrayDS[indexPath.row] isEqualToString:@"玻璃效果,虚化(GPUImage)"]) {
        Class cla = NSClassFromString(@"GPU_ViewController");
        [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
    }
    else if ([self.arrayDS[indexPath.row] isEqualToString:@"UI测试"]) {
        Class cla = NSClassFromString(@"UI_ViewController");
        [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
    }
    else if ([self.arrayDS[indexPath.row] isEqualToString:@"SharpLayer Bezier"]) {
        Class cla = NSClassFromString(@"Layer_ViewController");
        [self.navigationController pushViewController:[[cla alloc] init] animated:YES];

    }
    else if ([self.arrayDS[indexPath.row] isEqualToString:@"瀑布流"]) {
        Class cla = NSClassFromString(@"Collection_ViewController");
        [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
        
    }}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
