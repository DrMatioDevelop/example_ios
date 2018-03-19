//
//  Layer_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/3/29.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//
//  http://www.cocoachina.com/ios/20160214/15251.html
#import "Layer_ViewController.h"

@interface Layer_ViewController ()
@property(strong ,nonatomic)UIButton *nextBtn;
@property(strong ,nonatomic)UIButton *graphyBtn;
@property(strong ,nonatomic)UIButton *lastBtn;
@property(strong ,nonatomic)UIButton *lineBtn;
@end

@implementation Layer_ViewController{
    CAShapeLayer *_clickLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtons = @[self.lastBtn];

    self.navigationItem.rightBarButtons = @[self.nextBtn,self.graphyBtn,self.lineBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //CAShapeLayer   UIBezierPath
//    [self baseLayer];
    
    //tryCatchFinal
    [self trycatchfinally];
    

//    QuartzCoreView *view = [[QuartzCoreView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
    
}

- (void)baseLayer {
    //普通的绘制-----1
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = CGRectMake(50, 70, 50, 36);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    //矩形  cornerRadius 圆角  贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 110, 50, 50) cornerRadius:15.0];
    CAShapeLayer *zfx_layer = [[CAShapeLayer alloc] init];
    zfx_layer.path = bezierPath.CGPath;
    zfx_layer.strokeColor = [UIColor redColor].CGColor;
    zfx_layer.fillColor   = [UIColor whiteColor].CGColor;
    zfx_layer.borderWidth = 5;
    [self.view.layer addSublayer:zfx_layer];
    
    
    //圆与圆弧 -----2  clockwise 顺时针方向
    UIBezierPath *bezierPath_pai = [[UIBezierPath alloc] init];
    [bezierPath_pai moveToPoint:CGPointMake(75, 200)];
    [bezierPath_pai addLineToPoint:CGPointMake(100.0, 200.0)];
    [bezierPath_pai addArcWithCenter:CGPointMake(75, 200) radius:25.0 startAngle:0.0 endAngle:M_PI * 1.5 clockwise:YES];
    [bezierPath_pai addLineToPoint:CGPointMake(75.0, 175.0)];
    [bezierPath_pai closePath];
    
    CAShapeLayer *shapeLayer_pai = [[CAShapeLayer alloc] init];
    shapeLayer_pai.path = bezierPath_pai.CGPath;
    shapeLayer_pai.fillColor = [UIColor cyanColor].CGColor;
    shapeLayer_pai.strokeColor = [UIColor redColor].CGColor;

    [self.view.layer addSublayer:shapeLayer_pai];
    [self animation_stroke:shapeLayer_pai];
    
    
    //扇形
    UIBezierPath *bezier_yh = [[UIBezierPath alloc] init];
    [bezier_yh addArcWithCenter:CGPointMake(150, 200) radius:12.5 startAngle:0 endAngle:M_PI * 1.618 clockwise:YES];
//    [bezier_yh addLineToPoint:CGPointMake(150, 200)];
//    [bezier_yh closePath]; //（如果是静态的扇形  在path画好圆以后  再画一条到圆心的直线  闭合path）

    MyCAShapeLayer *layer_yh  = [[MyCAShapeLayer alloc] init];
    layer_yh.path = bezier_yh.CGPath;
//    bezier_yh.lineWidth = 25.0;  //设置path的lineWidth与圆的半径相同 就会得到一个圆
//    layer_yh.lineWidth  = 25.0;   //设置shapeLayer的lineWidth与圆的半径相同 也会得到一个圆
    
    layer_yh.fillColor = [UIColor clearColor].CGColor;
    layer_yh.strokeColor = [UIColor redColor].CGColor;
    layer_yh.lineWidth = 25.0;    //此时为半径的二倍  线宽会平分在圆弧的里面与外面  此时圆的半径为 划线的2倍
    
    layer_yh.mytag = 100;
    layer_yh.infoDic = @{@"key" : @"value"};
    [self.view.layer addSublayer:layer_yh];
//    [self animation_stroke:layer_yh];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickyh:)];
    [self.view addGestureRecognizer:tap];
    
    
    //曲线 -----3
    
    //画点
    CGPoint startPoint = CGPointMake(50.0, 260);
    CGPoint endpoint   = CGPointMake(300.0, 260);
    CGPoint controlPoint = CGPointMake(100.0, 230.0);
    
    CGPoint controlPoint_1 = CGPointMake(250.0, 290.0);
    CALayer *layer_4_qx    = [[CALayer alloc] init];
    layer_4_qx.frame       = CGRectMake(controlPoint_1.x, controlPoint_1.y, 5, 5);
    layer_4_qx.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer_4_qx];
    
    CALayer *layer_1_qx = [[CALayer alloc] init];
    layer_1_qx.frame    = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    layer_1_qx.backgroundColor = [UIColor blueColor].CGColor;
    
    CALayer *layer_2_qx = [[CALayer alloc] init];
    layer_2_qx.frame    = CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer_2_qx.backgroundColor = [UIColor blueColor].CGColor;
    
    CALayer *layer_3_qx = [[CALayer alloc] init];
    layer_3_qx.frame    = CGRectMake(endpoint.x, endpoint.y, 5, 5);
    layer_3_qx.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:layer_1_qx];
    [self.view.layer addSublayer:layer_2_qx];
    [self.view.layer addSublayer:layer_3_qx];
    
    
    UIBezierPath *beizer_qx = [[UIBezierPath alloc] init];
    CAShapeLayer *layer_qx  = [[CAShapeLayer alloc] init];
    
    [beizer_qx moveToPoint:startPoint];
