//
//  UITableView+Extension.h
//  example
//
//  Created by d2c_cyf on 17/8/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SectionIndexView;

@interface UITableView (Extension)
@property(nonatomic, strong)SectionIndexView *indexView;

- (void)layoutCustomIndexView;
@end



@interface SectionIndexView : UIView
@property(nonatomic, strong)NSArray *sectionTitles;
@property(nonatomic, strong)UIColor *letterColor;
@property(nonatomic, strong)UIFont *letterFont;

//??
@property(nonatomic, strong)UIColor *letterTrackingColor;
@property(nonatomic, strong)UIColor *letterBGColor;
- (instancetype)initOfSectionTiltle:(NSArray *)sectionTitles letterColor:(UIColor *)letterColor letterFont:(UIFont *)letterFont letterBGColor:(UIColor *)letterBGColor;
@end
