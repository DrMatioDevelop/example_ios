//
//  ESLiveProductHeadCell.m
//  example
//
//  Created by d2c_cyf on 17/1/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ESLiveProductHeadCell.h"
@interface ESLiveProductHeadCell ()
@property(nonatomic,strong)UIImageView *brandImageView;
@property(nonatomic,strong)UILabel     *brandName;
@property(nonatomic,strong)UILabel     *brandInfo;
@property(nonatomic,strong)UIView      *lineView;
@end
@implementation ESLiveProductHeadCell
#pragma mark - Func
- (void)setLiveProductHeadWithModel:(id)model {
    self.brandImageView.backgroundColor = [UIColor whiteColor];
    self.brandName.text = @"德玛西亚";
    self.brandInfo.text = @"转转转 上怒吼  放盾墙  蛮爷硬如狗，不朽之王赐予我毁灭迪亚波罗的力量吧";
    
    [self layoutAllSubviews];
}

+ (CGSize)getBrandSize {
    return CGSizeMake(SSize.width, RatioWidth(10*2 + 60.0));
}
#pragma mark - Layout
- (void)layoutAllSubviews {
    [self.brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset       = RatioWidth(60.0);
        make.left.equalTo(self.mas_left).offset = RatioWidth(10.0);
        make.top.equalTo (self.mas_top ).offset = RatioWidth(10.0);
    }];
    
    [self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = ceil(RatioWidth(SSize.width - 60.0 - 10.0*3));
        make.height.offset = self.brandName.font.lineHeight;
        make.left.equalTo(self.brandImageView.mas_right).offset = RatioWidth(10.0);
        make.top.equalTo (self.brandImageView.mas_top) .offset = 10.0;
    }];
    
    [self.brandInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = ceil(RatioWidth(SSize.width - 60.0 - 10.0*3));
        make.height.offset = self.brandInfo.font.lineHeight;
        make.left.equalTo(self.brandImageView.mas_right).offset = RatioWidth(10.0);
        make.bottom.equalTo(self.brandImageView.mas_bottom).offset = -10.0;
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = RatioWidth(365.0);
        make.height.offset = 0.5;
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
#pragma mark - Getter
- (UIImageView *)brandImageView {
    if (!_brandImageView) {
        _brandImageView = [[UIImageView alloc] init];
        [self addSubview:_brandImageView];
    }
    return _brandImageView;
}
- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc] init];
        _brandName.font = Font(16.0);
        _brandName.textColor = [UIColor whiteColor];
        _brandName.numberOfLines = 1;
        _brandName.lineBreakMode = NSLineBreakByTruncatingTail;
        _brandName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_brandName];
    }
    return _brandName;
}
- (UILabel *)brandInfo {
    if (!_brandInfo) {
        _brandInfo = [[UILabel alloc] init];
        _brandInfo.font = Font(14);
        _brandInfo.textColor = [UIColor whiteColor];
        _brandInfo.numberOfLines = 1;
        _brandInfo.lineBreakMode = NSLineBreakByTruncatingTail;
        _brandInfo.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_brandInfo];
    }
    return _brandInfo;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorRGBA(255, 255, 255, 0.5);
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end




#pragma mark - 领券与活动
#pragma mark - 领券与活动
//////////  领券与活动  /////////
@interface ESLiveCouponAndCrowdCell ()
@property(nonatomic, strong)UILabel  *couponLabel;
@property(nonatomic, strong)UIScrollView *couponScrollView;
@property(nonatomic, strong)UILabel  *crowdLabel;
@property(nonatomic, strong)UIView   *crowdView;
@property(nonatomic, strong)UIView   *lineView;
@end
@implementation ESLiveCouponAndCrowdCell
- (void)setCouponAndCrowdWithModel:(id)Model {
    self.crowdLabel.text  = @"活动";
    self.couponLabel.text = @"领券";
    self.couponScrollView =  [self getScrollCouponView:@""];
    self.crowdView        =  [self getCrowdViewWithModel:@""];
    
    [self layoutAllSubviewsWithCoupon:YES crowd:YES];
}
+ (CGFloat)getCellHeightWithModel:(id)model {
    BOOL isCoupon = YES;
    BOOL isCrowd  = YES;
    if (isCoupon && isCrowd) {
        CGFloat couponHeight = [ESLiveCouponAndCrowdCell getScrollCrowdViewSize].height + RatioWidth(20.0);
        CGFloat crowdHeight  = [ESLiveCouponAndCrowdCell getCrowdViewSize:@""].height + RatioWidth(25.0);
        return couponHeight + crowdHeight;
    }
    else if (!isCoupon && isCrowd) {
        return [ESLiveCouponAndCrowdCell getCrowdViewSize:@""].height + RatioWidth(25.0);
    }
    else if (isCoupon && !isCrowd) {
        return [ESLiveCouponAndCrowdCell getScrollCrowdViewSize].height + RatioWidth(20.0);
    }
    else {
        return 0;
    }
}
#pragma mark - Click
- (void)tapCouponView:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"%@",[gestureRecognizer view]);
}
#pragma mark - Func
- (UIScrollView *)getScrollCouponView:(id)model {
    UIScrollView *couponScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [ESLiveCouponAndCrowdCell getScrollCrowdViewSize].width, RatioWidth(57.0))];
    couponScrollView.showsVerticalScrollIndicator   = NO;
    couponScrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat space = RatioWidth(10.0);
    CGFloat contentWidth = 0;
    for (int i = 0; i < 5; i++) {
        UIImageView *couponView = [ESLiveCouponAndCrowdCell getCouponImgView:@""];
        couponView.x = i*(couponView.width + space);
        contentWidth = CGRectGetMinX(couponView.frame) + couponView.width;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCouponView:)];
        [couponView addGestureRecognizer:tap];
        [couponScrollView addSubview:couponView];
    }
    couponScrollView.contentSize = CGSizeMake(contentWidth, 0);
    return couponScrollView;
}
+ (UIImageView *)getCouponImgView:(id)model {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RatioWidth(100.0), RatioWidth(57.0))];
    imgView.image        = [UIImage imageNamed:@"icon_live_card_bg"];
    return imgView;
}


