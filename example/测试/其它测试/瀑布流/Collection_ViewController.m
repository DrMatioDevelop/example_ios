//
//  Collection_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/5/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

// 参考地址 https://github.com/Joker-388/JKRComplexFallsDemo
#import "Collection_ViewController.h"
#import "CustomLineLayout.h"
#import "Custom_CollectionViewCell.h"

@interface Collection_ViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource,CustomLayoutDelegate>
@property (nonatomic, strong)UICollectionView *myCollectionView;
@property (nonatomic, strong)NSArray *arrayDS;

@end

@implementation Collection_ViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"瀑布流";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *button = [KIUIContainerControl getButton:CGRectMake(0, 0, 44, 44) title:@"变" tag:1 target:self action:@selector(clickChange:)];
    self.navigationItem.rightBarButtons = @[button];
    
    _arrayDS = @[@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(1),@(0),@(0),@(0),@(0),@(0),@(1),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)];
    
    [self.myCollectionView reloadData];
}

- (void)clickChange:(UIButton *)button {
    if (button.selected) {
        [self.myCollectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init] animated:YES];

    }
    else {
        [self.myCollectionView setCollectionViewLayout:[[CustomLineLayout alloc] init] animated:YES];

    }
    button.selected = !button.selected;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayDS.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([[self.arrayDS objectAtIndex:indexPath.row] boolValue]) {
        item.backgroundColor = [UIColor redColor];
    }
    else {
        item.backgroundColor = [UIColor blueColor];
    }
    return item;
}
- (UICollectionView *)myCollectionView {
    CustomLayout *customlayout = [[CustomLayout alloc] init];
    customlayout.delegate = self;
    if (!_myCollectionView) {
        customlayout.arrayDS = self.arrayDS;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0) collectionViewLayout:customlayout];
        _myCollectionView.delegate   = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = [UIColor lightGrayColor];
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_myCollectionView];
    }
    return _myCollectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}


- (NSInteger)columnCountInCustomLayout:(CustomLayout *)customLayout {
    return 2;
}
- (CGFloat)columnMarginInCustomLayout:(CustomLayout *)customLayout {
    return 5.0;
}
- (CGFloat)rowMarginInCustomLayout:(CustomLayout *)customLayout {
    return 5.0;
}

- (UIEdgeInsets)edgeInsetsInCustomLayout:(CustomLayout *)customLayout {
    return UIEdgeInsetsMake(10, 5.0, 0, 5.0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
