//
//  CSWK_ViewController.h
//  example
//
//  Created by d2c_cyf on 16/11/29.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface CSWK_ViewController : UIViewController
<
WKNavigationDelegate,   //WK代理
WKUIDelegate,           //提示  警告   输入框
WKScriptMessageHandler, //JS交互
UIWebViewDelegate
>
@end
