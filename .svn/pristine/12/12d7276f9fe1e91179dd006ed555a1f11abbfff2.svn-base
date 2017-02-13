//
//  Function.m
//  example
//
//  Created by d2c_cyf on 16/12/6.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "Function.h"
#import "AppDelegate.h"
#define KView ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController.view
MBProgressHUD *HUDSucess(NSString *message) {
    MBProgressHUD *hud  = [[MBProgressHUD alloc] initWithView:KView];
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UILabel *label = [[UILabel alloc] init];
    label.font          = Font(12);
    label.textColor     = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    CGFloat width  = 270.0 - 60.0;
    CGFloat height = ceil([message heightWithFont:label.font Width:width RowHeight:label.font.lineHeight Spacing:3.0]);
    label.text = message;
    label.frame = CGRectMake(0, 0, width, height);
    
    hud.customView = label;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    [KView addSubview:hud];
    [hud show:YES];
    return hud;
}
