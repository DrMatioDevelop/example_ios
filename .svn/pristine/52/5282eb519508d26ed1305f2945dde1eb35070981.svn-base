//
//  CYRuntimeViewController.m
//  example
//
//  Created by d2c_cyf on 16/12/1.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "CYRuntimeViewController.h"
#import "example-swift.h"
#import "People.h"
#import <objc/runtime.h>
@interface CYRuntimeViewController ()
@property(strong,nonatomic)NSString *str;
@property(strong,nonatomic)People    *p;
@end

@implementation CYRuntimeViewController
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"str"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //k=%E7%9A%AE%E8%8D%89&token=
    NSString *picao = [@"k=皮草&token=" URLEncode];
    NSLog(@"%@",picao);
    picao = [picao URLDeCode];
    NSLog(@"%@",picao);
    picao = [picao URLDeCode];
    NSLog(@"%@",picao);
    picao = [picao URLDeCode];
    NSLog(@"%@",picao);


//    [self getAllIvarList];
//    
//    [self getProperty];
//    
//    
//    self.p = [[People alloc] init];
//    [self addObserver:self forKeyPath:@"str" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    self.str = @"gg";
//    self.p.likely = @"我的";
//    self.p.likely = @"你的";
//    
//    HUDSucess(@"德玛西亚永世长存1,德玛西亚永世长存2,德玛西亚永世长存3,德玛西亚永世长存4,德玛西亚永世长存5");


}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@",[object valueForKey:@"str"]);
//}
- (void)getAllIvarList {
    unsigned int methodCount = 0;
    Ivar *ivars = class_copyIvarList([People class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"people属性名:%s 属性类型:%s",name,type);
    }
    free(ivars);
}
- (void)getProperty {
    unsigned int methodCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([People class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        NSLog(@"PeopleName:%s",name);
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
