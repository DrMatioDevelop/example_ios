//
//  ESLiveSearchProductCollecView.h
//  example
//
//  Created by d2c_cyf on 17/1/5.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLiveSearchProductCollecView : UICollectionView <
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, copy)void (^scrollSearchListBlock)(void);
- (void)setSearchProductWithModel:(id)model;
@end
