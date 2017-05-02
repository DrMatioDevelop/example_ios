//
//  main.m
//  example
//
//  Created by d2c_cyf on 16/11/29.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

        } @catch (NSException *exception) {
            NSLog(@"main_over");
        } @finally {
            NSLog(@"main_good");
        }
    }
}
