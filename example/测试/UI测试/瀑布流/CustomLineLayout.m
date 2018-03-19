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
static const CGFloat itemWH = 200;

//缩放时的有效距离
static const CGFloat activeDistance = 150;

//设置放大因数 值越大 缩放效果越明显
static const CGFloat scaleFactor = 0.38;


//UICollectionViewLayoutAttributes 布局属性
//每一个item都有自己的       UICollectionViewLayoutAttributes
//每一个indexPath都有自己的  UICollectionViewLayoutAttributes



/**
 每一次重新布局钱 都会准备布局 官方推荐使用改方法进行一些初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing =  itemWH * scaleFactor;
    
    //将第一个和最后一个item始终显示在中间,即分别将它们设置到组头和组尾的距离
    CGFloat inset     = (self.collectionView.frame.size.width - itemWH) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}


/**
 是否需要重新刷新布局（只要显示的item边界发生改变就重新布局）
 只要每一次重新布局 内部就会调用下面的layoutAttributesForElementsInRect：获取item的属性
 @param newBounds <#newBounds description#>
 @return <#return value description#>
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


/**
 用来设置collectionView停止滚动的那一刻位置  内容部会自动调用
 targetContentOffset：原本collectionView停止滚动的那一刻位置
 @param proposedContentOffset <#proposedContentOffset description#>
 @param velocity 滚动的速率 根据正负可以判断滚动防线是向左还是向右
 @return <#return value description#>
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //1、计算collectionView最终停留的位置
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size   = self.collectionView.frame.size;
    
    //2、取出这个范围内的所有item的属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    //3、计算最终屏幕的中心x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2.0;
    
    //4、便利所有的属性，通过计算item与最终屏幕
    CGFloat adjustOffectX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attris in array) {
        if (ABS(attris.center.x - centerX) < ABS(adjustOffectX)) {
            adjustOffectX = attris.center.x - centerX;
        }
    }
    //5、返回要移动到中心item的位置
    return CGPointMake(proposedContentOffset.x + adjustOffectX, proposedContentOffset.y);
}


/**
 返回需要重新布局的所有item属性

 @param rect <#rect description#>
 @return <#return value description#>
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //0 计算可见的矩形框属性
    CGRect visiableReact;
    visiableReact.size   = self.collectionView.frame.size;
    visiableReact.origin = self.collectionView.contentOffset;
    
    //1、取出可见矩形框的属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕最中心的X（滚出去的所有item的偏移 + collectionView宽度的一半）
    CGFloat contentX = self.collectionView.contentOffset.x + self.collectionView.size.width / 2.0;
    
    //2.便利所有的布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //如果便利的item和可见的矩形框frame不相交，即不是可见的，直接跳过，只对可见的item进行布局
        if (!CGRectIntersectsRect(visiableReact, attrs.frame)) {
            continue;
        }
        
        //每一个item的中心X
        CGFloat itemCenterX = attrs.center.x;
        
        //差距越大，缩放比例越小
        //计算每一个item的中心X和屏幕中心X的绝对值距离，然后可以计算出缩放比例
        //当item的中心X距离屏幕在有效距离以内时（activeDistance），item才开始变大
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
