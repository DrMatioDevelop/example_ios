//
//  ESLiveProductCollectionView.h
//  example
//
//  Created by d2c_cyf on 17/1/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLiveProductCollectionView : UICollectionView
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

/**
 设置滚动视图的数据

 @param model 数据
 */
- (void)productListReload:(id)model;
@end
