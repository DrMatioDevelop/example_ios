//
//  MsgSend_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/4/17.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "MsgSend_ViewController.h"

@interface MsgSend_ViewController ()

@end

@implementation MsgSend_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self msgSendTest];
    
    
}
+ (void)load {
    NSLog(@"%s",__func__);
}
+ (void)initialize {
    NSLog(@"%s",__func__);
}


/**
 msgSend 消息机制  xcode5之后需要自己开启
 */
////msgSend 是一个消息机制，会首先像class发送消息，如果class不存在就返回一个nil，像nil发送消息会返回nil
////msgSend 可以访问一个class的public方法与private方法  但是不能防卫类方法？
- (void)msgSendTest {
    id p =  objc_msgSend(objc_getClass("Peoplefsfsdfdsfsd"), sel_registerName("alloc"), sel_registerName("init"));
    objc_msgSend(p, @selector(normalMsgSendTest:),@"cyf");
    objc_msgSend(p, sel_registerName("normalMsgSendTest:"),@"chen");
    objc_msgSend(p, sel_registerName("createBigHouse"));
    UILabel *label =  ((UILabel * (*)(Class,SEL,NSArray *))objc_msgSend)(p, sel_registerName("createSmallCar:"),@[@"cyf",@"god like"]);
    
    [self.view addSubview:label];
    @try {
        objc_msgSend(p, @selector(classMsgSendTest:), @"god like");
    } @catch (NSException *exception) {
        NSLog(@"%s error",__FUNCTION__);
    } @finally {
        
    }
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