//    [beizer_qx addQuadCurveToPoint:endpoint controlPoint:controlPoint];
    [beizer_qx addCurveToPoint:endpoint controlPoint1:controlPoint controlPoint2:controlPoint_1];
    layer_qx.path = beizer_qx.CGPath;
    layer_qx.fillColor = [UIColor cyanColor].CGColor;
    layer_qx.strokeColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:layer_qx];
    
    
    //Beizer动画
    [self animation_stroke:layer_qx];
    
//    [self animation_doubleAnimation:layer_qx];
    
//    [self animation_lineWidth:layer_qx];

    
    
    //多边形  -----4
    [self duobianxing];
}



/**
 strokeStart  strokeEnd 范围[0,1]  strokeEnd 是从frameValue 到 toValue的正常动画   strokeStart 是相反的动画
 @param layer <#layer description#>
 */
- (void)animation_stroke:(CAShapeLayer *)layer {
    CABasicAnimation *animation_1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation_1.fromValue = @(0);
    animation_1.toValue   = @(1);
    animation_1.duration  = 2;
    [layer addAnimation:animation_1 forKey:@""];
}

- (void)animation_doubleAnimation:(CAShapeLayer *)layer {
    //范围是[0,1]  此时path的开始结束差值为0  所以线没有
    layer.strokeStart = 0.5;
    layer.strokeEnd   = 0.5;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    basicAnimation.fromValue = @(0.5);
    basicAnimation.toValue   = @(0);
    basicAnimation.duration  = 2;
    
    CABasicAnimation *basicAnimationEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimationEnd.fromValue = @(0.5);
    basicAnimationEnd.toValue   = @(1.0);
    basicAnimationEnd.duration = 2;
    
    [layer addAnimation:basicAnimation forKey:@""];
    [layer addAnimation:basicAnimationEnd forKey:@""];
}

- (void)animation_lineWidth:(CAShapeLayer *)layer {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    basicAnimation.fromValue = @(1.0);
    basicAnimation.toValue   = @(5.0);
    basicAnimation.duration  = 2.0;
    [layer addAnimation:basicAnimation forKey:@""];
}

