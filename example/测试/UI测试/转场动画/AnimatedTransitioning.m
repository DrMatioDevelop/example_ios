//
//  AnimatedTransitioning.m
//  example
//
//  Created by d2c_cyf on 17/7/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "AnimatedTransitioning.h"

const NSTimeInterval duration = 1.0;
@implementation AnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    //动画执行时间
    return duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //创建控制器
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.x = toView.width;
        [UIView animateWithDuration:duration animations:^{
            toView.x = 40;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    //销毁控制器
    else {
        [UIView animateWithDuration:duration animations:^{
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            fromView.x = - fromView.width;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}
@end
