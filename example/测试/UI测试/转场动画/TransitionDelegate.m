//
//  TransitionDelegate.m
//  example
//
//  Created by d2c_cyf on 17/7/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "TransitionDelegate.h"
#import "PresentationController.h"
#import "AnimatedTransitioning.h"


@implementation TransitionDelegate
SingletonM(Transition)

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static TransitionDelegate *share;
    dispatch_once(&onceToken, ^{
        share = [[self alloc] init];
    });
    return share;
    
}
#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    AnimatedTransitioning *anima = [[AnimatedTransitioning alloc] init];
    anima.presented = YES;
    return anima;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AnimatedTransitioning *anim = [[AnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}
@end
