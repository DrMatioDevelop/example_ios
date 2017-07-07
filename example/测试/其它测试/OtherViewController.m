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
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    self.arrayDS = @[
                     @{@"index":@"0",@"name":@"列表视图"                ,@"class":@"TableVIew_ViewController"},
                     @{@"index":@"1",@"name":@"正则表达式与代码片段显示"   ,@"class":@"RegurOrHtmlViewController"},
                     @{@"index":@"1",@"name":@"项目列表测试"            ,@"class":@"OtherViewController"},
                     @{@"index":@"1",@"name":@"玻璃效果,虚化(GPUImage)" ,@"class":@"GPU_ViewController"},
                     @{@"index":@"1",@"name":@"UI测试"                 ,@"class":@"UI_ViewController"},
                     @{@"index":@"1",@"name":@"SharpLayer Bezier"     ,@"class":@"Layer_ViewController"},
                     @{@"index":@"1",@"name":@"瀑布流"                 ,@"class":@"Collection_ViewController"},
                     @{@"index":@"1",@"name":@"图片显示"                ,@"class":@"IMG_ViewController"},
                     @{@"index":@"1",@"name":@"多线程"                 ,@"class":@"OprationViewController"},
                     @{@"index":@"1",@"name":@"人脸识别"               ,@"class":@"TableVIew_ViewController"},
                     @{@"index":@"1",@"name":@"滚动边缘动画"            ,@"class":@"ScrollviewAnimationVC"},
                     @{@"index":@"1",@"name":@"转场动画"               ,@"class":@"Transition_ViewController"},
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
    cell.textLabel.text = [self.arrayDS[indexPath.row] objectForKey:@"name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([[self.arrayDS[indexPath.row] objectForKey:@"index"] isEqualToString:@"0"]) {
        cell.backgroundColor = [UIColor redColor];
    }
    else if ([[self.arrayDS[indexPath.row] objectForKey:@"index"] isEqualToString:@"1"]) {
        cell.backgroundColor = [UIColor cyanColor];
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self.arrayDS[indexPath.row] objectForKey:@"class"];
    Class cla = NSClassFromString(className);
    UIViewController *vc = [[cla alloc] init];
    vc.title = [self.arrayDS[indexPath.row] objectForKey:@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}




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
