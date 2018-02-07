//
//  BreakPoint_ViewController.m
//  example
//
//  Created by d2c_cyf on 2018/2/6.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "BreakPoint_ViewController.h"

@interface BreakPoint_ViewController ()

@end

@implementation BreakPoint_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableArray *muarray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 30; i++) {
        [muarray addObject:[NSString stringWithFormat:@"%C",(unichar)(i+65)]];
    }
    
    
    //condition [str containsString:@"F"]  /回到F的地方停下来
    for (NSString *str in muarray) {
        NSLog(@"%@",str);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
