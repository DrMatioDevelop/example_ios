//
//  UI_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/3/21.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "UI_ViewController.h"

@interface UI_ViewController ()
@property (nonatomic , strong)UITextField  *myTextField;
@property (nonatomic , strong)UISearchBar  *searchBar;
@property (nonatomic , strong)UIDatePicker *datePicker;
@end

@implementation UI_ViewController
- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.title = @"UI测试";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view addSubview:self.myTextField];
//    
//    [self.view addSubview:self.searchBar];
//    
//    [self.view addSubview:self.datePicker];
    
    [self specialLastTime];
    
    NSString *str;
    if([str isKindOfClass:[NSNull class]]||[[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        NSLog(@"1");
    }
    else {
        NSLog(@"2");

    }
    
}

- (void)aboutTime {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY";
}
- (NSDate *)specialLastTime {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY/MM/dd";
    
    NSDate   *lastDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:nowDate];
    NSString *lastDateStr = [formatter stringFromDate:lastDay];
    NSLog(@"lastDate:%@",lastDateStr);
    
    NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
    formatter_1.dateFormat = @"YYYY/MM/dd HH:mm:ss";
    NSString *str  = [NSString stringWithFormat:@"%@ 00:00:00",lastDateStr];
    NSDate  *lastDate_1 = [formatter_1 dateFromString:str];
    
    NSLog(@"lastDate:%@",[formatter_1 stringFromDate:lastDate_1]);
    return lastDate_1;
}

- (UITextField *)myTextField {
    if (!_myTextField) {
        _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(70.0 / 2.0, 100, SSize.width - 70.0, 30)];
        _myTextField.backgroundColor = ColorRGBA(240, 240, 240, 1);
        _myTextField.font = Font(14);
        _myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _myTextField.returnKeyType = UIReturnKeySearch;
        _myTextField.layer.cornerRadius = 5.0;
        _myTextField.contentMode = UIViewContentModeCenter;
        
        UIImageView *searchImage  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 28)];
        searchImage.image         = [UIImage imageNamed:@"icon_a_search_l"];
        _myTextField.leftView     = searchImage;
        _myTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        NSString *holdText = @"商品、设计师搜索";

        NSMutableAttributedString *placeholderAttribute = [[NSMutableAttributedString alloc] initWithString:holdText];
        [placeholderAttribute addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(0, holdText.length)];
        [placeholderAttribute addAttribute:NSForegroundColorAttributeName value:ColorRGB(283, 85, 98) range:NSMakeRange(0, holdText.length)];
        _myTextField.attributedPlaceholder = placeholderAttribute;
    }
    return _myTextField;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60.0 / 2.0, 150, SSize.width - 60.0, 30)];
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.contentMode = UIViewContentModeCenter;
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.placeholder = @"商品、设计师搜索";
        for (UIView *view in _searchBar.subviews) {
            for (UIView *view2 in view.subviews) {
                if ([view2 isMemberOfClass:[NSClassFromString(@"UISearchBarBackground") class]]) {
                    [view2 removeFromSuperview];
                }
                if ([view2 isMemberOfClass:[NSClassFromString(@"UISearchBarTextField") class]]) {
                    UITextField *textField = (UITextField *)view2;
                    textField.backgroundColor = ColorRGBA(240, 240, 240, 1);
                    textField.font = Font(14);
                    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
                    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
                }
            }
        }
    }
    return _searchBar;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, SSize.width, 180)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker setValue:[UIColor redColor] forKey:@"textColor"];
        [_datePicker addTarget:self action:@selector(dataPickerChange:) forControlEvents:UIControlEventValueChanged];
        
        
        NSDate *theDate = _datePicker.date;
        NSTimeZone* sourceTimeZone =  [NSTimeZone timeZoneForSecondsFromGMT:0];
        _datePicker.timeZone = sourceTimeZone;

        unsigned outCount;
        objc_property_t *pProperty = class_copyPropertyList([UIDatePicker class], &outCount);
        for (int i = 0; i < outCount; i++) {
            //属性名字
             NSString *getPropertyName = [NSString stringWithCString:property_getName(pProperty[i]) encoding:NSUTF8StringEncoding];
            
             NSString *getPropertyNameString = [NSString stringWithCString:property_getAttributes(pProperty[i]) encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@====%@",getPropertyNameString,getPropertyName);
        }
        
        
        

        
        //比较时间与GMT 目标日期与本地时区的偏移量
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:theDate];
        
        //本地时间与GMT 目标日期与本地时区的偏移量
        NSTimeZone        *myTimeZone = [NSTimeZone localTimeZone];
        NSInteger destinationGMTOffset = [myTimeZone secondsFromGMTForDate:theDate];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
        dateFormatter.timeZone = sourceTimeZone;
        NSLog(@"本地时间%@",[dateFormatter stringFromDate:theDate]);
        

        
        //得到时间偏移量的差值
        NSTimeInterval interval =  destinationGMTOffset - sourceGMTOffset;
        NSDate *nowDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:theDate];
//        NSLog(@"北京时间%@",[dateFormatter stringFromDate:nowDate]);
        
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        dateFormatter1.dateFormat = @"YYYY-MM-dd HH-mm-ss";
        NSLog(@"北京时间%@",[dateFormatter stringFromDate:nowDate]);
    }
    return _datePicker;
}

- (void)dataPickerChange:(UIDatePicker *)datePicker {
    NSDate *theDate = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH-mm-ss";
    NSLog(@"改变时间%@",[dateFormatter stringFromDate:theDate]);

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
