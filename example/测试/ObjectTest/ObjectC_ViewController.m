//
//  ObjectC_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ObjectC_ViewController.h"
#import "ObjectCOther_ViewController.h"

@interface ObjectC_ViewController ()
@property(strong,nonatomic)UITableView    *objectTabView;
@property(strong,nonatomic)NSArray        *muarray;
@end

@implementation ObjectC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.muarray = @[
                     @{@"q":@"1",@"name":@"GCD",@"class":@"GCD_ViewController"},
                     @{@"q":@"0",@"name":@"轻量级热更新",@"class":@"HotFix_ViewController"},
                     @{@"q":@"1",@"name":@"杂",@"class":@"ObjectCOther_ViewController"},
                     @{@"q":@"1",@"name":@"断点测试",@"class":@"BreakPoint_ViewController"},
                     @{@"q":@"0",@"name":@"weakSelf Strongify",@"class":@"KINSTestViewController"},
                     @{@"q":@"0",@"name":@"崩溃信号处理",@"class":@"KISignal_VC"},

                     ];
    [self.objectTabView reloadData];
    
    ObjectCOther_ViewController *vc = [[ObjectCOther_ViewController alloc] init];
    NSLog(@"%d   %d",vc.otherNameFlag, vc.isOtherNameFlag);
    NSLog(@"%@",testChangLiangNotification);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.muarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"objectCell"];
    cell.textLabel.text = [[self.muarray objectAtIndex:indexPath.row] objectForKey:@"name"];
    if ([[[self.muarray objectAtIndex:indexPath.row] objectForKey:@"q"] isEqualToString:@"1"]) {
        cell.backgroundColor = [UIColor cyanColor];
    }
    else {
        cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class clas = NSClassFromString([[self.muarray objectAtIndex:indexPath.row] objectForKey:@"class"]);
    UIViewController *vc = [[clas alloc] init];
    vc.title = [[self.muarray objectAtIndex:indexPath.row] objectForKey:@"name"];
    [self DJPushViewController:vc animated:YES];
}
- (UITableView *)objectTabView {
    if (!_objectTabView) {
        _objectTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SSize.width, SSize.height- 64) style:UITableViewStylePlain];
        _objectTabView.delegate   = self;
        _objectTabView.dataSource = self;
        [_objectTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"objectCell"];
        [self.view addSubview:_objectTabView];
    }
    return _objectTabView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
