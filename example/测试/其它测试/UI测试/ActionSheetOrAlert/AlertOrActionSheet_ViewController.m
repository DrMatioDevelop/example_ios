//
//  AlertOrActionSheet_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/5/18.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "AlertOrActionSheet_ViewController.h"

#import "SureCustomActionSheet.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface AlertOrActionSheet_ViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AlertOrActionSheet_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [KIUIContainerControl getButton:CGRectMake(50, 100, 100, 30) tag:1 target:self action:@selector(btnSheetBefore8:)];
    [button setTitle:@"8之前的sheet" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *after8Sheet = [KIUIContainerControl getButton:CGRectMake(50, 160, 100, 30) tag:2 target:self action:@selector(btnSheetAfter8:)];
    [after8Sheet setTitle:@"8之后的sheet" forState:UIControlStateNormal];
    [self.view addSubview:after8Sheet];
    
    UIButton *customSheet = [KIUIContainerControl getButton:CGRectMake(50, 220, 100, 30) tag:2 target:self action:@selector(btnSheetCustom:)];
    [customSheet setTitle:@"自定义的sheet" forState:UIControlStateNormal];
    [self.view addSubview:customSheet];

}

#pragma mark - Click
- (void)btnSheetBefore8:(UIButton *)button {
    NSString *str1 = @"测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度";
    [[[UIActionSheet alloc] initWithTitle:@"title" delegate:self cancelButtonTitle:@"cancelBtn" destructiveButtonTitle:@"destructiveBtn" otherButtonTitles:str1,@"other_2", nil] showInView:self.view];
}
- (void)btnSheetAfter8:(UIButton *)button {
    UIAlertController *alertController = [[UIAlertController alloc] init];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度测试文字长度" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"3" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)btnSheetCustom:(UIButton *)button {
    __weak typeof(self) weakSelf = self;
    SureCustomActionSheet *optionsView = [[SureCustomActionSheet alloc]initWithTitleView:self.headView optionsArr:self.dataArr cancelTitle:@"取消" selectedBlock:^(NSInteger index) {
        NSString *optionsStr = weakSelf.dataArr[index];
        if ([optionsStr isEqualToString:@"苹果地图"]) {
            [weakSelf openAppleMap];
        } else if ([optionsStr isEqualToString:@"百度地图"]) {
            
        } else if ([optionsStr isEqualToString:@"高德地图"]) {
            
            
        }
    } cancelBlock:^{
        
    }];
    
    
    if (self.navigationController) {
        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
        
        [window addSubview: optionsView];
    }
    else {
        [self.view addSubview:optionsView];
        
    }

}



- (NSMutableArray*)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
            [_dataArr addObject:@"百度地图"];
        }
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
            [_dataArr addObject:@"高德地图"];
        }
        [_dataArr addObjectsFromArray:@[@"苹果地图"]];
    }
    return _dataArr;
}

- (UIView*)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 20, 30)];
        titleLabel.text = @"请选择导航";
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        descLabel.text = @"记住我的选择，不再提示";
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.center = CGPointMake(_headView.center.x, 55);
        [_headView addSubview:descLabel];
        
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake(CGRectGetMinX(descLabel.frame) - 30, 45, 20, 20);
        [selectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:selectedButton];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, self.view.bounds.size.width - 20, .5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [_headView addSubview:line];
    }
    return _headView;
}

- (void)selectedClick:(UIButton*)button {
    button.selected = !button.selected;
}

- (void)openAppleMap {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.984066, 116.307606);
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //    endLocation = [endLocation locationMarsFromBaidu];//火星坐标转换为百度坐标
    CLLocationCoordinate2D endCoor = endLocation.coordinate;
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{
                                   MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES],
                                   MKLaunchOptionsMapTypeKey : [NSNumber numberWithInteger:0]
                                   }];
}

@end
