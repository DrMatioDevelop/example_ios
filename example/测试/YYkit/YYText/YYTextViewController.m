//
//  YYTextViewController.m
//  example
//
//  Created by d2c_cyf on 17/1/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "YYTextViewController.h"

@interface YYTextViewController ()

@end

@implementation YYTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize size = CGSizeMake(20, 20);
    UIImage *background = [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
        UIColor *c0 = [UIColor redColor];
        UIColor *c1 = [UIColor blueColor];
        [c0 setFill];
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
        [c1 setStroke];
        CGContextSetLineWidth(context, 2);
//        for (int i = 0; i < size.width * 2; i+= 4) {
            CGContextMoveToPoint(context, 0, -2);
            CGContextAddLineToPoint(context, 0 - size.height, size.height + 2);
//        }
        CGContextStrokePath(context);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 200)];
    imgView.image = background;
    [self.view addSubview:imgView];
    
}


#pragma mark -  const相关
- (void)about_const {
    int   c = 22; int   d = 33;
    const int  a = 10;  //a不可变
    int  const b = 20;  //b不可变
    int  const *p1 = &c;//*p1不可变  p1可变
    p1  = &d;
    int  * const p2 = &c;//*p1可变   p2不可变
    *p2 = d;
    NSLog(@"a:%d,b:%d,c:%d,p1:%d,p2:%d",a,b,c,*p1,*p2);
    
    
    NSMutableArray *muarray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 11; i++) {
        [muarray addObject:@(i)];
    }
    NSLog(@"%@",muarray);
    
    NSMutableArray *targetArray = [[NSMutableArray alloc] init];
    NSInteger count = muarray.count / 2;
    
    for (int j = 0; j < count; j++) {
        for (int k = 0; k < 2; k++) {
            if (k % 2 == 0) {
                [targetArray addObject:muarray[j]];
            }
            else {
                if (count + j >= muarray.count) {
                    break;
                }
                [targetArray addObject:muarray[count + j]];
            }
        }
    }
    if (muarray.count % 2 != 0) {
        [targetArray addObject:[muarray lastObject]];
    }
    
    NSLog(@"%@",targetArray);
}

#pragma mark - 正则表达式截取想要的值
/**
 正则表达式截取想要的值
 */
- (void)regexStr {
    NSString *urlString = @"http://xxxxmall.com/membershare/mine?memberId=24530";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".*/membershare/mine\\?memberId=(\\d+)" options:NSRegularExpressionCaseInsensitive error:nil];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:NSMatchingReportProgress range:NSMakeRange(0, urlString.length)];
        if (firstMatch) {
            NSLog(@"%@",[urlString substringWithRange:[firstMatch rangeAtIndex:1]]);
        }
    }
}
#pragma mark - 测试本地通知
/**
 测试本地通知
 */
- (void)testLocationNotifation {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text =  @"aaaaaaa\n0020bbbbbb";
    label.backgroundColor = [UIColor lightGrayColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.view addSubview:label];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 300, 100, 50.0);
    [button setTitle:@"本地通知" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(clickNotification) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(150, 300, 100, 50.0);
    [button1 setTitle:@"移除本地通知" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(clickClearNotification) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
}

- (void)clickNotification {
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 2.设置本地通知的内容
    // 2.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
    // 2.2.设置通知的内容
    localNote.alertBody = @"在干吗?";
    // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
    localNote.alertAction = @"解锁";
    // 2.4.决定alertAction是否生效
    localNote.hasAction = NO;
    // 2.5.设置点击通知的启动图片
    localNote.alertLaunchImage = @"123Abc";
    // 2.6.设置alertTitle
    localNote.alertTitle = @"你有一条新通知";
    // 2.7.设置有通知时的音效
    localNote.soundName = @"buyao.wav";
    // 2.8.设置应用程序图标右上角的数字
    localNote.applicationIconBadgeNumber = 999;
    localNote.alertLaunchImage = @"icon_live_card_bg.png";
    // 2.9.设置额外信息
    localNote.userInfo = @{@"type" : @1};
    
    // 3.调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

- (void)clickClearNotification {
    NSArray *notes = [UIApplication sharedApplication].scheduledLocalNotifications;
    NSLog(@"%@",notes);
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
