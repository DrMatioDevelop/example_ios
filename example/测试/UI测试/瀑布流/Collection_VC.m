//
//  Collection_VC.m
//  example
//
//  Created by d2c_cyf on 17/7/10.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Collection_VC.h"
#import "CustomLineLayout.h"
#import "Custom_CollectionViewCell.h"
@interface Collection_VC ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong,nonatomic)UICollectionView *collectionView;
@property (strong,nonatomic)NSMutableArray *images;
@end

@implementation Collection_VC

static NSString *const reuseIndentifier = @"image";

//懒加载
-(NSMutableArray *)images
{
    if (!_images)
    {
        _images = [NSMutableArray array];
        for (int i=1; i<=25; i++)
        {
            [_images addObject:[NSString stringWithFormat:@"clothes%d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //创建集合视图
    CGFloat width = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, width, 400);
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[CustomLineLayout alloc]init]];
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    //设置数据源和代理
    self.collectionView.dataSource  = self;
    self.collectionView.delegate  = self;
    
    //注册单元格
    [self.collectionView registerClass:[Custom_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //添加视图
    [self.view addSubview:self.collectionView];
    
    
    //UICollectionViewLayout：最根本的布局,自定义布局时，完全需要自己重新去写需要的布局
    //UICollectionViewFlowLayout ：流水布局，自定义布局时,有时可以在它的布局基础上再进行扩展布局
}


//切换布局方式
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[CustomLineLayout class]])
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:flowLayout animated:YES];
    }
    else
    {
        [self.collectionView setCollectionViewLayout:[[CustomLineLayout alloc]init] animated:YES];
    }
}

#pragma mark - <UICollectionDataSourceDelegate>
//返回组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}
//显示conllectionView的单元格
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    Custom_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    cell.titleLabel.text = self.images[indexPath.row];
    cell.titleLabel.backgroundColor = [UIColor colorWithRed:arc4random() %255/255.0 green:arc4random() %255/255.0 blue:arc4random() %255/255.0 alpha:1.0];
    return cell;

}
//选中item时删除它
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.先删除掉对应的模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    
    //2.删除item(刷新UI)
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


@end
