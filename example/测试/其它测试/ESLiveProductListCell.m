//
//  ESLiveProductListCell.m
//  example
//
//  Created by d2c_cyf on 17/1/5.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveProductListCell.h"
@interface ESLiveProductListCell ()
@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel     *productInfo;
@property(nonatomic, strong)UILabel     *price;
@property(nonatomic, strong)UIButton    *button;
@property(nonatomic, assign)BOOL        isSearch;
@end

@implementation ESLiveProductListCell
- (void)setLiveProductListCellWithModel:(id)model isSearch:(BOOL)searchFlag{
    self.isSearch = searchFlag;
    self.imgView.backgroundColor = [UIColor whiteColor];
    self.productInfo.text = @"德玛西亚勇士长存，万众一心众志成城，为了荣耀的关辉";
    self.price.attributedText = [[NSAttributedString alloc] initWithString:@"133300"];
    self.button.size = CGSizeMake(95, 30.0);
    self.button.layer.borderWidth  = 1.0;
    self.button.layer.cornerRadius = 4.0;
    if (searchFlag) {
        self.button.backgroundColor = [UIColor clearColor];
        [self setRecommendButtonColor];
    }
    else {
        self.button.backgroundColor = ColorRGBA(253, 85, 98, 1.0);
        self.button.layer.borderColor = [UIColor clearColor].CGColor;
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    [self layoutAllSubviews];
}
#pragma mark - func
+ (CGSize)getProductListCellSize {
    return CGSizeMake(SSize.width, RatioWidth(15.0 + 10.0) + RatioWidth(144.0));
}
- (void)setRecommendButtonColor {
    if (self.button.selected) {
        [self.button setTitle:@"取消推荐" forState:UIControlStateNormal];
        [self.button setTitleColor:ColorRGBA(153, 153, 153, 1.0) forState:UIControlStateNormal];
        self.button.layer.borderColor = ColorRGBA(153, 153, 153, 1.0).CGColor;
        
    }
    else {
        [self.button setTitle:@"推荐" forState:UIControlStateNormal];
        [self.button setTitleColor:ColorRGBA(253, 85, 98, 1.0) forState:UIControlStateNormal];
        self.button.layer.borderColor = ColorRGBA(253, 85, 98, 1.0).CGColor;
    }
    self.button.selected = !self.button.selected;
}
#pragma mark - Click
- (void)clickbutton:(UIButton *)btn {
    if (self.isSearch) {
        [self setRecommendButtonColor];
    }
    NSLog(@"button");
}
#pragma mark - Layout
- (void)layoutAllSubviews {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = RatioWidth(110.0);
        make.height.offset = RatioWidth(144.0);
        make.top.equalTo(self.mas_top).offset = RatioWidth(15.0);
        make.left.equalTo(self.mas_left).offset = RatioWidth(10.0);
    }];
    
    [self.productInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = ceil([self.productInfo.text heightWithFont:self.productInfo.font Width:SSize.width - RatioWidth(145.0)]);
        make.left.equalTo(self.imgView.mas_right).offset = RatioWidth(10.0);
        make.right.equalTo(self.mas_right).offset        =  -RatioWidth(15.0);
        make.top.equalTo(self.imgView.mas_top).offset    = RatioWidth(10.0);
        make.height.offset = height;
    }];
    
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset = -RatioWidth(15.0);
        make.bottom.equalTo(self.imgView.mas_bottom);
        make.width.offset = 95.0;
        make.height.offset = 30.0;
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset = RatioWidth(10.0);
        make.right.equalTo(self.mas_right).offset        = -RatioWidth(15.0);
        make.bottom.equalTo(self.button.mas_top).offset = -RatioWidth(10.0);
        make.height.offset = Font(20.0).lineHeight;
    }];
    

}
#pragma mark - Getter
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
    }
    return _imgView;
}
- (UILabel *)productInfo {
    if (!_productInfo) {
        _productInfo = [[UILabel alloc] init];
        _productInfo.textColor = [UIColor whiteColor];
        _productInfo.font      = Font(14);
        _productInfo.numberOfLines = 2;
        _productInfo.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_productInfo];
    }
    return _productInfo;
}
- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        [self addSubview:_price];
    }
    return _price;
}
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button.titleLabel.font = Font(14.0);
        [_button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return _button;
}
@end
