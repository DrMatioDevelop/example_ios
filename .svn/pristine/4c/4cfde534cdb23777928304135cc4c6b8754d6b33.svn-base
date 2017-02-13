//
//  ESLiveProductCollectionView.m
//  example
//
//  Created by d2c_cyf on 17/1/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveProductCollectionView.h"
#import "ESLiveProductHeadCell.h"
#import "ESLiveProductListCell.h"
@interface ESLiveProductCollectionView ()
@property(nonatomic, strong)NSArray *arrayDS;
@end
@implementation ESLiveProductCollectionView
-(void)dealloc {
    NSLog(@"%s",__func__);
}
-(instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection  = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing      = 0;
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        self.delegate   = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[ESLiveProductHeadCell class] forCellWithReuseIdentifier:@"headCell"];
        [self registerClass:[ESLiveCouponAndCrowdCell class] forCellWithReuseIdentifier:@"couponAndCrowdCell"];
        [self registerClass:[ESLiveProductListCell class] forCellWithReuseIdentifier:@"listCell"];
    }
    return self;
}

#pragma mark - func
- (void)productListReload:(id)model {
    self.arrayDS = model;
    [self reloadData];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
//    return self.arrayDS.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return  1;
    }
    else {
        return 10;
    }
//    return self.arrayDS.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ESLiveProductHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headCell" forIndexPath:indexPath];
        [cell setLiveProductHeadWithModel:@""];
        cell.backgroundColor = ColorRGBA(0, 0, 0, 0.6);
        return cell;
    }
    else if (indexPath.section == 1) {
        ESLiveCouponAndCrowdCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"couponAndCrowdCell" forIndexPath:indexPath];
        [cell setCouponAndCrowdWithModel:@""];
        cell.backgroundColor = ColorRGBA(0, 0, 0, 0.6);
        return cell;
    }
    else{
        ESLiveProductListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
        [cell setLiveProductListCellWithModel:@"" isSearch:NO];
        cell.backgroundColor = ColorRGBA(0, 0, 0, 0.6);
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [ESLiveProductHeadCell getBrandSize];
    }
    else if (indexPath.section == 1) {
        return CGSizeMake(SSize.width, [ESLiveCouponAndCrowdCell getCellHeightWithModel:@""]);
    }
    else {
        return [ESLiveProductListCell getProductListCellSize];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
