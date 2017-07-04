//
//  Transition_ViewController.h
//  example
//
//  Created by d2c_cyf on 17/6/27.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//
// 转场动画
#import <UIKit/UIKit.h>
@class Model;
@interface Transition_ViewController : UIViewController

@end


/**
 * 在控制器新定义一个模型类
 */
@interface Model : NSObject
/**
 *  可变的数组
 */
@property (strong,nonatomic)NSMutableArray *modelArray;

@end
