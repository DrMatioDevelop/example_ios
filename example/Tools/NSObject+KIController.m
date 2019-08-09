//
//  NSObject+KIController.m
//  example
//
//  Created by 陈雁锋 on 2019/5/28.
//  Copyright © 2019 d2c_cyf. All rights reserved.
//

#import "NSObject+KIController.h"

@implementation NSObject (KIController)
- (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

- (UIViewController *)rootViewController; {
    return self.applicationDelegate.window.rootViewController;
}

- (UINavigationController*)currentNavigationViewController {
    UIViewController* currentViewController = [self currentViewController];
    return currentViewController.navigationController;
}

- (UIViewController *)currentViewController {
    UIViewController* rootViewController = self.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

/**
 *  返回当前的控制器,以viewController为节点开始寻找
 */
- (UIViewController*)currentViewControllerFrom:(UIViewController*)viewController {
    //传入的根节点控制器是导航控制器
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    //传入的根节点控制器是UITabBarController
    else if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    }
    //传入的根节点控制器是被展现出来的控制器
    else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

- (nullable UIViewController *)DJPopViewControllerAnimated:(BOOL)animated; {
    return [self.currentNavigationViewController popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)DJPopToRootViewControllerAnimated:(BOOL)animated; {
    return [self.currentNavigationViewController popToRootViewControllerAnimated:animated];
}

- (void)DJPushViewController:(UIViewController *)viewController animated:(BOOL)animated; {
    if (self.currentNavigationViewController.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self.currentNavigationViewController pushViewController:viewController animated:animated];
}
@end
