//
//  CustomLayout.m
//  Test_a
//
//  Created by d2c_cyf on 17/5/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "CustomLayout.h"
@interface CustomLayout ()
@property(nonatomic , strong)NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;
@property(nonatomic , strong)NSMutableArray<NSNumber *>                         *columnHeights;

- (NSInteger)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowmargin;
- (UIEdgeInsets)edgeInsets;
@end
@implementation CustomLayout
//collectionview 首次布局和之后重新布局的时候会调用
//并不是每次滑动都会调用  当数据源改变的时候会重新调用
- (void)prepareLayout {
    [super prepareLayout];
    
    //如果刷新清空高度数组  与布局数组重新计算
    
    //当高度数组为0的时候基础高度加上edge的top
    if (!self.columnHeights.count) {
        for (int i = 0; i < self.columnCount; i++) {
            [self.columnHeights addObject:@(self.edgeInsets.top)];
        }
    }
    
    //便利所有的cell
    for (NSInteger i = self.attrsArray.count; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        //计算布局属性 并添加到布局数组
        [self.attrsArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
}

//返回布局属性  数组每个item的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}
//返回collectionView的 contentsSize
- (CGSize)collectionViewContentSize {
    //取每列的最大值
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 1; i < self.columnHeights.count; i++) {
        CGFloat columnHeight = [[self.columnHeights objectAtIndex:i] doubleValue];
        if (columnHeight > maxColumnHeight) {
            maxColumnHeight = columnHeight;
        }
        
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}

//计算布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger ds = [[self.arrayDS objectAtIndex:indexPath.row] integerValue];
    
    //设置item的size
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    CGFloat itemWidth = 0;
    CGFloat itemHeigt = 0;
    
    itemWidth = (collectionViewWidth - self.edgeInsets.left - self.edgeInsets.right - self.columnMargin *(self.columnCount -1)) / self.columnCount;
    
    if (ds) {
        itemHeigt = itemWidth * 1.618;
    }
    else {
        itemHeigt = itemWidth;
    }
    
    //获取最小高度的列数
    NSInteger destColumn = 0;
    CGFloat   minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnHeights.count ; i++) {
        CGFloat columnHeight = [[self.columnHeights objectAtIndex:i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    //计算当前item的高度好宽度
    CGFloat x = self.edgeInsets.left + destColumn * (itemWidth + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowmargin;
    }
    
    attributes.frame = CGRectMake(x, y, itemWidth, itemHeigt);
    
    //把已经确认好的最大高度复制给 高度数组
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}
#pragma mark - Getter / Setter
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

- (NSMutableArray<NSNumber *> *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [[NSMutableArray alloc] init];
    }
    return _columnHeights;
}

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInCustomLayout:)]) {
        return [self.delegate columnCountInCustomLayout:self];
    }
    else {
        return 2;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInCustomLayout:)]) {
        return [self.delegate columnMarginInCustomLayout:self];
    }
    else {
        return 0;
    }
}

- (CGFloat)rowmargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInCustomLayout:)]) {
        return [self.delegate rowMarginInCustomLayout:self];
    }
    else {
        return 0;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInCustomLayout:)]) {
        return [self.delegate edgeInsetsInCustomLayout:self];
    }
    else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
