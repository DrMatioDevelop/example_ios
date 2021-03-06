//
//  AppDelegate.m
//  example
//
//  Created by d2c_cyf on 16/11/29.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "AppDelegate.h"
#import "KISignalHandeler.h"
#import "GGCrashManager.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    self.paws = [[MonkeyPaws alloc] init];
    //    [self.paws monkeyInitWithView:self.window];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [KISignalHandeler registerSignalhandler];
    [GGCrashManager startCatchCrash];
    // 界面的跳转(针对应用程序被杀死的状态下的跳转)
    // 杀死状态下的，界面跳转并不会执行下面的方法- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification，
    // 所以我们在写本地通知的时候，要在这个与下面方法中写，但要判断，是通过哪种类型通知来打开的
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        
        [application registerUserNotificationSettings:setting];
    }
    
    application.applicationIconBadgeNumber = 1;
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 跳转代码
        UILabel *redView = [[UILabel alloc] init];
        redView.frame = CGRectMake(0, 0, 200, 300);
        redView.numberOfLines = 0;
        redView.font = [UIFont systemFontOfSize:12.0];
        redView.backgroundColor = [UIColor redColor];
        
        UILocalNotification *loacl = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
        redView.text = [NSString stringWithFormat:@"dic1:%@", loacl.userInfo];
        [self.window.rootViewController.view addSubview:redView];
    }
    
//#if DEBUG
//    _paws = [[MonkeyPaws alloc] init];
//
//#endif
    
    return YES;
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // 必须要监听--应用程序在后台的时候进行的跳转
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"进行界面的跳转");
        // 如果在上面的通知方法中设置了一些，可以在这里打印额外信息的内容，就做到监听，也就可以根据额外信息，做出相应的判断
        NSLog(@"%@", notification.userInfo);
        
        //
        UILabel *redView = [[UILabel alloc] init];
        redView.frame = CGRectMake(0, 0, 200, 300);
        redView.backgroundColor = [UIColor redColor];
        redView.numberOfLines = 0;
        redView.font = [UIFont systemFontOfSize:12.0];
        redView.text = [NSString stringWithFormat:@"dic:%@", notification.userInfo];
        [self.window.rootViewController.view addSubview:redView];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"%@  %@  %@",app,url,options);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
