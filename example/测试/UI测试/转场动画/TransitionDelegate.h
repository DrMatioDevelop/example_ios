//
//  TransitionDelegate.h
//  example
//
//  Created by d2c_cyf on 17/7/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface TransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>
SingletonH(Transition)

+ (instancetype)shareInstance;
@end
