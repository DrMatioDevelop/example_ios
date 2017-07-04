//
//  ObjectC_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ObjectC_ViewController.h"

@interface ObjectC_ViewController ()
@property(strong,nonatomic)UITableView    *objectTabView;
@property(strong,nonatomic)NSArray        *muarray;
@end

@implementation ObjectC_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.muarray = @[
                     @{@"name":@"GCD",@"class":@"GCD_ViewController"},

                     @{@"name":@"杂",@"class":@"ObjectCOther_ViewController"},
                     ];
    [self.objectTabView reloadData];
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class clas = NSClassFromString([[self.muarray objectAtIndex:indexPath.row] objectForKey:@"class"]);
    [self.navigationController pushViewController:[[clas alloc] init] animated:YES];
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
