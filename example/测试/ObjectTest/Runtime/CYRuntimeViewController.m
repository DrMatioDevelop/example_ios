//
//  CYRuntimeViewController.m
//  example
//
//  Created by d2c_cyf on 16/12/1.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "CYRuntimeViewController.h"
#import "People.h"
#import <objc/runtime.h>
@interface CYRuntimeViewController ()
@property(strong,nonatomic)NSString *str;
@property(strong,nonatomic)People    *p;
@end

@implementation CYRuntimeViewController
- (void)dealloc {
    NSException *cratch = nil;
    @try {
        [_p removeObserver:self forKeyPath:@"pProperty.age"];
        [_p removeObserver:self forKeyPath:@"weight"];
    } @catch (NSException *exception) {
        cratch = exception;
    } @finally {
        if (cratch) {
            NSLog(@"%@",cratch.name);
        }
        else {
            NSLog(@"没有错误");
        }
    }
    
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self URLDecodeOrEncode];

    [self getAllIvarList];

    [self getProperty];

    [self getMethodList];

    
    [self observeKVO];
    
    [self exchangeMethod];




}
#pragma mark - KVO KVC
/**
 KVO 多次remove会导致崩溃，try catch 完美解决,但是如果没有观察的 keyPath被remove也会cratch；
 局部变量的KVO会导致崩溃;
 
 被观察者与观察者要严格的对应  不对应会导致崩溃
 */
- (void)observeKVO {
    _p = [[People alloc] init];
    
//    //对象被监听后 会创建一个新的类  并且新类会重写当前方法的所有方法
//    NSLog(@"%@",object_getClass(_p));

    [_p addObserver:self forKeyPath:@"pProperty.age" options:NSKeyValueObservingOptionNew context:nil];
    _p.pProperty.age = 1;
    _p.pProperty.age = 2;
    
    [_p addObserver:self forKeyPath:@"weight" options:NSKeyValueObservingOptionNew context:nil];
    _p.weight = 2;
    
//    NSLog(@"%@",object_getClass(_p));
    [People new];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"pProperty.age"]) {
        NSLog(@"%@",[object valueForKeyPath:@"pProperty.age"]);
    }
}

/**
 kvc测试
 */
- (void)kvcTest {
    People *p = [[People alloc] init];
    UILabel *label = [p valueForKey:@"peopleLabel"];
    label.origin = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:label];
    
    label.backgroundColor = [UIColor redColor];
    label.text = @"gg";
}

#pragma mark - Property Method
/**
 获取属性列表 \n
 * 可以获取类的属性 但是不能获取 分类中属性
 */
- (void)getAllIvarList {
    unsigned int methodCount = 0;
     Ivar *ivars = class_copyIvarList([People class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"propertyName:%-20s propertyType:%s",name,type);
    }
    free(ivars);
    NSLog(@"\n\n\n");
}

/**
 获取属性列表  参考：http://blog.csdn.net/u010123208/article/details/50589288
 可以获得分类中的属性
 */
- (void)getProperty {
    unsigned int methodCount = 0;
    //拿到属性列表
    objc_property_t *propertyList = class_copyPropertyList([People class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        objc_property_t property = propertyList[i];
        //属性名字
        const char *name      = property_getName(property);
        const char *attribute = property_getAttributes(property);
        if ([[NSString stringWithUTF8String:name] isEqualToString:@"peopleLabel"]) {
            [self kvcTest];
        }
        NSLog(@"propertyName:%-20s propertyType:%s",name,attribute);
    }
    free(propertyList);
    NSLog(@"\n\n\n");
}




/**
 获取一个类的方法列表;
 可以获取到类与分类中的实例方法,  类方法获取不到;
 同时可以获取property编译器 添加的默认get set方法;
 */
- (void)getMethodList {
    unsigned int count;
     Method *methods = class_copyMethodList([People class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        const char *methodName = sel_getName(methodSEL);
        NSLog(@"methodName:%-20s",methodName);
        const char *methodReturn =  method_copyReturnType(method);
        NSLog(@"methodReturn:%-20s\n\n",methodReturn);

    }
}


/**
 方法交换 替换方法
 */
- (void)exchangeMethod {
    People *p = [[People alloc] init];

    SEL originalSel = @selector(normalMsgSendTest:);
    SEL swizzedSel  = @selector(changeMethod:);
    
    //class_getInstanceMethod 获取实例方法   class_getClassMethod获取类方法
    Method originalMethod    = class_getInstanceMethod(p.class, originalSel);
    Method swizzledMethod    = class_getInstanceMethod(p.class, swizzedSel);
    
    //参数1.被添加方法的类 2.选择器的名称  3.事项这个方法的具体实现  4.实现这个方法的返回值以及参数的类型
    if (class_addMethod([People class], originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod([People class], swizzedSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);

    }
    
    
    
    [p normalMsgSendTest:@"today"];
    [p changeMethod:@"today"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)knowledge {
/**
 ivar 实例变量类型 指向了一个objc_ivar结构体的指针
 type struct objc_ivar *Ivar
 
 1.获取所有的成员变量
 class_copyIvarList
 2.获取成员的变量名
 ivar_getName
 3.获取成员变量的类型编码
 ivar_getTypeEncoding
 4.获取指定变量名的成员变量
 class_getInstanceVariable
 5.获取某个对象成员变量的值
 object_getIvar
 6.设置某个成员对象变量的值
 object_setIvar
 */
}

#pragma mark - Encode Decode
/**
 参数多次decode不会出现问题  但是多次encode会出现问题
 * 接受到encode的数据 没有进行处理  走网络层的AFN会自动加一次encode
 */
- (void)URLDecodeOrEncode {
    //k=%E7%9A%AE%E8%8D%89&token=
    NSString *picao = @"k=皮草&token=";
    NSLog(@"原始参数:%@",picao);
    picao = [@"k=皮草&token=" URLEncode];
    
    NSLog(@"Encode:%@",picao);
    picao = [picao URLDeCode];
    NSLog(@"firstDecode:%@",picao);
    picao = [picao URLDeCode];
    NSLog(@"secondDecode:%@",picao);
    picao = [picao URLDeCode];
    NSLog(@"thirdEDeode:%@",picao);
}
#pragma mark - KVOMethod
- (Class)createKvoClassWithOriginalClass:(nonnull NSString *)className {

    NSString *kvoClassName = [@"cyfKvoNotifi_" stringByAppendingString:className];
    Class observeClass     = NSClassFromString(className);
    if (observeClass) {
        return observeClass;
    }
    
    //创建新类
    Class originalClass = NSClassFromString(className);
    Class kvoClass      = objc_allocateClassPair(originalClass, kvoClassName.UTF8String, 0);
    
    Method classMethod  = class_getInstanceMethod(originalClass, @selector(class));
    const char * types  = method_getTypeEncoding(classMethod);
    //此处不知道如何处理 IMP  http://www.jianshu.com/p/742b4b248da9
//    class_addMethod(kvoClass, @selector(class), <#IMP imp#>, types);
    objc_registerClassPair(kvoClass);
    return kvoClass;
}

#pragma mark - Click

- (IBAction)msgSendEvent:(UIButton *)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Getter / Setter



@end
