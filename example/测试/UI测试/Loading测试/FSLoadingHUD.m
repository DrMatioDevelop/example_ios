//
//  FSLoadingHUD.m
//  flashing
//
//  Created by 陈雁锋 on 2018/4/28.
//  Copyright © 2018年 best. All rights reserved.
//

#import "FSLoadingHUD.h"

@interface FSLoadingHUD ()
//菊花
@property(nonatomic, strong)MBProgressHUD *animationHud;
//信息HUD
@property(nonatomic, strong)MBProgressHUD *messageHud;
//loading 引用计数  0时不展示 每次show加1，每次stop-1
@property(nonatomic, assign)NSInteger loadingCount;
//@property(nonatomic, strong)FSHUDCustomView *hudCustomView;
@end
@implementation FSLoadingHUD

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static FSLoadingHUD *hud = nil;
    dispatch_once(&onceToken, ^{
        hud = [[self alloc] init];
    });
    return hud;
}

//开始Loading
- (void)showAnimationWhenLoadingWith:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    }
    if (!view) {
        return;
    }
    
    if (self.animationHud) {
        [self stopAnimationOfAnimation:YES afterTime:0];
    }
    
    self.animationHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.animationHud.mode = MBProgressHUDModeIndeterminate;
    self.animationHud.alpha = 0.8;
    self.loadingCount++;
    
    NSLog(@"%s--%ld",__func__,self.loadingCount);
}

//停止loading
- (void)stopAllLoadingAnimation {
    if (self.animationHud) {
        self.loadingCount = 0;
        [self stopAnimationOfAnimation:YES afterTime:0.5];
        NSLog(@"%s--%ld",__func__,self.loadingCount);

    }
}
//停止loading
- (void)stopLoadingAnimation {
    if (self.animationHud) {
        self.loadingCount--;

        if (self.loadingCount == 0) {
            [self stopAnimationOfAnimation:YES afterTime:0.5];
        }
        
        NSLog(@"%s--%ld",__func__,self.loadingCount);

    }
}

//所有停止loading方法入口
- (void)stopAnimationOfAnimation:(BOOL)animation afterTime:(NSTimeInterval)time {
    if (self.animationHud) {
        [self.animationHud hideAnimated:animation afterDelay:time];
    }
}


- (void)HUDOfMessage:(NSString *)message subView:(UIView *)subView {
    if (!message || ![message isKindOfClass:[NSString class]]) {
        return;
    }
    
    if (!subView) {
        subView = [UIApplication sharedApplication].delegate.window.rootViewController.view;;
    }
    
    if (self.messageHud) {
        [self.messageHud hideAnimated:NO];
    }
    self.messageHud.mode = MBProgressHUDModeText;
    
    self.messageHud.label.textColor = DJHexRGB(0xFFFFFF);
    self.messageHud.label.font = DJFontRegular(12);
    self.messageHud.label.numberOfLines = 0;
    self.messageHud.bezelView.backgroundColor = DJHexRGBAlpha(0x111111, 0.9);
    self.messageHud.label.text = message;
    self.messageHud.removeFromSuperViewOnHide = YES;
    self.messageHud.mode = MBProgressHUDModeText;
    [subView addSubview:self.messageHud];
    [subView bringSubviewToFront:self.messageHud];
    [self.messageHud showAnimated:YES];
    [self.messageHud hideAnimated:YES afterDelay:1.5];
}

- (void)HUDSuccessOfMsg:(NSString *)message subView:(UIView *)subView; {
    if (!message) {
        return;
    }
    
    if (!subView) {
        subView = [UIApplication sharedApplication].delegate.window.rootViewController.view;;
    }
    
    if (self.messageHud) {
        [self.messageHud hideAnimated:NO];
    }
    
    self.messageHud.mode = MBProgressHUDModeCustomView;
    self.messageHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success_icon"]];
    self.messageHud.label.text = message;
    self.messageHud.label.font = DJFontRegular(16);
    self.messageHud.label.textColor = DJHexRGB(0xFFFFFF);
    self.messageHud.bezelView.backgroundColor = DJHexRGBAlpha(0x111111, 0.9);
    [subView addSubview:self.messageHud];
    [subView bringSubviewToFront:self.messageHud];
    [self.messageHud showAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.messageHud hideAnimated:YES];
    });
}

- (void)HUDFailureOfMsg:(NSString *)message subView:(UIView *)subView; {
    if (!message) {
        return;
    }
    
    if (!subView) {
        subView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    }
    
    if (self.messageHud) {
        [self.messageHud hideAnimated:NO];
    }
    
    self.messageHud.mode = MBProgressHUDModeCustomView;
    self.messageHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_failure_icon"]];
    self.messageHud.label.text = message;
    self.messageHud.label.font = DJFontRegular(16);
    self.messageHud.label.textColor = DJHexRGB(0xFFFFFF);
    self.messageHud.bezelView.backgroundColor = DJHexRGBAlpha(0x111111, 0.9);
    [subView addSubview:self.messageHud];
    [subView bringSubviewToFront:self.messageHud];
    [self.messageHud showAnimated:YES];
    [self.messageHud hideAnimated:YES afterDelay:1.5];
}


#pragma mark - Getter
- (MBProgressHUD *)messageHud {
    if (!_messageHud) {
        _messageHud = [[MBProgressHUD alloc] init];

    }
    return _messageHud;
}
//- (FSHUDCustomView *)hudCustomView {
//    if (!_hudCustomView) {
//        _hudCustomView = [[FSHUDCustomView alloc] init];
//    }
//    return _hudCustomView;
//}
@end




//@implementation FSHUDCustomView
//- (instancetype)init {
//    if (self = [super init]) {
//        [self addSubview:self.titleLab];
//        [self addSubview:self.imgView];
//    }
//    return self;
//}
//
//- (void)setHUDCustomViewOfTitle:(NSString *)title imgName:(NSString *)imgName {
//    self.titleLab.text = title;
//    self.imgView.image = [UIImage imageNamed:imgName];
//    self.backgroundColor = [UIColor redColor];
//
//    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.offset = 48;
//        make.centerX.equalTo(self.mas_centerX);
//        make.top.equalTo(self.mas_top).offset = 20;
//    }];
//
//    CGFloat titieWidth =[self.titleLab.text widthWithFont:self.titleLab.font height:self.titleLab.font.lineHeight maxWeight:DJSSize.width - 60];
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.offset = titieWidth;
//        make.centerX.equalTo(self.mas_centerX);
//        make.bottom.equalTo(self.mas_bottom).offset = -24;
//        make.height.offset = self.titleLab.font.lineHeight;
//    }];
//
//    self.frame = CGRectMake((DJSSize.width- titieWidth - 30)/2, 0, titieWidth + 30, 120);
//
//}
//
//
//- (FSBaseLabel *)titleLab {
//    if (!_titleLab) {
//        _titleLab = [DJComponents getLableWithFont:DJFontRegular(13) textColor:DJHexRGB(0xFFFFFF) backgroundColor:nil textHoriAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByTruncatingTail numberLine:1];
//    }
//    return _titleLab;
//}
//
//- (UIImageView *)imgView {
//    if (!_imgView) {
//        _imgView = [[UIImageView alloc] init];
//        _imgView.backgroundColor = [UIColor clearColor];
//    }
//    return _imgView;
//}
//
//@end


