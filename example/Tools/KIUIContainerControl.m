//
//  KIUIContainerControl.m
//  example
//
//  Created by d2c_cyf on 17/5/17.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "KIUIContainerControl.h"

@implementation KIUIContainerControl
+ (UIColor *)radomColor {
    return [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:arc4random()%1 / 1.0];
}

+ (UILabel *)getLabel:(CGRect)frame {
    UILabel *lable = [[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor = [UIColor whiteColor];
    lable.textAlignment   = NSTextAlignmentCenter;
    lable.textColor       = [UIColor blackColor];
    lable.font            = [UIFont systemFontOfSize:15];
    return lable;
}

+ (UILabel *)getSpecificLabel:(CGRect)frame text:(NSString *)text backGroundColor:(UIColor *)backGroundColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *lable = [[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor = backGroundColor;
    lable.textAlignment   = textAlignment;
    lable.textColor       = textColor;
    lable.text            = text;
    lable.font            = [UIFont systemFontOfSize:15];
    return lable;
}

+ (UIButton *)getButton:(CGRect)frame tag:(NSInteger)tag target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.titleLabel.textAlignment   = NSTextAlignmentCenter;
    button.titleLabel.backgroundColor = [UIColor cyanColor];
    button.titleLabel.font            = [UIFont systemFontOfSize:15];
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)getSpecificButton:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor
                          image:(UIImage *)image backGroundColor:(UIColor *)backGroundColor tag:(NSInteger)tag
                         target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.titleLabel.textAlignment   = NSTextAlignmentCenter;
    button.titleLabel.backgroundColor = backGroundColor;
    button.titleLabel.font            = [UIFont systemFontOfSize:15];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:controlEvents];
    return button;
}

+ (UIImageView *)getImageView:(CGRect)frame image:(UIImage *)image blank:(BOOL)blankFlag {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (blankFlag) {
        UIGraphicsBeginImageContext(frame.size);
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageView.image = newImage;
    }else{
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return imageView;
}

@end
