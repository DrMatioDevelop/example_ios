//
//  Layer_Event_TestVC.m
//  example
//
//  Created by d2c_cyf on 17/4/6.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Layer_Event_TestVC.h"

@interface Layer_Event_TestVC ()
@property(nonatomic , strong)CAShapeLayer *redLayer;
@property(nonatomic , strong)CAShapeLayer *yellowLayer;
@end

@implementation Layer_Event_TestVC {
    CAShapeLayer *_clickLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIBezierPath *beizer_red = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 100) radius:12.5 startAngle:0 endAngle:M_PI * 1.5 clockwise:YES];
    self.redLayer = [CAShapeLayer layer];
    self.redLayer.path = beizer_red.CGPath;
//    self.redLayer.frame = CGRectMake(100, 100, 100, 100);
//    self.redLayer.backgroundColor = [UIColor redColor].CGColor;
    self.redLayer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.redLayer];
    
    
    self.yellowLayer = [CAShapeLayer layer];
    self.yellowLayer.frame = CGRectMake(100, 220, 100, 100);
    self.yellowLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:self.yellowLayer];
    
    
    
    UIBezierPath *bezier_yh = [[UIBezierPath alloc] init];
    [bezier_yh addArcWithCenter:CGPointMake(150, 400) radius:12.5 startAngle:0 endAngle:M_PI * 1.618 clockwise:YES];
    _clickLayer  = [[CAShapeLayer alloc] init];
    _clickLayer.path = bezier_yh.CGPath;
    _clickLayer.fillColor = [UIColor clearColor].CGColor;
    _clickLayer.strokeColor = [UIColor redColor].CGColor;
    _clickLayer.lineWidth = 25.0;    //此时为半径的二倍  线宽会平分在圆弧的里面与外面  此时圆的半径为 划线的2倍
    [self.view.layer addSublayer:_clickLayer];
    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)clickTap:(UITapGestureRecognizer *)tap {
    CGPoint clickPoint = [tap locationInView:self.view];
    CALayer *layer = [self.view.layer hitTest:clickPoint];
    
    if (layer == self.redLayer) {
        NSLog(@"red");
    }
    else if (layer == self.yellowLayer) {
        NSLog(@"yellow");
    }
    else if (layer == _clickLayer){
        NSLog(@"圆弧");
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGPoint clickPoint = [[touches anyObject] locationInView:self.view];
//    CALayer *layer = [self.view.layer hitTest:clickPoint];
//    
//    if (layer == self.redLayer) {
//        NSLog(@"red");
//    }
//    else if (layer == self.yellowLayer) {
//        NSLog(@"yellow");
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
