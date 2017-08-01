//
//  Custom_CollectionViewCell.m
//  example
//
//  Created by d2c_cyf on 17/7/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Custom_CollectionViewCell.h"

@implementation Custom_CollectionViewCell
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
@end