/**
 活动视图

 @param model 数据
 @return 视图
 */
- (UIView *)getCrowdViewWithModel:(id)model {
    UIView *view = [[UIView alloc] init];
    CGFloat lastX = 0;
    CGFloat lastY = 0;
    for (int i = 0; i < 5; i++) {
        UIView *sonView = [self getCorwdView:[NSString stringWithFormat:@"%d %@",i,@"满一百减五十元 上不封顶"]];
        [view addSubview:sonView];
        
        if (lastX + sonView.width > SSize.width - RatioWidth(10.0)) {
            lastX = 0;
            lastY = sonView.height + RatioWidth(10.0) + lastY;
            sonView.x = lastX;
            sonView.y = lastY;
            lastX     = sonView.maxX + RatioWidth(15.0) + lastX;

        }
        else {
            sonView.x = lastX;
            sonView.y = lastY;
            lastX     = sonView.maxX + RatioWidth(15.0) + lastX;
        }
    }
    return view;
}

- (UIView *)getCorwdView:(NSString *)crowdInfo {
    UIView *view = [[UIView alloc] init];
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.font = Font(10);
    headLabel.textColor = ColorRGBA(253, 85, 98, 1.0);
    headLabel.backgroundColor   = [UIColor whiteColor];
    headLabel.layer.borderColor = ColorRGBA(253, 85, 98, 1.0).CGColor;
    headLabel.layer.borderWidth = 0.5;
    headLabel.text              = @"活动";
    headLabel.textAlignment     = NSTextAlignmentCenter;
    headLabel.lineBreakMode     = NSLineBreakByTruncatingTail;
    
    UILabel *infoLabel  = [[UILabel alloc] init];
    infoLabel.font      = Font(12.0);
    infoLabel.textColor = ColorRGBA(200, 200, 200, 1.0);
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.numberOfLines = 1;
    infoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    infoLabel.text          = crowdInfo ? crowdInfo : @"";
    
    [view addSubview:headLabel];
    [view addSubview:infoLabel];
    
    CGFloat headWidth = [headLabel.text widthWithFont:headLabel.font height:headLabel.font.lineHeight];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = headWidth + 5.0;
        make.height.offset = infoLabel.font.lineHeight;
        make.left.equalTo(view.mas_left);
        make.centerY.equalTo(view.mas_centerY);
    }];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = RatioWidth(100.0);
        make.height.offset = infoLabel.font.lineHeight;
        make.left.equalTo(headLabel.mas_right).offset = RatioWidth(5.0);
        make.top.equalTo(headLabel.mas_top);
    }];
    CGSize viewSize = [ESLiveCouponAndCrowdCell getCrowdSonViewSize:crowdInfo];
    view.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    return view;
}

+ (CGSize)getCrowdSonViewSize:(NSString *)info {
    info = @"满一百减五十元 上不封顶";
    CGFloat headWidth = ceil([@"活动" widthWithFont:Font(12) height:Font(12).lineHeight]) + 5.0;
    CGFloat space     = RatioWidth(5.0);
    info = info ? info : @"";
    CGFloat infoWidth = ceil([info widthWithFont:Font(12.0) height:Font(12.0).lineHeight]);
    if (infoWidth > 100.0) {
        infoWidth = 100.0;
    }
    return CGSizeMake(headWidth + space + infoWidth, Font(12).lineHeight);
}
+ (CGSize)getCrowdViewSize:(id)model {
    CGFloat lastX = 0;
    CGFloat lastY = 0;
    for (int i = 0; i < 5; i++) {
        CGSize sonSize = [ESLiveCouponAndCrowdCell getCrowdSonViewSize:@""];
        if (lastX + sonSize.width > SSize.width - RatioWidth(10.0)) {
            lastX = sonSize.width + RatioWidth(15.0);
            lastY = sonSize.height + RatioWidth(10.0) + lastY;
        }
        else {
            lastX     = sonSize.width + RatioWidth(15.0) + lastX;
        }
    }
    lastY += Font(12).lineHeight;
    return CGSizeMake(SSize.width, ceil(lastY));
}
/**
 领券 活动文字宽度

 @return 宽度
 */
