//
//  UITableView+Extension.m
//  example
//
//  Created by d2c_cyf on 17/8/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
//swift 访问权限 open, public , internal, filePrivate, private
- (UIView *)indexView {
    SectionIndexView *object = objc_getAssociatedObject(self, @selector(indexView));
    return object;
}
- (void)setIndexView:(SectionIndexView *)indexView {
    objc_setAssociatedObject(self, @selector(indexView), indexView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)layoutCustomIndexView {
    CGFloat tableView_W = self.bounds.size.width;
    CGFloat tableView_H = self.bounds.size.height;
//    CGFloat tableView_X = self.frame.origin.x;
    CGFloat tableView_Y = self.frame.origin.y;
    
    UIEdgeInsets tableViewInsets = self.contentInset;
    
    CGFloat customW = 55.0;
    CGFloat customX = tableView_W - customW;
    CGFloat customH = (tableView_H - tableViewInsets.top - tableViewInsets.bottom) * 0.71;
    CGFloat custimY = (tableView_H - tableViewInsets.top - tableViewInsets.bottom) * 0.29 * 0.5 + tableView_Y + tableViewInsets.top;
    
    self.indexView.frame = CGRectMake(customX, custimY, customW, customH);
    [self.superview addSubview:self.indexView];
    NSInteger indexCount = self.indexView.sectionTitles.count;
    
    for (NSInteger i = 0; i < indexCount; i++) {
        UILabel *label = [self.indexView.subviews objectAtIndex:i];
        
        CGFloat labelX = 0.0;
        CGFloat labelH = customH / (CGFloat)indexCount;
        CGFloat labelY = labelH * i;
        CGFloat labelW = (CGFloat)50;
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        NSLog(@"%@",label.text);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.indexView addGestureRecognizer:tap];
    [self.indexView addGestureRecognizer:pan];
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    UIView *view = tapGesture.view;
    
    CGFloat touchY = [tapGesture locationInView:view].y;
    NSInteger index = (NSInteger)(touchY / view.bounds.size.height * self.indexView.sectionTitles.count);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
    
    @try {
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } @catch (NSException *exception) {
        NSAssert(NO, @"组的数据为0 需要添加try catch finally");

    } @finally {
        
    }
    UILabel *letterLabel = view.subviews[index];
    
    if (tapGesture.state == UIGestureRecognizerStateBegan) {
        letterLabel.backgroundColor = self.indexView.letterTrackingColor;
    }
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        letterLabel.backgroundColor = self.indexView.letterBGColor;
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)panGesture {
    UIView *view = panGesture.view;
    CGFloat panY = [panGesture locationInView:view].y;
    NSInteger index = (NSInteger)(panY / view.bounds.size.height * self.indexView.sectionTitles.count);
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
//        self.indexView.
    }
    if (panGesture.state == UIGestureRecognizerStateEnded) {
//
    }
    
    if (index < 0 || index > self.numberOfSections - 1) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        @try {
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:false];
        } @catch (NSException *exception) {
            NSAssert(NO, @"组的数据为0 需要添加try catch finally");
            NSLog(@"%@",exception);
        } @finally {
            
        }
    }
    
}
@end



@implementation SectionIndexView

- (instancetype)initOfSectionTiltle:(NSArray *)sectionTitles letterColor:(UIColor *)letterColor letterFont:(UIFont *)letterFont letterBGColor:(UIColor *)letterBGColor {
    if (self = [super init]) {
        self.sectionTitles = sectionTitles;
        self.letterColor  = letterColor;
        self.letterFont   = letterFont;
        self.letterBGColor = letterBGColor;
        self.backgroundColor = [UIColor yellowColor];
        
        for (NSString *title in self.sectionTitles) {
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.textColor = self.letterColor;
            label.font      = self.letterFont;
            label.textAlignment = NSTextAlignmentRight;
            [self addSubview:label];
        }
    }
    return self;
}

@end
