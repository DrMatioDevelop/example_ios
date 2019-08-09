//
//  UI_ChartsVC.m
//  example
//
//  Created by 陈雁锋 on 2019/2/14.
//  Copyright © 2019 d2c_cyf. All rights reserved.
//

#import "UI_ChartsVC.h"
#import "MJExtension.h"

//@interface UI_ChartsVC () <ChartViewDelegate, IChartAxisValueFormatter, IChartValueFormatter>
//@property (nonatomic, strong) LineChartView *lineChart;
//@property (nonatomic, strong) NSMutableArray *xValues;
//@property (nonatomic, strong) NSMutableArray *yValues;
//@property (nonatomic, assign) double scale;
//@property (nonatomic, assign) NSInteger dataCount;
//@property (nonatomic, strong) UIButton *btn;
//@property (nonatomic, strong) UIButton *xBtn;
//@property (nonatomic, strong) UIButton *yBtn;
//
//@property (nonatomic, assign) BOOL xGuding;
//@property (nonatomic, assign) BOOL yGuding;
//@property (nonatomic, strong) LineChartDataSet *setset;
//
//@end
//
//@implementation UI_ChartsVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    //x轴是否固定
//    self.xGuding = YES;
//    self.yGuding = YES;
//
//    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.btn.backgroundColor = [UIColor orangeColor];
//    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.btn.frame = CGRectMake(50, 400, 60, 30);
//    [self.view addSubview:self.btn];
//    [self.btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.dataCount = 7;
//    [self func];
//
//    self.xBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.xBtn.backgroundColor = [UIColor orangeColor];
//    [self.xBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.xBtn.frame = CGRectMake(150, 400, 100, 30);
//    [self.xBtn setTitle:@"x固定" forState:UIControlStateNormal];
//    [self.view addSubview:self.xBtn];
//    [self.xBtn addTarget:self action:@selector(clickxBtn:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.yBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.yBtn.backgroundColor = [UIColor orangeColor];
//    [self.yBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.yBtn.frame = CGRectMake(150, 460, 100, 30);
//    [self.yBtn setTitle:@"y固定" forState:UIControlStateNormal];
//    [self.view addSubview:self.yBtn];
//    [self.yBtn addTarget:self action:@selector(clickyBtn:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)layerTest {
//    //    CGContext context =
//    //    //第二种填充方式
//    //    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    //    CGFloat colors[] =
//    //    {
//    //        1,1,1, 1.00,
//    //        1,1,0, 1.00,
//    //        1,0,0, 1.00,
//    //        1,0,1, 1.00,
//    //        0,1,1, 1.00,
//    //        0,1,0, 1.00,
//    //        0,0,1, 1.00,
//    //        0,0,0, 1.00,
//    //    };
//    //    CGGradientRef gradient = CGGradientCreateWithColorComponents
//    //    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
//    //    CGColorSpaceRelease(rgb);
//    //    CGContextSaveGState(context);
//    //    CGContextMoveToPoint(context, 220, 90);
//    //    CGContextAddLineToPoint(context, 240, 90);
//    //    CGContextAddLineToPoint(context, 240, 110);
//    //    CGContextAddLineToPoint(context, 220, 110);
//    //    CGContextClip(context);//context裁剪路径,后续操作的路径
//    //    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
//    //    //gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
//    //    CGContextDrawLinearGradient(context, gradient,CGPointMake
//    //                                (220,90) ,CGPointMake(240,110),
//    //                                kCGGradientDrawsAfterEndLocation);
//}
//
//- (void)clickBtn:(UIButton *)btn {
//
//    [_lineChart setNeedsDisplay];
//
//    self.dataCount = 2 + arc4random() % 29;
//    [self func];
//}
//
//- (void)clickxBtn:(UIButton *)btn {
//    self.xGuding = !self.xGuding;
//    if (self.xGuding) {
//        [self.xBtn setTitle:@"x固定" forState:UIControlStateNormal];
//    } else {
//        [self.xBtn setTitle:@"x不固定" forState:UIControlStateNormal];
//    }
//
//    [self func];
//}
//
//- (void)clickyBtn:(UIButton *)btn {
//    self.yGuding = !self.yGuding;
//
//    if (self.yGuding) {
//        [self.yBtn setTitle:@"y固定" forState:UIControlStateNormal];
//    } else {
//        [self.yBtn setTitle:@"y不固定" forState:UIControlStateNormal];
//    }
//    [self func];
//}
//
//- (void)func {
//    [self.btn setTitle:[NSString stringWithFormat:@"%ld", (long)self.dataCount] forState:UIControlStateNormal];
//
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < self.dataCount; i++) {
//        NSNumber *num = @(arc4random() % 100 + 5.3334);
//        [array addObject:num];
//    }
//    self.yValues = array;
//
//    NSMutableArray *xArray = [[NSMutableArray alloc] init];
//    for (NSInteger i = 0; i < self.dataCount; i++) {
//        [xArray addObject:[NSString stringWithFormat:@"12.%ld", (long)i + 1]];
//    }
//    self.xValues = xArray;
//
//    [self lineChartInit];
//}
//
//- (void)lineChartInit {
//    /* 设置曲线图属性 */
//    self.lineChart.backgroundColor = [UIColor clearColor]; //图表背景
//    _lineChart.noDataText = @"好像缺了点数据什么的";       //没数据时显示的文字
//    _lineChart.chartDescription.enabled = NO;              //不显示图表描述文字
//    _lineChart.dragEnabled = YES;                          //图表可以拖动
//    _lineChart.legend.enabled = NO;                        //不显示图例
//    _lineChart.scaleXEnabled = NO;                         //X轴不能缩放
//    _lineChart.scaleYEnabled = NO;                         //Y轴不能缩放
//    _lineChart.pinchZoomEnabled = NO;                      //不能捏合手势缩放
//    _lineChart.delegate = self;                            //设置代理
//    _lineChart.extraTopOffset = 50;
//    _lineChart.extraLeftOffset = 15;
//    _lineChart.extraRightOffset = 15;
//    _lineChart.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
//
//    /* 设置坐标轴属性 */
//    ChartXAxis *xAxis = _lineChart.xAxis;           //获取图表X轴
//    xAxis.labelPosition = XAxisLabelPositionBottom; //X轴标签位置
//    xAxis.drawLabelsEnabled = YES;                  //显示X轴
//    xAxis.drawGridLinesEnabled = NO;                //隐藏X轴表格线
//    //xAxis.axisMaximum = self.dataArray.count-1+0.3 ;          //设置左右边距
//    xAxis.axisLineWidth = 1; //X轴宽度
//    xAxis.axisLineColor = [UIColor blackColor];
//    //    xAxis.spaceMin = 10;
//    //        xAxis.axisMaximum = self.dataCount-1+0.3;//最大个数
//
//    xAxis.labelFont = [UIFont systemFontOfSize:12];
//    [xAxis setGranularity:1.0];
//    NSInteger maxCount = self.dataCount > 7 ? 7 : self.dataCount;
//    //    xAxis.axisMinimum = -(1.0/maxCount - 0.01) * self.dataCount; //最小个数
//
//    [xAxis setLabelCount:maxCount force:self.xGuding];
//    xAxis.labelWidth = 50;
//
//    _lineChart.rightAxis.enabled = NO; //右边轴不显示
//
//    //    xAxis.labelRotationAngle = -30;//偏移角度
//
//    //    if (self.xValues.count > 7) {
//    //        NSArray *array = [self.xValues subarrayWithRange:NSMakeRange(0, 7)];
//    //        _lineChart.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:array];
//    //    }
//    //    else {
//    _lineChart.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:self.xValues];
//    _lineChart.xAxis.valueFormatter = self;
//    //    }
//
//    ChartYAxis *leftAxis = _lineChart.leftAxis; //获取左边轴
//    leftAxis.enabled = YES;                     //显示左边轴
//    leftAxis.drawGridLinesEnabled = YES;        //隐藏Y轴表格线
//    leftAxis.axisMinimum = 0;                   //Y轴最小值
//                                                //    leftAxis.axisMaximum = 120;//[[self.yValues valueForKeyPath:@"@max.floatValue"] floatValue];
//    leftAxis.drawAxisLineEnabled = NO;          //绘制Y轴
//    leftAxis.axisLineWidth = 1.0;               //X轴宽度
//    leftAxis.labelCount = 5;
//    leftAxis.forceLabelsEnabled = self.yGuding;
//    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
//    leftAxis.yOffset = 10;
//    leftAxis.axisLineColor = [UIColor redColor];
//    leftAxis.gridLineDashPhase = 1;
//    leftAxis.gridLineDashLengths = @[ @1, @1 ];
//
//    NSMutableArray *yarray = [self.yValues mutableCopy];
//    [yarray replaceObjectAtIndex:1 withObject:@"ptr"];
//    _lineChart.leftAxis.valueFormatter = self;
//    _lineChart.xAxis.valueFormatter = self;
//    //    _lineChart.leftAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:yarray];
//
//    //    [_lineChart zoomWithScaleX:1 scaleY:1 x:2 y:0];
//    //动画时间
//    [_lineChart animateWithXAxisDuration:0];
//
//    [self setLineChartData:self.yValues];
//}
//
///**
// 设置折线
//
// @param dataArray <#dataArray description#>
// */
//- (void)setLineChartData:(NSMutableArray *)dataArray {
//    if (!dataArray.count) {
//        return;
//    }
//    LineChartDataSet *set1 = nil;
//    NSMutableArray *values = [[NSMutableArray alloc] init];
//
//    for (int i = 0; i < dataArray.count; i++) {
//        //将横纵坐标以ChartDataEntry的形式保存下来，注意横坐标值一般是i的值，而不是你的数据,自定义X轴坐标label需新建一个XFormat类来赋值
//        ChartDataEntry *obj = [[ChartDataEntry alloc] initWithX:i y:[dataArray[i] floatValue] icon:nil];
//        [values addObject:obj];
//    }
//    //如果图表有绘制过，可以在这里重新给data赋值就行,
//    //如果没有，需要先定义set的属性。
//    if (_lineChart.data.dataSetCount > 0) {
//        set1 = (LineChartDataSet *)_lineChart.data.dataSets[0];
//        self.setset = set1;
//
//        set1.values = values;
//        //        _lineChart.highlighted = nil;
//
////        ChartDataEntry *entry = [_lineChart.data entryForHighlight:_lineChart.lastHighlighted];
////        entry = nil;
//        [_lineChart highlightValue:nil callDelegate:NO];
//
//        //通知data去更新
//        [_lineChart.data notifyDataChanged];
//        //通知图表去更新
//        [_lineChart notifyDataSetChanged];
//
//    } else {
//        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
//        self.setset = set1;
//        set1.valueFormatter = self;
//        //自定义set的各种属性
//        [self configSet:set1];
//        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//        [dataSets addObject:set1];
//        //将set保存到data当中
//        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
//        _lineChart.data = data;
//        //        [_lineChart setVisibleXRangeMaximum:self.dataCount];
//        //        [_lineChart setVisibleXRangeMinimum:self.dataCount];
//        NSLog(@"%@", data);
//    }
//}
//
//- (void)configSet:(LineChartDataSet *)set {
//    //是否绘制图标
//    set.drawIconsEnabled = NO;
//    //折线颜色
//    [set setColor:[UIColor orangeColor]];
//    //折线点的颜色
//    [set setCircleColor:[UIColor orangeColor]];
//    //折线的宽度
//    set.lineWidth = 2.0;
//    //折线点的宽度
//    set.circleRadius = 1.0;
//    //是否画空心圆
//    set.drawCircleHoleEnabled = NO;
//    //折线样式
//    set.mode = LineChartModeLinear;
//    //折线弧度
//    set.cubicIntensity = 0.2;
//    //折线点的值的大小
//    set.valueFont = [UIFont systemFontOfSize:9.f];
//    //图例的线宽
//    set.formLineWidth = 5.0;
//    //图例的字体大小
//    set.formSize = 15.0;
//    //显示颜色填充
//    set.drawFilledEnabled = false;
//    //不显示点的值
//    set.drawValuesEnabled = NO;
//    //
//    set.drawCirclesEnabled = YES;
//    //显示十字线
//    set.highlightEnabled = YES;
//
//    set.colors = @[ UIColor.redColor, UIColor.blackColor ];
//    //十字线颜色
//    set.highlightColor = [UIColor redColor];
//    set.drawHorizontalHighlightIndicatorEnabled = NO;
//}
//- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
//
//    NSLog(@"%s", __func__);
//}
//- (void)chartValueNothingSelected:(ChartViewBase *)chartView {
//    NSLog(@"%s", __func__);
//}
//- (NSString *)stringForValue:(double)value entry:(ChartDataEntry *)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler *)viewPortHandler {
//    return @"100";
//}
//
//- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
//
//    LineChartDataSet *set2 = (LineChartDataSet *)_lineChart.data.dataSets[0];
//    NSArray *array = _lineChart.data.dataSets;
//
//    if (axis == self.lineChart.xAxis) {
//        //        if (value < 0 && self.dataCount >= 7) {
//        //            return @"  ";
//        //        }
//        //
//        NSInteger index = MIN(MAX((int)value, 0), self.dataCount - 1);
//        if (index == 0) {
//            return [NSString stringWithFormat:@"　%@", [self.xValues objectAtIndex:index]];
//
//        }
//        //        else if (index == self.lineChart.xAxis.labelCount - 1){
//        //          return [NSString stringWithFormat:@"%@　",[self.xValues objectAtIndex:index]];
//        //        }
//        else {
//            return [NSString stringWithFormat:@"%@　　", [self.xValues objectAtIndex:index]];
//        }
//
//        //        return [NSString stringWithFormat:@"%@",[self.xValues objectAtIndex:index]];
//
//    } else if (axis == self.lineChart.leftAxis) {
//        if (value == 0) {
//            return @"    ";
//        } else {
//            return [NSString stringWithFormat:@"%ld", (long)value];
//        }
//    }
//    return @"cccccc";
//    //    if (value == 0) {
//    //        return @"";
//    //    }
//    //    return [NSString stringWithFormat:@"%lf",value];
//    //    NSLog(@"%lf",value);
//    //    NSLog(@"%ld",self.dataCount-(int)value-1);
//    //    return @"ddd";
//}
//
//- (LineChartView *)lineChart {
//    if (!_lineChart) {
//        _lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 100, SSize.width - 0, 260)];
//
//        _lineChart.legend.form = ChartLegendFormNone; //说明图标
//        _lineChart.dragEnabled = YES;                 //拖动手势
//        _lineChart.pinchZoomEnabled = NO;             //捏合手势
//        _lineChart.rightAxis.enabled = NO;            //隐藏右Y轴
//        _lineChart.chartDescription.enabled = NO;     //不显示描述label
//        _lineChart.doubleTapToZoomEnabled = NO;       //禁止双击缩放
//        _lineChart.drawGridBackgroundEnabled = NO;
//        _lineChart.drawBordersEnabled = NO;
//        _lineChart.dragEnabled = YES; //拖动气泡
//        _lineChart.delegate = self;
//        [_lineChart animateWithXAxisDuration:2.0 easingOption:ChartEasingOptionEaseOutBack];
//
//        [self.view addSubview:_lineChart];
//    }
//    return _lineChart;
//}
//
//@end