//多边形
- (void)duobianxing {
    CGPoint startPoint = CGPointMake((SSize.width - 300) / 2.0, 350);
    CGSize size = CGSizeMake(300, 180.0);
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    
    
    
    [bezierPath moveToPoint:startPoint];
    [bezierPath addLineToPoint:CGPointMake(startPoint.x, startPoint.y + size.height)];
    [bezierPath addLineToPoint:CGPointMake(startPoint.x + size.width, startPoint.y + size.height)];
    [bezierPath addLineToPoint:CGPointMake(startPoint.x + size.width, startPoint.y)];
    [bezierPath addQuadCurveToPoint:startPoint controlPoint:CGPointMake(SSize.width / 2.0, startPoint.y - 50)];
    
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor   = [UIColor cyanColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth   = 3.0;
    [self.view.layer addSublayer:shapeLayer];
    
    [self animation_stroke:shapeLayer];
}

#pragma mark - trycatchfinal
// http://www.jianshu.com/p/05aad21e319e
// http://www.cocoachina.com/ios/20141229/10787.html
/**
 tryCatch 测试
 *  如果第6未注释  执行的顺序是  1->5->6->2->3->4
 *  已注释                    1->5->7->8->9->3->4
 */
- (void)trycatchfinally {
    @try {
        // 1
        NSLog(@"1");
        [self tryTwo];
    }
    @catch (NSException *exception) {
        // 2
        NSLog(@"2----%s\n%@", __FUNCTION__, exception);
        return;
    }
    @finally {
        // 3
        NSLog(@"3 -- 我一定会执行");
    }
    // 4
    // 这里一定会执行
    NSLog(@"4 --- try");
    
}

- (void)tryTwo {
    @try {
        // 5
        // 程序到这里会崩
//        NSString *str = @"abc"; NSLog(@"5");
//        [str substringFromIndex:111];
        
        NSArray *array = @[@(0)];
        array[5];
    }
    @catch (NSException *exception) {
        // 6
        // 抛出异常，即由上一级处理
        @throw exception;
        // 7
        NSLog(@"7---%s\n%@", __FUNCTION__, exception);
    }
    @finally {
        // 8
        NSLog(@"8 -- 我一定会执行");
    }
    
    // 9  即 @throw     @throw会把错误抛向上一级
    // 如果抛出异常，那么这段代码则不会执行
    NSLog(@"9--如果这里抛出异常，那么这段代码则不会执行");
}


#pragma makr - Click
- (void)clickyh:(UITapGestureRecognizer *)tap {
    CGPoint clickPoint = [tap locationInView:self.view];
    CALayer *clicklayer = [self.view.layer hitTest:clickPoint];
    
    
    for (CALayer *layer in self.view.layer.sublayers) {
        if ([layer isMemberOfClass:[MyCAShapeLayer class]]) {
            if (clicklayer == layer) {
                NSLog(@"ggg");
            }
            
            CGPoint mypoint = [layer convertPoint:clickPoint fromLayer:self.view.layer];
            if ([layer containsPoint:mypoint]) {
                NSLog(@"ggggg");
            }
        }
    }


    

}


- (void)clickNext:(UIButton *)button {
    NSLog(@"%s",__func__);
    Class cla = NSClassFromString(@"Layer_Event_TestVC");
    [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
}

- (void)clickGraphy:(UIButton *)button {
    NSLog(@"%s",__func__);
}
- (void)clickLast:(UIButton *)button {
    NSLog(@"%s",__func__);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickLine:(UIButton *)button {
    NSLog(@"%s",__func__);
    Class cla = NSClassFromString(@"Line_ViewController");
    [self.navigationController pushViewController:[[cla alloc] init] animated:YES];
}
#pragma makr - Getter
- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextBtn setTitle:@"layerClick" forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(clickNext:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.frame = CGRectMake(0, 0, 60.0, 44.0);
    }
    return _nextBtn;
}

- (UIButton *)graphyBtn {
    if (!_graphyBtn) {
        _graphyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_graphyBtn setTitle:@"绘图" forState:UIControlStateNormal];
        [_graphyBtn addTarget:self action:@selector(clickGraphy:) forControlEvents:UIControlEventTouchUpInside];
        _graphyBtn.frame = CGRectMake(0, 0, 44.0, 44.0);
    }
    return _graphyBtn;
}
- (UIButton *)lastBtn {
    if (!_lastBtn) {
        _lastBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_lastBtn setTitle:@"last" forState:UIControlStateNormal];
        [_lastBtn addTarget:self action:@selector(clickLast:) forControlEvents:UIControlEventTouchUpInside];
        _lastBtn.frame = CGRectMake(0, 0, 44.0, 44.0);
    }
    return _lastBtn;
}

- (UIButton *)lineBtn {
    if (!_lineBtn) {
        _lineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_lineBtn setTitle:@"曲线" forState:UIControlStateNormal];
        [_lineBtn addTarget:self action:@selector(clickLine:) forControlEvents:UIControlEventTouchUpInside];
        _lineBtn.frame = CGRectMake(0, 0, 44.0, 44.0);
    }
    return _lineBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
