//
//  CustomLayout.h
//  Test_a
//
//  Created by d2c_cyf on 17/5/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomLayout;
@protocol CustomLayoutDelegate <NSObject>

- (NSInteger)columnCountInCustomLayout:(CustomLayout *)customLayout;
- (CGFloat)columnMarginInCustomLayout:(CustomLayout *)customLayout;
- (CGFloat)rowMarginInCustomLayout:(CustomLayout *)customLayout;
- (UIEdgeInsets)edgeInsetsInCustomLayout:(CustomLayout *)customLayout;
@end


@interface CustomLayout : UICollectionViewLayout
@property (nonatomic, weak) id<CustomLayoutDelegate> delegate;
@property (nonatomic, strong)NSArray               *arrayDS;
@end
