//
//  NSObject+KIController.h
//  example
//
//  Created by 陈雁锋 on 2019/5/28.
//  Copyright © 2019 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KIController)
/**
 *  根控制器
 *
 *  @return <#return value description#>
 */
- (UIViewController *)rootViewController;
/**
 *  当前导航控制器
 *
 *  @return <#return value description#>
 */
- (UINavigationController*)currentNavigationViewController;
/**
 *  当前控制器
 *
 *  @return <#return value description#>
 */
- (UIViewController *)currentViewController;



/**
 == popViewController
 
 @param animated <#animated description#>
 @return <#return value description#>
 */
- (nullable UIViewController *)DJPopViewControllerAnimated:(BOOL)animated;


/**
 == PopToRootViewControllerAnimated
 
 @param animated <#animated description#>
 @return <#return value description#>
 */
- (nullable NSArray<__kindof UIViewController *> *)DJPopToRootViewControllerAnimated:(BOOL)animated;



/**
 == PushViewController
 
 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
- (void)DJPushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
