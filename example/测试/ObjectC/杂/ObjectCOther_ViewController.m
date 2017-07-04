//
//  ObjectCOther_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/7/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ObjectCOther_ViewController.h"

@interface ObjectCOther_ViewController ()

@end

@implementation ObjectCOther_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self timeWithCalendar_Component];
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
