//
//  KICollectionViewTestVC.m
//  example
//
//  Created by 陈雁锋 on 2018/5/29.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KICollectionViewTestVC.h"

@interface KICollectionViewTestVC ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *testCollectView;
@end

@implementation KICollectionViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.testCollectView];
    [self.testCollectView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    if (section == 0) {
    //        return 3;
    //    }
    //    else if (section == 1) {
    //        return 1;
    //    }
    //    else if (section == 2){
    //        return 1;
    //    }
    //    else if (section == 3){
    //        return 1;
    //    }
    //    else {
    //        return 8;
    //    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dd" forIndexPath:indexPath];
    cell.backgroundColor = KIRandomColor;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((SSize.width / 3.0), KIRationWidth(70));
    }
    else if (indexPath.section == 1) {
        return CGSizeMake(SSize.width, 44);
    }
    else if (indexPath.section == 2) {
        return CGSizeMake(SSize.width, KIRationWidth(150));
    }
    else if (indexPath.section == 3){
        return CGSizeMake(SSize.width, 44);
    }
    else {
        return CGSizeMake((SSize.width / 4.0), KIRationWidth(81));
    }
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
//        headView.backgroundColor = KIRandomColor;
//        return headView;
//    }
//    else {
//        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
//        return headView;
//    }
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SSize.width, KIRationWidth(164));
    }
    else {
        return CGSizeMake(SSize.width, 100);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 100;
    }
    return 100;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}


- (UICollectionView *)testCollectView {
    if (!_testCollectView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _testCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SSize.width, SSize.height - 49) collectionViewLayout:flowLayout];
        _testCollectView.delegate   = self;
        _testCollectView.dataSource = self;
        _testCollectView.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)) {
            _testCollectView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_testCollectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"dd"];
        [_testCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    }
    return _testCollectView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
