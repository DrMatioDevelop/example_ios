//
//  ESLiveSearchProductReusableView.m
//  example
//
//  Created by d2c_cyf on 17/1/5.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveSearchProductReusableView.h"
@interface ESLiveSearchProductReusableView ()
@property(nonatomic , strong) UITextField *searchTextField;
@end
@implementation ESLiveSearchProductReusableView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = SSize.width - RatioWidth(20.0);
        make.height.offset = 30.0;
        make.left.equalTo(self.mas_left).offset = RatioWidth(10.0);
        make.top.equalTo(self.mas_top).offset   = RatioWidth(13.0);
    }];
}
+ (CGSize)getLiveSearchSize {
    return CGSizeMake(SSize.width, RatioWidth(43.0));
}
#pragma mark - Getter
- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]init];
        _searchTextField.backgroundColor = ColorRGBA(240, 240, 240, 1);
        _searchTextField.placeholder     = @"请输入商品或货号";
        _searchTextField.font            = Font(14.0);
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.returnKeyType   = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 5.0;
        _searchTextField.contentMode     = UIViewContentModeCenter;
        
        UIImageView *searchImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 28)];
        searchImage.image = [UIImage imageNamed:@"icon_a_search_l"];
        _searchTextField.leftView = searchImage;
        _searchTextField.leftViewMode=UITextFieldViewModeAlways;
        [self addSubview:_searchTextField];
    }
    return _searchTextField;
}
@end
