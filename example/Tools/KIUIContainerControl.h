//
//  KIUIContainerControl.h
//  example
//
//  Created by d2c_cyf on 17/5/17.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>


//快速创建子控件
@interface KIUIContainerControl : NSObject

/**
 随机颜色

 @return 颜色
 */
+ (UIColor *)radomColor;


/**
 UILabel

 @param frame fram
 @return 普通UILabel
 */
+ (UILabel *)getLabel:(CGRect)frame;


/**
 自定义的label

 @param frame frmae
 @param text  文字
 @param backGroundColor 背景颜色
 @param textColor       字体颜色
 @param textAlignment   文字居中方式
 @return label
 */
+ (UILabel *)getSpecificLabel:(CGRect)frame text:(NSString *)text backGroundColor:(UIColor *)backGroundColor
                    textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;


/**
 自带点击事件的UIButton

 @param frame frame
 @param target target
 @param action action
 @return button
 */
+ (UIButton *)getButton:(CGRect)frame tag:(NSInteger)tag target:(id)target action:(SEL)action;

+ (UIButton *)getSpecificButton:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor
                          image:(UIImage *)image backGroundColor:(UIColor *)backGroundColor tag:(NSInteger)tag
                         target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


/**
 UIImageView

 @param frame frame
 @param image UIImage
 @param blankFlag 是否为空？
 @return UIImageView
 */
+ (UIImageView *)getImageView:(CGRect)frame image:(UIImage *)image blank:(BOOL)blankFlag;
@end
