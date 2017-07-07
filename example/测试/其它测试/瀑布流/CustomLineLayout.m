//
//  CustomLineLayout.m
//  example
//
//  Created by d2c_cyf on 17/7/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "CustomLineLayout.h"

@implementation CustomLineLayout
//item的固定宽高
static const CGFloat itemWH = 100;

//缩放时的有效距离
static const CGFloat activeDistance = 150;

//设置放大因数 值越大 缩放效果越明显
static const CGFloat scaleFactor = 0.6;


- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = itemWH * scaleFactor;
    
    //将第一个和最后一个item始终显示在中间,即分别将它们设置到组头和组尾的距离
    CGFloat inset = (self.collectionView.frame.size.width - itemWH) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size   = self.collectionView.frame.size;
    
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2.0;
    
    CGFloat adjustOffectX = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attris in array) {
        if (ABS(attris.center.x - centerX) < ABS(adjustOffectX)) {
            adjustOffectX = attris.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustOffectX, proposedContentOffset.y);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //0 计算可见的矩形框属性
    CGRect visiableReact;
    visiableReact.size   = self.collectionView.frame.size;
    visiableReact.origin = self.collectionView.contentOffset;
    
    //
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat contentX = self.collectionView.contentOffset.x + self.collectionView.size.width / 2.0;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (!CGRectIntersectsRect(visiableReact, attrs.frame)) {
            continue;
        }
        
        CGFloat itemCenterX = attrs.center.x;
        
        if (ABS(itemCenterX - contentX) <= activeDistance) {
            CGFloat ratio = ABS(itemCenterX-contentX) / activeDistance;
            
            CGFloat scale = 1 + scaleFactor * (1-ratio);
            attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
        }
        else {
            attrs.transform = CGAffineTransformMakeScale(1, 1);
        }
    }
    return array;
}
@end
