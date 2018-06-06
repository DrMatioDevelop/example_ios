//
//  Swift_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Swift_ViewController.h"
//#import "
@interface Swift_ViewController ()
@property(nonatomic, strong)NSArray *currentArray;
@property(nonatomic, strong)NSArray *cCopyArray;
@end

@implementation Swift_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    _currentArray = @[@"1",@"test",@(666)];
    
    NSMutableArray *muarray = [[NSMutableArray alloc] initWithArray:_currentArray];
    
    NSMutableArray *copyArray = [muarray mutableCopy];
    
    [copyArray removeLastObject];

    
    [self.tabBarController.tabBar setHidden:YES];
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
