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
    
    CAShapeLayer *bluerLayer = [CAShapeLayer layer];
    bluerLayer.fillColor = [UIColor blueColor].CGColor;
    bluerLayer.path = bezier_yh.CGPath;
    [self.view.layer addSublayer:bluerLayer];
    
//    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
//    [self.view addGestureRecognizer:tap];
    
}



///**
// 如果是贝塞尔曲线画图  然后填充color  本质还是一个曲线  用layer那种取法是取不到的
//
// @param tap <#tap description#>
// */
//- (void)clickTap:(UITapGestureRecognizer *)tap {
//    CGPoint clickPoint = [tap locationInView:self.view];
//    CALayer *layer = [self.view.layer hitTest:clickPoint];
//    
//    if (layer == self.redLayer) {
//        NSLog(@"red");
//    }
//    else if (layer == self.yellowLayer) {
//        NSLog(@"yellow");
//    }
//    else if (layer == _clickLayer){
//        NSLog(@"圆弧");
//    }
//}


/**
 当画扇形的时候  lineWidth为半径的二倍平分到了 弧的内侧与外侧  所以点击区域只有在真实圆的内部有效

 @param touches <#touches description#>
 @param event <#event description#>
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //得到触摸点
    CGPoint clickPoint = [[touches anyObject] locationInView:self.view];
    //得到layer上的点
    CGPoint layerPoint_red = [self.view.layer convertPoint:clickPoint toLayer:self.redLayer];
    //得到画图部分的path
    UIBezierPath *path_red = [UIBezierPath bezierPathWithCGPath:self.redLayer.path];
    
    CGPoint layerPoint_yh = [self.view.layer convertPoint:clickPoint toLayer:_clickLayer];
    UIBezierPath *path_yh = [UIBezierPath bezierPathWithCGPath:_clickLayer.path];
    
    //判断时候点击画图中的点
    if ([path_red containsPoint:layerPoint_red]) {
        NSLog(@"red");
    }
    else if ([path_yh containsPoint:layerPoint_yh]) {
        NSLog(@"yh");
    }
}
//http://www.bubuko.com/infodetail-605345.html  添加事件 performSelect


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
