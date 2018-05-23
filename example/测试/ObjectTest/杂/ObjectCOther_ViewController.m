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
    


}
- (void)setOtherNameFlag:(BOOL)otherNameFlag {
    _otherNameFlag = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.otherNameFlag = NO;
}
#pragma mark - KVC

/**
 kvc 在赋值的时候会以字符串的方式向对象发送消息，首先会查找_key ` _iskey命名的Getter方法，如果不存在会查找_key ` _iskey的实例变量.
 由此可以看出kvc使用的成本比直接赋值取值大，所以只在适合的时候使用kvc。
 */
- (void)KVCTest {
    //如果要使用kvc进行修改值需要满足以下两个添加
    //1.在被修改的中设置允许KVC进行修改
    //2.被修改的属性或容器没有使用getter方法进行赋值，而是使用_属性变量名进行赋值
    ObjectCOther_KVCTest *kvcTest = [[ObjectCOther_KVCTest alloc] init];
    NSLog(@"before:%@",kvcTest.myname);
    [kvcTest setValue:@"yan" forKey:@"myname"];
    NSLog(@"kvcAfter:%@",kvcTest.myname);
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




@implementation ObjectCOther_KVCTest
- (instancetype)init {
    if (self = [super init]) {
        _myname = @"yan";
    }
    return self;
}

//- (NSString *)myname {
//    return @"feng";
//}


//在类中设置此方法返回YES 允许KVC进行修改， NO进制KVC进行修改
+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}
@end
