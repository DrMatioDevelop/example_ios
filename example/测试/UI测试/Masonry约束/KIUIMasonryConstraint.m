//
//  KIUIMasonryConstraint.m
//  example
//
//  Created by 陈雁锋 on 2018/4/17.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "KIUIMasonryConstraint.h"

@interface KIUIMasonryConstraint ()
@property(strong, nonatomic)UILabel *lab;
@property(strong, nonatomic)UILabel *lab1;
@property(strong, nonatomic)UILabel *lab2;
@property(strong, nonatomic)UILabel *lab3;
@property(strong, nonatomic)UILabel *lab4;

@end

@implementation KIUIMasonryConstraint {
    UILabel *_marketLabel;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *market = [NSString stringWithFormat:@"¥%@",@"500"];
    NSMutableAttributedString *attributeMarket = [[NSMutableAttributedString alloc] initWithString:market];
    [attributeMarket setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,market.length)];
    
    _marketLabel.attributedText = attributeMarket;
    
    _marketLabel.attributedText = attributeMarket;
    
    NSString *market1 = [NSString stringWithFormat:@"￥%@",@"500"];
    NSMutableAttributedString *attributeMarket1 = [[NSMutableAttributedString alloc] initWithString:market1];
    [attributeMarket1 setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(0,market.length)];
    
    _marketLabel.attributedText = attributeMarket;
    
    self.view.backgroundColor = [UIColor lightTextColor];        
    
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset = 300;
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //对应那边距
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.lab).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    //对应了倍率与除数 意思相同
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.width.height.mas_equalTo(self.lab1.mas_width).multipliedBy(0.5);
        make.width.height.mas_equalTo(self.lab1.mas_width).dividedBy(2);

        make.center.mas_equalTo(self.lab1);
    }];
    
    
    //如果要自动填充UIScrollView内容
    /*
     1.建立一个UIScrollview的子视图 contentView
     2.所有的资源素add到contentView上
     3.也可以在第一步设置 contentView的约束 设置内边距
       make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsMake(padding, padding, padding, padding));

     */
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
    }];
}

- (UILabel *)lab {
    if (!_lab) {
        _lab = [[UILabel alloc] init];
        _lab.textColor = [UIColor blackColor];
        _lab.backgroundColor = [KIUIContainerControl radomColor];
        [self.view addSubview:_lab];
    }
    return _lab;
}

- (UILabel *)lab1 {
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        _lab1.textColor = [UIColor blackColor];
        _lab1.backgroundColor = [KIUIContainerControl radomColor];
        [self.view addSubview:_lab1];
    }
    return _lab1;
}

- (UILabel *)lab2 {
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = [UIColor blackColor];
        _lab2.backgroundColor = [KIUIContainerControl radomColor];
        [self.view addSubview:_lab2];
    }
    return _lab2;
}
- (UILabel *)lab3 {
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.textColor = [UIColor blackColor];
        _lab3.backgroundColor = [KIUIContainerControl radomColor];
        [self.view addSubview:_lab3];
    }
    return _lab3;
}
- (UILabel *)lab4 {
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = [UIColor blackColor];
        _lab4.backgroundColor = [KIUIContainerControl radomColor];
        [self.view addSubview:_lab4];
    }
    return _lab4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
