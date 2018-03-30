//
//  YYTextViewController.m
//  example
//
//  Created by d2c_cyf on 17/1/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "YYTextViewController.h"
#import "YYText_1_ViewController.h"
#import <ImageIO/ImageIO.h>
#import "OprationViewController.h"
#import "KICustomBean.h"
@interface YYTextViewController ()

/**
 gif图image
 */
@property (nonatomic, strong)UIImageView *gifImgView;
/**
 队列
 */
@property (nonatomic, strong)NSOperationQueue *operationQueue;
@property (nonatomic, strong)UIButton         *btn;
@end

@implementation YYTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"{\"mall_name\":\"U7c73U91d1U793e\",\"mer_no\":\"BOB-MJS-C-20180117\",\"mall_no\":\"BOB-MJS-20180117\",\"version\":\"SDK\",\"sign\":\"Gq8X5ErjJ%2FZDpXrxCyRGcn4zNYKfyXvLXK%2Bs4AVnrsC5wE%2BDPczLCIijrMqCy9LzkwDI1%2FUzQVSv%0D%0ArymKGGc%2FSrJf2TlHzWZnZ73qMXfbRoe6AYTh9uBRjd03a89wSe7jEIXFez9274XT1wHNKOb9wX0n%0D%0ALnJgcKjz5c6GbkSZldY%3D\",\"mer_name\":\"U7c73U91d1U793e\",\"pay_code\":\"040\",\"trans_pwd\":\"0L5nweEdY6sfdqjmGuve8qLQ9kaCdR7gSah/VK7Vx/D0A/Ei/79SbrSREjVPjEtaiIsbz72ggPHrsDbI2TBl5b35HP4K4KvC5LOc4rUhN8RBa8UgC6fGITPZlExiY3KBYukSBB1coLODZF/MGLr4PQETiuQqKKryqiDTx38xhcUW3JegvJiVK7JLSqHqSHmpqkq2ENEkmH0M32ofZ5aueQqXSwvs1qWC5mVNcLTjr90=\",\"platcust\":\"201803131422430458108294810318\",\"identifying_code\":\"5555\",\"remark\":\"\",\"partner_trans_date\":\"20180320\",\"order_no\":\"RECAUTHCON2018032011323469117\",\"origin_order_no\":\"RECAPP2018032011323409857\",\"random_key\":\"30871124382381001893545701820322\",\"partner_trans_time\":\"113234\"}";
    KICustomBean *dic = [KICustomBean yy_modelWithJSON:str];
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding ] options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    NSLog(@"%@",dic1);
    
    
//    self.operationQueue = [[NSOperationQueue alloc] init];
//    self.operationQueue.maxConcurrentOperationCount = 1;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.backgroundColor = [UIColor redColor];
//    button.frame = CGRectMake(0, 64, 100, 50);
//    [self.view bringSubviewToFront:button];
//    [button addTarget:self action:@selector(gifBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    
//    
//    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.btn.backgroundColor = [UIColor blueColor];
//    self.btn.frame = CGRectMake(0, 200, 100, 50);
//    [self.view bringSubviewToFront:self.btn];
//    [self.btn addTarget:self action:@selector(clickOperation:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.btn];
    
    

    
    
    
//    [self gifToPng];
//    [self shoGifWithImgView];
    
//    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self nsoperationQueue];
//    }];
//
    
    

    
    
    
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"d2c" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBar:)];
//    
//    CGSize size = CGSizeMake(20, 20);
//    UIImage *background = [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
//        UIColor *c0 = [UIColor redColor];
//        UIColor *c1 = [UIColor blueColor];
//        [c0 setFill];
//        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
//        [c1 setStroke];
//        CGContextSetLineWidth(context, 2);
////        for (int i = 0; i < size.width * 2; i+= 4) {
//            CGContextMoveToPoint(context, 0, -2);
//            CGContextAddLineToPoint(context, 0 - size.height, size.height + 2);
////        }
//        CGContextStrokePath(context);
//    }];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 200)];
//    imgView.image = background;
//    [self.view addSubview:imgView];
    
    
//    [self nsoperationQueue];
    
//    [self groupGCD];
}


