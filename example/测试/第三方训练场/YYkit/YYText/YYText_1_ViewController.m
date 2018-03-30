//
//  YYText_1_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/2/14.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "YYText_1_ViewController.h"

@interface YYText_1_ViewController ()<NSCoding>
@property(nonatomic,assign)NSInteger a;
@end

@implementation YYText_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"d2c" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBar:)];
    _a = 100;
    // Do any additional setup after loading the view.

}


- (void)clickLeftBar:(UIBarButtonItem *)barItem {
    NSLog(@"cyf");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
