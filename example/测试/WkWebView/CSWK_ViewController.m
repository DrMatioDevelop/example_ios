//
//  CSWK_ViewController.m
//  example
//
//  Created by d2c_cyf on 16/11/29.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "CSWK_ViewController.h"

@interface CSWK_ViewController ()
@property(nonatomic, strong)WKWebView *myWkWebView;
@end

@implementation CSWK_ViewController
- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //运行时对一个nil发送消息时  会返回nil
    NSArray *array = nil;
    [array objectAtIndex:100];
    NSLog(@"%@,%@ ",array,[NSNull null]);
    
    [self initUI];
    [self clickReload:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
    [self.tabBarController.tabBar setHidden:NO];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"发送请求之前,决定是否跳转:%s",__func__);
    NSLog(@"%@\n\n",navigationAction.request.URL.absoluteString);

    //网页代码
    NSString *doc = @"document.body.outerHTML";
    [self.myWkWebView evaluateJavaScript:doc
                     completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
                         if (error) {
                             NSLog(@"JSError:%@",error);
                         }
                         NSLog(@"thishtml:%@",htmlStr);
                     }] ;

    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"页面开始加载时调用:%s \n\n",__func__);
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"接受到服务器跳转的请求之后调用:%s\n\n",__func__);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"收到响应之后,决定是否跳转:%s\n\n",__func__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用:%s\n\n",__func__);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用:%s\n\n",__func__);
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用:%s\n\n",__func__);
}
#pragma mark - WKUIDelegate
// 界面弹出警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler {
    completionHandler();
}
// 界面弹出确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    completionHandler(YES);
}
// 界面弹出输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    completionHandler(@"德玛西亚");
}

#pragma mark - WKScriptMessageHandler 

/**
 JavaScapt调用OC

 @param userContentController <#userContentController description#>
 @param message <#message description#>
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"showMobile"]) {
        [self showMsg:@"小明的手机号码"];
    }
    else if ([message.name isEqualToString:@"showName"] || [message.name isEqualToString:@"showSendMsg"]) {
        if ([message.body isKindOfClass:[NSArray class]]) {
            [self showMsg:[NSString stringWithFormat:@"小明的手机号码:%@  %@",[message.body objectAtIndex:0],[message.body objectAtIndex:1]]];
        }
        else if ([message.body isKindOfClass:[NSDictionary class]]){
            [self showMsg:[NSString stringWithFormat:@"小明的手机号码message:%@ mobile:%@",[message.body objectForKey:@"message"],[message.body objectForKey:@"mobile"]]];
        }
        else {
            [self showMsg:message.body];
        }
    }

}
#pragma mark - UI
- (void)initUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 44.0, 44.0);
    [btn setTitle:@"reload" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickReload:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtons = @[btn];
    
    
}

/**
 OC调用JavaScript

 @param btn <#btn description#>
 */
- (void)OCCallJavaScript:(UIButton *)btn {
    if (self.myWkWebView.loading) {
        return;
    }
    if (btn.tag == 0) { //清空    //第一个参数可以接收JavaScript的返回值
        [self.myWkWebView evaluateJavaScript:@"clear()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"clear:%@ %@",response,error);
        }];
    }
    else if (btn.tag == 1) { //mobile
        //JS要参与判断传递的参数类型防止发生错误
        NSString *dicParametes = @"{'WORK':'13312341234' , 'HOME' : '0571-88881234'}"; //传递字典
        NSString *arrayParametes = @"['13312341234','13512341234']";                   //传递数组
        
        NSString *jsFunction = [NSString stringWithFormat:@"alertMobile(%@)",arrayParametes];
        [self.myWkWebView evaluateJavaScript:jsFunction completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"alertMobile:%@ %@",response,error);
        }];
    }
}

- (void)clickReload:(UIButton *)btn {
    //request
    //http://test2.d2cmall.com/o2oSubscribe/my/list;jsessionid=074E6AC632C656EFC671A9F4D3E46E9F?invoked=1
    //http://www.d2cmall.com/page/520sheji
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test2.d2cmall.com/o2oSubscribe/my/list;jsessionid=074E6AC632C656EFC671A9F4D3E46E9F?invoked=1"]];
    [self.myWkWebView loadRequest:urlRequest];
    
    
    
    
//    //locol
//    //初始化时 设置config
////    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
////    config.preferences.minimumFontSize = 14;
//    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSBridgeOC.html" ofType:nil];
//    [self.myWkWebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:[[NSBundle mainBundle] bundleURL]];
//    WKUserContentController *userCC = self.myWkWebView.configuration.userContentController;
//    
//    //JavaScript调用OC
//    [userCC addScriptMessageHandler:self name:@"showMobile"];
//    [userCC addScriptMessageHandler:self name:@"showName"];
//    [userCC addScriptMessageHandler:self name:@"showSendMsg"];
//
//    //OC调用JavaScript
//    UIButton *clearButton = [KIUIContainerControl getButton:CGRectMake(0, 64.0, 50, 40) tag:0 target:self action:@selector(OCCallJavaScript:)];
//    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
//    [self.view addSubview:clearButton];
//    
//    UIButton *huanMobile = [KIUIContainerControl getButton:CGRectMake(60, 64, 70, 40) tag:1 target:self action:@selector(OCCallJavaScript:)];
//    [huanMobile setTitle:@"黄mobile" forState:UIControlStateNormal];
//    [self.view addSubview:huanMobile];
}
#pragma mark - Getter
- (WKWebView *)myWkWebView {
    if (!_myWkWebView) {
        _myWkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, SSize.width, SSize.height - 64 - 40)];
        _myWkWebView.navigationDelegate = self;
        _myWkWebView.UIDelegate = self;
        [self.view addSubview:_myWkWebView];
    }
    return _myWkWebView;
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil] show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
