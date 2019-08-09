//
//  FSLoadingHUD.h
//  flashing
//
//  Created by 陈雁锋 on 2018/4/28.
//  Copyright © 2018年 best. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class FSHUDCustomView;
@interface FSLoadingHUD : NSObject

+ (instancetype)shareInstance;

/**
 开始Loading

 @param view 父视图，view==nil 添加都keywindow上
 */
- (void)showAnimationWhenLoadingWith:(UIView *)view;


/**
 停止loading（默认动画 0.5秒后消失）
 loading计数重置为0
 */
- (void)stopAllLoadingAnimation;


/**
 loading计数减1，如果减1后未0，则停止loading（动画 0.5秒后消失）
 */
- (void)stopLoadingAnimation;

/**
 HUD文字, 无icon

 @param message 消息
 @param subView 父视图，view==nil 添加都keywindow上
 */
- (void)HUDOfMessage:(NSString *)message subView:(UIView *)subView;


/**
 HUDSuccess 对号

 @param message 消息
 @param subView 父视图
 */
- (void)HUDSuccessOfMsg:(NSString *)message subView:(UIView *)subView;


/**
 HUDFailure 叉号

 @param message 消息
 @param subView 父视图
 */
- (void)HUDFailureOfMsg:(NSString *)message subView:(UIView *)subView;
@end



//@interface FSHUDCustomView : UIView
//@property(nonatomic, strong)FSBaseLabel *titleLab;
//@property(nonatomic, strong)UIImageView *imgView;
//
//
//- (void)setHUDCustomViewOfTitle:(NSString *)title imgName:(NSString *)imgName;
//@end
