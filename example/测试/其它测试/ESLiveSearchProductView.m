//
//  ESLiveSearchProductView.m
//  example
//
//  Created by d2c_cyf on 17/1/5.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveSearchProductView.h"
#import "ESLiveSearchProductCollecView.h"
@interface ESLiveSearchProductView ()
/**
 搜索框 父视图
 */
@property(nonatomic , strong) UIView      *searchHeadView;

/**
 搜索框
 */
@property(nonatomic , strong) UITextField *searchTextField;

/**
 搜索框下 分割线
 */
@property(nonatomic , strong) UIView      *lineView;

/**
 商品列表
 */
@property(nonatomic , strong) ESLiveSearchProductCollecView *collectionView;

@end
@implementation ESLiveSearchProductView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - Func
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.liveSearchProductBlock) {
        if (self.searchTextField.isFirstResponder) {
            [self.searchTextField resignFirstResponder];
        }
        self.liveSearchProductBlock();
    }
}
- (void)setLiveSearchList:(id)model {
    __weak typeof(self) weakSelf = self;
    [self.collectionView setSearchProductWithModel:model];
    self.collectionView.scrollSearchListBlock = ^(){
        [weakSelf.searchTextField resignFirstResponder];
    };
}
#pragma mark -Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.searchHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = SSize.width;
        make.height.offset = RatioWidth(43.0);
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_bottom).offset = - RatioWidth(450.0);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = SSize.width - RatioWidth(20.0);
        make.height.offset = 30.0;
        make.left.equalTo(self.searchHeadView.mas_left).offset = RatioWidth(10.0);
        make.centerY.equalTo(self.searchHeadView.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 0.5;
        make.width.offset  = SSize.width;
        make.left.equalTo(self.searchHeadView.mas_left);
        make.bottom.equalTo(self.searchHeadView.mas_bottom);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = SSize.width;
        make.height.offset = RatioWidth(450.0 - 43.0);
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.searchHeadView.mas_bottom);
    }];
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
        [self.searchHeadView addSubview:_searchTextField];
    }
    return _searchTextField;
}
- (ESLiveSearchProductCollecView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[ESLiveSearchProductCollecView alloc] initWithFrame:CGRectMake(0, SSize.height - RatioWidth(450.0), SSize.width, RatioWidth(450.0))];
        _collectionView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (UIView *)searchHeadView {
    if (!_searchHeadView) {
        _searchHeadView = [[UIView alloc] init];
        _searchHeadView.backgroundColor = ColorRGBA(0, 0, 0, 0.5);
        [self addSubview:_searchHeadView];
    }
    return _searchHeadView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorRGBA(153, 153, 153, 1.0);
        [self.searchHeadView addSubview:_lineView];
    }
    return _lineView;
}
@end