- (void)clickLeftBar:(UIBarButtonItem *)barItem {
    gifImageViewController *vc = [[gifImageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

//    [self.navigationController pushViewController:[[YYText_1_ViewController alloc] init] animated:YES];
}
#pragma mark - NSOpration

- (void)optationAnimation {
    [UIView animateWithDuration:3 animations:^{
        self.btn.transform = CGAffineTransformTranslate(self.btn.transform, 200, 0);
//        self.operationQueue.suspended = NO;

    } completion:^(BOOL finished) {
        self.btn.transform = CGAffineTransformIdentity;
//        self.operationQueue.suspended = NO;
    }];
}

- (void)clickOperation:(UIButton *)button  {
    OprationViewController *vc =  [[OprationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 使用UIImageView加载gif图片
- (void)gifToPng {
//    NSString *baseUrl1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    
////    [FileHelp removeFileAtPath:baseUrl1 keepDirectory:YES];
//    
//    return;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"view-wechat-chat" ofType:@"gif"];
    NSData   *gifData  = [NSData dataWithContentsOfFile:filePath];
    //用imageIO框架转为 CGImageSourceRef
    CGImageSourceRef gifDataSource = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, nil);
    NSInteger count = CGImageSourceGetCount(gifDataSource);
    
    NSString *baseUrl = NSHomeDirectory();
    NSString *directory = [baseUrl stringByAppendingPathComponent:@"cyf/weichat"];
    if (![FileHelp createDirectoriesWithUrlStr:directory intermediateDirectories:YES]) {
        return;
    }
    for (int i = 0; i < count - 1; i++) {
        CGImageRef imgRef = CGImageSourceCreateImageAtIndex(gifDataSource, i, nil);
        UIImage    *image = [UIImage imageWithCGImage:imgRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        NSData     *imageData = UIImagePNGRepresentation(image);
        NSString   *fileUrlStr = [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png",i]];
        [imageData writeToFile:fileUrlStr atomically:YES];
        
    }
    NSLog(@"%@",baseUrl);

    
}
- (void)shoGifWithImgView {
    NSString *baseUrlStr =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSInteger count =  [FileHelp getFileCountWithUrlStr:baseUrlStr fileType:@".png"];
    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    for (int i = 0;i < count-1; i++) {
       UIImage *image = [UIImage imageWithContentsOfFile:[baseUrlStr stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png",i]]];
        [muArray addObject:image];
        
    }
    
    UIImage *image = [muArray firstObject];
    CGSize size = image.size;
    
    self.gifImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.view addSubview:self.gifImgView];
    self.gifImgView.animationImages   = muArray;
    self.gifImgView.animationDuration = 5.0;
    self.gifImgView.animationRepeatCount = 0; //0重复播放
    NSLog(@"%@",baseUrlStr);
}

- (void)stopAnimationWithImgView:(UIImageView *)imgView {
    [imgView stopAnimating];
}
- (void)startAnimationWithImgView:(UIImageView *)imgView {
    [imgView startAnimating];
}
- (BOOL)isAnimationWithImgView:(UIImageView *)imgView {
    return [imgView isAnimating];
}
- (void)gifBtn:(UIButton *)button {
    
    static int a = 1;
    NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self optationAnimation];
        NSLog(@"完成 %d",a++);
    }];
    [self.operationQueue addOperation:op1];
    
    NSLog(@"队列数量 %ld",self.operationQueue.operationCount);
    
//    if (button.selected) {
//        [self stopAnimationWithImgView:self.gifImgView];
//
//    }
//    else {
//        [self startAnimationWithImgView:self.gifImgView];
//
//    }
//    button.selected = !button.selected;
}
#pragma mark - 各个请求异步执行  顺序要一定
- (void)nsoperationQueue {
    NSBlockOperation *operation_1 = [NSBlockOperation blockOperationWithBlock:^{
        [self requestA];
    }];
    
    NSBlockOperation *operation_2 = [NSBlockOperation blockOperationWithBlock:^{
        [self requestB];
    }];
    
    NSBlockOperation *operation_3 = [NSBlockOperation blockOperationWithBlock:^{
        [self requestC];
    }];
    
    [operation_2 addDependency:operation_1];
    [operation_3 addDependency:operation_2];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.operationQueue addOperations:@[operation_1,operation_2,operation_3] waitUntilFinished:NO];
    NSLog(@"ggg");
    NSLog(@"\n\n");
    
}
#pragma mark - GCD 组并不能解决  多个请求同时完成时再刷新UI
- (void)groupGCD {
    
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestB];

    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestA];
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestC];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"notify");
    });
}


- (void)requestA {
    NSLog(@"1");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

//    [self.operationQueue setSuspended:YES];
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://test.api.d2cmall.com/v2/api/product/list?k=li" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        [self.operationQueue setSuspended:NO];

        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_semaphore_signal(sema);
        [self.operationQueue setSuspended:NO];
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

}

- (void)requestB {
    NSLog(@"2");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//    [self.operationQueue setSuspended:YES];

    [AFNHelp RequestWithHttpType:GET urlStr:@"https://test.api.d2cmall.com/v2/api/product/list?k=w" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        [self.operationQueue setSuspended:NO];

        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.operationQueue setSuspended:NO];

        dispatch_semaphore_signal(sema);

    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

}

- (void)requestC {
    NSLog(@"3");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//    [self.operationQueue setSuspended:YES];

    //https://test.api.d2cmall.com/v2/api/product/detail/list?designerId=10438
    [AFNHelp RequestWithHttpType:GET urlStr:@"https://test.api.d2cmall.com/v2/api/product/list?k=o" parameters:@{} success:^(NSDictionary *responseJson) {
        NSLog(@"%s",__func__);
        [self.operationQueue setSuspended:NO];

        dispatch_semaphore_signal(sema);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.operationQueue setSuspended:NO];

        dispatch_semaphore_signal(sema);

    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

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
