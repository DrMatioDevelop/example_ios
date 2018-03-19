//
//  ObjectCOther_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ObjectCOther_ViewController.h"
NSString *const testChangLiangNotification = @"testChangLiangNotification";

@interface ObjectCOther_ViewController ()
@end

//加上static作用域仅限制与本类
static const NSString *testChangLiang = @"测试";
@implementation ObjectCOther_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    //日历
//    [self timeWithCalendar_Component];
    NSString *str1 = @"1";
    NSString *str2 = nil;
    NSString *str3 = @"2";
    _otherNameFlag = YES;
    
    NSLog(@"%@",testChangLiang);
    NSArray *array1 = [NSArray arrayWithObjects:str1,testChangLiang,str2,str3, nil];
//    NSArray *array2 = @[str1,str2, str3];
}
- (void)setOtherNameFlag:(BOOL)otherNameFlag {
    _otherNameFlag = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.otherNameFlag = NO;
}

#pragma mark - NSCalendar NSDateComponents
//NSCalender封装了 世界常用日历 NSDateComponents 可以分割组合时间
- (void)timeWithCalendar_Component {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-mm-dd HH:mm:ss";
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitflags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [greCalendar  components:unitflags fromDate:[NSDate new]];
    NSLog(@"year:%ld, month:%02ld, day:%ld",[components year],[components month],[components day]);
    
    
    [components setYear:2015];
    [components setMonth:2];
    [components setDay:30];
    
    [components setHour:20];
    [components setMinute:20];
    [components setSecond:100];
    NSDate *date = [greCalendar dateFromComponents:components];
    NSLog(@"%@",date);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