+ (CGFloat)getCouponWidth {
    CGFloat couponWidth = ceil([@"领券" widthWithFont:Font(12.0) height:Font(12.0).lineHeight]);
    return couponWidth;
}

/**
 领券滚动视图的size

 @return size
 */
+ (CGSize)getScrollCrowdViewSize {
    CGFloat couponWidth = [ESLiveCouponAndCrowdCell getCouponWidth];
    return CGSizeMake(SSize.width - RatioWidth(10.0 * 2 + 15.0) - couponWidth, RatioWidth(57.0));
}


#pragma mark - Layout
- (void)layoutAllSubviewsWithCoupon:(BOOL)isCoupon crowd:(BOOL)isCrowd {
    if (!isCoupon && !isCrowd) {
        return;
    }
    
    [self addSubview:self.couponScrollView];
    [self addSubview:self.crowdView];
    CGFloat couponWidth = [ESLiveCouponAndCrowdCell getCouponWidth];
    if (isCoupon) {
        [self.couponScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset  = [ESLiveCouponAndCrowdCell getScrollCrowdViewSize].width;
            make.height.offset = RatioWidth(57.0);
            make.left.equalTo(self.mas_left).offset = RatioWidth(10.0 + 15.0) + couponWidth;
            make.top.equalTo(self.mas_top).offset   = RatioWidth(10.0);
        }];
        
        [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset  = couponWidth;
            make.height.offset = self.couponLabel.font.lineHeight;
            make.left.equalTo(self.mas_left).offset                        = RatioWidth(10.0);
            make.centerY.equalTo(self.couponScrollView.mas_centerY).offset = -RatioWidth(10.0) / 2.0;
        }];
    }

    

    if (isCoupon && isCrowd) {
        [self.crowdLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = couponWidth;
            make.height.offset = self.crowdLabel.font.lineHeight;
            make.top.equalTo(self.couponScrollView.mas_bottom).offset = RatioWidth(20.0);
            make.left.equalTo(self.mas_left).offset                   = RatioWidth(10.0);
        }];
        
        [self.crowdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset  = SSize.width - RatioWidth(10.0 * 2 + 15.0) - couponWidth;
            make.height.offset = self.crowdLabel.font.lineHeight;
            make.left.equalTo(self.crowdLabel.mas_right).offset = RatioWidth(15.0);
            make.top.equalTo(self.crowdLabel.mas_top);
        }];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 0.5;
            make.width.offset  = RatioWidth(365.0);
            make.top.equalTo(self.crowdLabel.mas_bottom).offset = RatioWidth(15.0);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    else if (!isCoupon && isCrowd) {
        [self.crowdLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.offset = couponWidth;
            make.height.offset = self.couponLabel.font.lineHeight;
            make.top.equalTo(self.mas_top).offset   = RatioWidth(10.0);
            make.left.equalTo(self.mas_left).offset = RatioWidth(10.0);
        }];
        
        [self.crowdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset  = SSize.width - RatioWidth(10.0 * 2 + 15.0) - couponWidth;
            make.height.offset = self.crowdLabel.font.lineHeight;
            make.left.equalTo(self.crowdLabel.mas_left).offset = RatioWidth(15.0);
            make.top.equalTo(self.crowdLabel.mas_top);
        }];
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 0.5;
            make.width.offset  = RatioWidth(365.0);
            make.top.equalTo(self.crowdLabel.mas_bottom).offset = RatioWidth(15.0);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }

    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.offset  = RatioWidth(365.0);
        make.height.offset = 0.5;
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
    }];

}
#pragma mark - Getter
- (UILabel *)couponLabel {
    if (!_couponLabel) {
        _couponLabel = [[UILabel alloc] init];
        _couponLabel.textColor = [UIColor whiteColor];
        _couponLabel.font      = Font(12.0);
        [self addSubview:_couponLabel];
    }
    return _couponLabel;
}
- (UILabel *)crowdLabel {
    if (!_crowdLabel) {
        _crowdLabel = [[UILabel alloc] init];
        _crowdLabel.textColor = [UIColor whiteColor];
        _crowdLabel.font      = Font(12.0);
        [self addSubview:_crowdLabel];
    }
    return _crowdLabel;
}
//- (UIScrollView *)couponScrollView {
//    if (!_couponScrollView) {
//        _couponScrollView = [[UIScrollView alloc] init];
//        _couponScrollView.showsVerticalScrollIndicator = NO;
//        _couponScrollView.showsHorizontalScrollIndicator = NO;
//        
//        [self addSubview:_couponScrollView];
//    }
//    return _couponScrollView;
//}
//- (UIView *)crowdView {
//    if (!_crowdView) {
//        _crowdView = [[UIView alloc] init];
//        [self addSubview:_crowdView];
//    }
//    return _crowdView;
//}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ColorRGBA(255, 255, 255, 0.5);
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
