//
//  HotFix_ViewController.m
//  example
//
//  Created by d2c_cyf on 2018/3/12.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "HotFix_ViewController.h"
#import "KIHotFixTool.h"
#import "KIHotFixTest.h"


@interface HotFix_ViewController ()

@end

@implementation HotFix_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //尝试修复
    [KIHotFixTool fixIt];
    NSString *fixScriptString =
    @" \
    fixInstanceMethodReplace('KIHotFixTest', 'divideUsingAnimotion:', function(instance, originInvocation, originArguments){ \
    console.log(instance + ' ' + originInvocation + ' ' + originArguments); \
    if (originArguments[0] == 0) { \
    console.log('zero goes here'); \
    alert(100);\
    } else { \
    runInvocation(originInvocation); \
    } \
    }); \
    \
    ";
    [KIHotFixTool evalString:fixScriptString];

    
    KIHotFixTest *test = [[KIHotFixTest alloc] init];
    
    //此时crash
    CGFloat number = [test divideUsingAnimotion:0];
    NSLog(@"结果:%lf",number);
}


//$.D2CMerchantBridge=function(data,jscallback){
//    //终端判断
//    var u = navigator.userAgent;
//    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
//    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
//                          if(isAndroid){
//                              //call android native method
//                              try{
//                                  window.WebViewJavascriptBridge.callHandler(
//                                                                             'd2cinit'
//                                                                             , data
//                                                                             , function(responseData) {
//                                                                                 //console.log(responseData)
//                                                                             }
//                                                                             );
//                              }catch(err){
//                                  //console.log(err)
//                              }
//
//                              function connectWebViewJavascriptBridge(callback) {
//                                  if (window.WebViewJavascriptBridge) {
//                                      callback(WebViewJavascriptBridge)
//                                  } else {
//                                      document.addEventListener(
//                                                                'WebViewJavascriptBridgeReady'
//                                                                , function() {
//                                                                    callback(WebViewJavascriptBridge)
//                                                                },
//                                                                false
//                                                                );
//                                  }
//                              }
//                              connectWebViewJavascriptBridge(function(bridge) {
//                                  bridge.init(function(message, responseCallback) {
//                                      // responseCallback(data);
//                                  });
//                                  //注册JS回调方法
//                                  bridge.registerHandler("cessback", function(data, responseCallback) {
//                                      // responseCallback(responseData);
//                                      if( jscallback ) jscallback(true);
//
//                                  });
//                              })
//                          }else if(isiOS){
//                              try{
//                                  window.webkit.messageHandlers.d2cinit.postMessage(data);
//                              }catch(err){
//
//                              }
//                          }
//                          },

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
