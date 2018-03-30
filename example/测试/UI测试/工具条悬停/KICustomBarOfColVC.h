//
//  KICustomBarOfColVC.h
//  example
//
//  Created by d2c_cyf on 2018/3/19.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KICustomHeadReuseView;
@class KICustomColItem;

@interface KICustomBarOfColVC : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end


@interface KICustomHeadReuseView : UICollectionReusableView
@end


@interface KICustomColItem : UICollectionViewCell
@end
