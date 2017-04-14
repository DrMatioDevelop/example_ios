//
//  Line_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/4/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Line_ViewController.h"

@interface Line_ViewController ()

@end

@implementation Line_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawline];
}



- (void)drawline {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint point = CGPointMake(10, 110);
    CGPoint point1 = CGPointMake(200, 200);
    CGPoint point2 = CGPointMake(240, 300);
    CGPoint point3 = CGPointMake(290, 300);
    CGPoint point4 = CGPointMake(320, 110);
    
    NSArray *array = @[[NSValue valueWithCGPoint:point],[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3],[NSValue valueWithCGPoint:point4]];
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)];

    [array enumerateObjectsAtIndexes:set options:0 usingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
        CGPoint point = [pointValue CGPointValue];
        [path addLineToPoint:point];
        
        //（一）rect折线画法
        CGRect rect;
        rect.origin.x = point.x - 1.5;
        rect.origin.y = point.y - 1.5;
        rect.size.width = 4;
        rect.size.height = 4;
        
//        //（二）rect射线画法
//        CGRect rect = CGRectMake(10, 10, 1, 1);
        
        UIBezierPath *arc= [UIBezierPath bezierPathWithOvalInRect:rect];
        [path appendPath:arc];
    }];
    
    //第三、UIBezierPath和CAShapeLayer关联
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.frame = CGRectMake(0, 150, 320, 400);
    lineLayer.fillColor = [UIColor redColor].CGColor;
    lineLayer.path = path.CGPath;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:lineLayer];


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
