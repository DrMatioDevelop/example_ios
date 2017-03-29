//
//  Layer_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/3/29.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Layer_ViewController.h"

@interface Layer_ViewController ()

@end

@implementation Layer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self baseLayer];
}

- (void)baseLayer {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(50, 70, 50, 36);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 110, 50, 50) cornerRadius:25.0];
    CAShapeLayer *zfx_layer = [[CAShapeLayer alloc] init];
    zfx_layer.path = bezierPath.CGPath;
    zfx_layer.strokeColor = [UIColor redColor].CGColor;
    zfx_layer.fillColor   = [UIColor whiteColor].CGColor;
    zfx_layer.borderWidth = 5;
    [self.view.layer addSublayer:zfx_layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}

@end
