//
//  ObjectCOther_ViewController.h
//  example
//
//  Created by d2c_cyf on 17/7/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
//
extern NSString * const testChangLiangNotification;
@class ObjectCOther_KVCTest;

@interface ObjectCOther_ViewController : UIViewController
@property(nonatomic, assign, readonly, getter=isOtherNameFlag)BOOL otherNameFlag;

@end





/**
 KVC对readonly测试
 */
@interface ObjectCOther_KVCTest : NSObject
@property(nonatomic, strong, readonly)NSString *myname;
@end
