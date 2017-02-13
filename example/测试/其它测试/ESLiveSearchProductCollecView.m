//
//  ESLiveSearchProductCollecView.m
//  example
//
//  Created by d2c_cyf on 17/1/5.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveSearchProductCollecView.h"
#import "ESLiveProductListCell.h"
@interface ESLiveSearchProductCollecView ()
@property(nonatomic, strong)NSArray    *arrayDS;
@end
@implementation ESLiveSearchProductCollecView
- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        self.delegate   = self;
        self.dataSource = self;
        [self registerClass:[ESLiveProductListCell class] forCellWithReuseIdentifier:@"productCell"];
//        [self registerClass:[ESLiveSearchProductReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"searchCell"];
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)setSearchProductWithModel:(id)model {
    self.arrayDS = model;
    self.arrayDS = @[@"1", @"2", @"3",@"4"];
    [self reloadData];
}
#pragma makr - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self) {
        return;
    }
    if (self.scrollSearchListBlock) {
        self.scrollSearchListBlock();
    }
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayDS.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ESLiveProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"productCell" forIndexPath:indexPath];
    [cell setLiveProductListCellWithModel:@"" isSearch:YES];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [ESLiveProductListCell getProductListCellSize];
}

@end
