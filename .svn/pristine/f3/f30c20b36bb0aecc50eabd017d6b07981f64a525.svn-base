//
//  ESLiveProductView.m
//  example
//
//  Created by d2c_cyf on 17/1/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveProductView.h"
#import "ESLiveProductCollectionView.h"
@interface ESLiveProductView ()
@property (nonatomic , strong)ESLiveProductCollectionView *liveProductListCollecView;
@end
@implementation ESLiveProductView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.liveProductListCollecView];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.liveProductCloseBlock) {
        self.liveProductCloseBlock();
    }
}
- (void)loadLiveProductListWithModel:(id)model {
    [self.liveProductListCollecView productListReload:model];
}
#pragma mark - Getter
- (ESLiveProductCollectionView *)liveProductListCollecView {
    if (!_liveProductListCollecView) {
        _liveProductListCollecView = [[ESLiveProductCollectionView alloc] initWithFrame:CGRectMake(0, SSize.height - RatioWidth(400.0), SSize.width, RatioWidth(400.0))];
    }
    return _liveProductListCollecView;
}
@end
