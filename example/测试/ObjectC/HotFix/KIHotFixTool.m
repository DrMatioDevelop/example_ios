//
//  KIHotFixTool.m
//  example
//
//  Created by d2c_cyf on 2018/3/12.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KIHotFixTool.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation KIHotFixTool
+ (instancetype)shareInstance {
    static KIHotFixTool *shareinstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareinstance = [[self alloc] init];
    });
    return shareinstance;
}

+ (JSContext *)contextShareInstance {
    static JSContext *_context;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _context = [[JSContext alloc] init];
        [_context setExceptionHandler:^(JSContext *context, JSValue *exception) {
            NSLog(@"oops:%@",exception);
        }];
    });
    return _context;
}

+ (void)evalString:(NSString *)javaScriptString {
    [[self contextShareInstance] evaluateScript:javaScriptString];
}

+ (void)_fixWithMethod:(BOOL)isClassMethod
      aspectionOptions:(AspectOptions)option
          instanceName:(NSString *)instanceName
               selName:(NSString *)selName
               fixImpl:(JSValue *)fixImpl {

    Class kclass = NSClassFromString(instanceName);
    if (isClassMethod) {
        kclass = object_getClass(kclass);
    }
    SEL sel = NSSelectorFromString(selName);
    [kclass aspect_hookSelector:sel withOptions:option usingBlock:^(id<AspectInfo> aspectInfo){
        [fixImpl callWithArguments:@[aspectInfo.instance, aspectInfo.originalInvocation, aspectInfo.arguments]];
    } error:nil];

}

+ (id)_runClassWithClassName:(NSString *)className selName:(NSString *)selName obj1:(id)obj1 obj2:(id)obj2 {
    Class klass = NSClassFromString(className);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [klass performSelector:NSSelectorFromString(selName) withObject:obj1 withObject:obj2];
#pragma clang diagnostic pop
}

//+ (id)_runInstanceWithInstance:(id)instance selector:(NSString *)selector obj1:(id)obj1 obj2:(id)obj2 {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    return [instance performSelector:NSSelectorFromString(selector) withObject:obj1 withObject:obj2];
//#pragma clang diagnostic pop
//}

+ (id)_runInstanceWithInstance:(id)instance selName:(NSString *)selName obj1:(id)obj1 obj2:(id)obj2 {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [instance performSelector:NSSelectorFromString(selName) withObject:obj1 withObject:obj2];
#pragma clang diagnostic pop
}

+ (void)fixIt {
    [self contextShareInstance][@"fixInstanceMethodBefore"] = ^(NSString *instanceName, NSString *selectorName, JSValue *fixImpl) {
        [self _fixWithMethod:NO aspectionOptions:AspectPositionBefore instanceName:instanceName selName:selectorName fixImpl:fixImpl];
    };

    [self contextShareInstance][@"fixInstanceMethodReplace"] = ^(NSString *instanceName, NSString *selectorName, JSValue *fixImpl) {
        [self _fixWithMethod:NO aspectionOptions:AspectPositionInstead instanceName:instanceName selName:selectorName fixImpl:fixImpl];
    };
    
    [self contextShareInstance][@"fixInstanceMethodAfter"] = ^(NSString *instanceName, NSString *selectorName, JSValue *fixImpl) {
        [self _fixWithMethod:NO aspectionOptions:AspectPositionAfter instanceName:instanceName selName:selectorName fixImpl:fixImpl];
    };
    
    [self contextShareInstance][@"fixClassMethodBefore"] = ^(NSString *instanceName, NSString *selectorName, JSValue *fixImpl) {
        [self _fixWithMethod:YES aspectionOptions:AspectPositionBefore instanceName:instanceName selName:selectorName fixImpl:fixImpl];
    };
    
    [self contextShareInstance][@"fixClassMethodReplace"] = ^(NSString *instanceName, NSString *selectorName, JSValue *fixImpl) {
        [self _fixWithMethod:YES aspectionOptions:AspectPositionInstead instanceName:instanceName selName:selectorName fixImpl:fixImpl];
    };
    
    [self contextShareInstance][@"fixClassMethodAfter"] = ^(NSString *instanceName, NSString *selectorName, JSValue *fixImpl) {
        [self _fixWithMethod:YES aspectionOptions:AspectPositionAfter instanceName:instanceName selName:selectorName fixImpl:fixImpl];
    };
    
    [self contextShareInstance][@"runClassWithNoParamter"] = ^id(NSString *className, NSString *selectorName) {
        return [self _runClassWithClassName:className selName:selectorName obj1:nil obj2:nil];
    };
    
    [self contextShareInstance][@"runClassWith1Paramter"] = ^id(NSString *className, NSString *selectorName, id obj1) {
        return [self _runClassWithClassName:className selName:selectorName obj1:obj1 obj2:nil];
    };
    
    [self contextShareInstance][@"runClassWith2Paramters"] = ^id(NSString *className, NSString *selectorName, id obj1, id obj2) {
        return [self _runClassWithClassName:className selName:selectorName obj1:obj1 obj2:obj2];
    };
    
    [self contextShareInstance][@"runVoidClassWithNoParamter"] = ^(NSString *className, NSString *selectorName) {
        [self _runClassWithClassName:className selName:selectorName obj1:nil obj2:nil];
    };
    
    [self contextShareInstance][@"runVoidClassWith1Paramter"] = ^(NSString *className, NSString *selectorName, id obj1) {
        [self _runClassWithClassName:className selName:selectorName obj1:obj1 obj2:nil];
    };
    
    [self contextShareInstance][@"runVoidClassWith2Paramters"] = ^(NSString *className, NSString *selectorName, id obj1, id obj2) {
        [self _runClassWithClassName:className selName:selectorName obj1:obj1 obj2:obj2];
    };
    
    [self contextShareInstance][@"runInstanceWithNoParamter"] = ^id(id instance, NSString *selectorName) {
        return [self _runClassWithClassName:instance selName:selectorName obj1:nil obj2:nil];
    };
    
    [self contextShareInstance][@"runInstanceWith1Paramter"] = ^id(id instance, NSString *selectorName, id obj1) {
        return [self _runClassWithClassName:instance selName:selectorName obj1:obj1 obj2:nil];
    };
    
    [self contextShareInstance][@"runInstanceWith2Paramters"] = ^id(id instance, NSString *selectorName, id obj1, id obj2) {
        return [self _runClassWithClassName:instance selName:selectorName obj1:obj1 obj2:obj2];
    };
    
    [self contextShareInstance][@"runVoidInstanceWithNoParamter"] = ^(id instance, NSString *selectorName) {
        [self _runClassWithClassName:instance selName:selectorName obj1:nil obj2:nil];
    };
    
    [self contextShareInstance][@"runVoidInstanceWith1Paramter"] = ^(id instance, NSString *selectorName, id obj1) {
        [self _runClassWithClassName:instance selName:selectorName obj1:obj1 obj2:nil];
    };
    
    [self contextShareInstance][@"runVoidInstanceWith2Paramters"] = ^(id instance, NSString *selectorName, id obj1, id obj2) {
        [self _runClassWithClassName:instance selName:selectorName obj1:obj1 obj2:obj2];
    };
    
    [self contextShareInstance][@"runInvocation"] = ^(NSInvocation *invocation) {
        [invocation invoke];
    };
    
    [[self contextShareInstance] evaluateScript:@"var console = {}"];
    [self contextShareInstance][@"console"][@"log"] = ^(id message) {
        NSLog(@"Javascript log:%@",message);
    };
}
@end
