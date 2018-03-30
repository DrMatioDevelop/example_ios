//
//  KICustomBarOfColVC.m
//  example
//
//  Created by d2c_cyf on 2018/3/19.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KICustomBarOfColVC.h"
#define SSize [UIScreen mainScreen].bounds.size
#define ToolBarHeight 40   //悬浮工具条
#define HeadHeight 100      //头视图高度

@interface KICustomBarOfColVC ()
@property(nonatomic, strong)UICollectionView *testColView;
@property(nonatomic, strong)UIView           *tooBarView;
@end

@implementation KICustomBarOfColVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.testColView reloadData];
}
- (void)tapBar:(UITapGestureRecognizer *)tap {
    NSLog(@"%s",__func__);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offectY = scrollView.contentOffset.y;
    if (offectY >= HeadHeight) {
        self.tooBarView.transform = CGAffineTransformTranslate(self.tooBarView.transform, 0, offectY - self.tooBarView.y);
    }
    else {
        self.tooBarView.transform = CGAffineTransformIdentity;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KICustomColItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    return item;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    KICustomHeadReuseView *reusableV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    reusableV.height = HeadHeight;
    return reusableV;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SSize.width - 20, 60);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SSize.width, HeadHeight + ToolBarHeight);
}

- (UICollectionView *)testColView {
    if (!_testColView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _testColView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 88, SSize.width, SSize.height - 126) collectionViewLayout:flowLayout];
        _testColView.backgroundColor = [UIColor whiteColor];
        _testColView.delegate = self;
        _testColView.dataSource = self;
        
        [_testColView registerClass:[KICustomColItem class] forCellWithReuseIdentifier:@"item"];
        [_testColView registerClass:[KICustomHeadReuseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_testColView addSubview:self.tooBarView];
        [_testColView bringSubviewToFront:self.tooBarView];

        [self.view addSubview:_testColView];
    }
    return _testColView;
}
- (UIView *)tooBarView {
    if (!_tooBarView) {
        _tooBarView = [[UIView alloc] initWithFrame:CGRectMake(0, HeadHeight, SSize.width, ToolBarHeight)];
        _tooBarView.backgroundColor = [UIColor purpleColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBar:)];
        [_tooBarView addGestureRecognizer:tap];
    }
    return _tooBarView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


@interface KICustomHeadReuseView ()
@end
@implementation KICustomHeadReuseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    }
    return self;
}
@end


@interface KICustomColItem ()
@end
@implementation KICustomColItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.8];
    }
    return self;
}
@end
