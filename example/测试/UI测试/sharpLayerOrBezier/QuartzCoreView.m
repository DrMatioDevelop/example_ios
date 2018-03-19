//
//  QuartzCoreView.m
//  动画
//
//  Created by d2c_cyf on 16/8/30.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "QuartzCoreView.h"
@implementation QuartzCoreView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [@"画图："        drawInRect:CGRectMake(10, 100, 80, 20) withAttributes:[self attributes]];
    [@"画线及孤线："   drawInRect:CGRectMake(10, 180, 100, 20) withAttributes:[self attributes]];
    [@"画矩形："      drawInRect:CGRectMake(10, 240, 80, 20) withAttributes:[self attributes]];
    [@"画扇形和椭圆：" drawInRect:CGRectMake(10, 320, 110, 20) withAttributes:[self attributes]];
    [@"画三角形："    drawInRect:CGRectMake(10, 400, 80, 20) withAttributes:[self attributes]];
    [@"画圆角矩形："  drawInRect:CGRectMake(10, 480, 100, 20) withAttributes:[self attributes]];
    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 560, 100, 20) withAttributes:[self attributes]];
    [@"图片："        drawInRect:CGRectMake(10, 620, 80, 20) withAttributes:[self attributes]];
    
    //边框图
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);//画笔颜色
    CGContextSetLineWidth(context, 2.0);//线宽
    CGContextAddArc(context, 100, 100, 15, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke); // 绘制边框
    
    //填充图,无边框
    CGContextAddArc(context, 150, 110, 30, 0, 2 * M_PI, 0);
    CGContextSetRGBFillColor(context, 0, 0, 1, 1.0);
    CGContextDrawPath(context, kCGPathFill); //绘制内容区域
    
    
    CGContextAddArc(context, 230, 110, 30.0, 0, M_PI * 0.5, YES);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画线
    CGPoint aPoint[2]; // 坐标点
    aPoint[0] = CGPointMake(100, 190);
    aPoint[1] = CGPointMake(130, 190);
    CGContextAddLines(context, aPoint, 2); //添加线
    CGContextDrawPath(context, kCGPathStroke);
    
    //笑脸弧线
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1.0);
    CGContextMoveToPoint(context, 140, 80);
    
}

- (NSDictionary *)attributes{
    NSDictionary* dic = @{NSFontAttributeName:Font(15),
                          NSForegroundColorAttributeName:[[UIColor redColor] colorWithAlphaComponent:0.8]
                          };

    return dic;
}
@end
