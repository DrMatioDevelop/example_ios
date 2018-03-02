//
//  KINSTestViewController.h
//  example
//
//  Created by d2c_cyf on 2018/2/27.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KIWeakStrongVC;

@interface KINSTestViewController : UIViewController
@end




@interface KIWeakStrongVC : UIViewController
@property (nonatomic, copy)void(^block)();

@end
