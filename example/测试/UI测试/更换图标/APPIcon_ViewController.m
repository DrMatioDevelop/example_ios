//
//  APPIcon_ViewController.m
//  example
//
//  Created by d2c_cyf on 2018/2/24.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

/*
 ios 10.3以上系统支持
 */
#import "APPIcon_ViewController.h"

@interface APPIcon_ViewController ()

@end

@implementation APPIcon_ViewController {
    UIButton *_btn3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [KIUIContainerControl getButton:CGRectMake(100, 100, 70, 20) title:@"oneIcon" tag:1 target:self action:@selector(clickChangeBtn:)];
    
    UIButton *btn2 = [KIUIContainerControl getButton:CGRectMake(200, 100, 70, 20) title:@"twoIcon" tag:2 target:self action:@selector(clickChangeBtn:)];
    
    _btn3 = [KIUIContainerControl getButton:CGRectMake(10, 200, 200, 200) title:@"" tag:3 target:self action:@selector(clickChangeBtn:)];


    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:_btn3];

}

- (void)clickChangeBtn:(UIButton *)btn {
    if (![UIApplication sharedApplication].supportsAlternateIcons) { //是否支持
        [_btn3 setTitle:@"不支持更换图标" forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
        return;
    }
    
    
    if (btn.tag == 1) {
        [[UIApplication sharedApplication] setAlternateIconName:@"oneIcon" completionHandler:^(NSError * _Nullable error) {
            if (error) {
                [_btn3 setTitle:@"更换图标失败" forState:UIControlStateNormal];
                [_btn3 setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
            }
            else {
                [_btn3 setTitle:@"新年图标" forState:UIControlStateNormal];

                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageNamed:@"oneIcon"];
                    [_btn3 setImage:image forState:UIControlStateNormal];
                });
            }
        }];

    }
    else if (btn.tag == 2) {
        [[UIApplication sharedApplication] setAlternateIconName:@"twoIcon" completionHandler:^(NSError * _Nullable error) {
            if (error) {
                [_btn3 setTitle:@"更换图标失败" forState:UIControlStateNormal];
                [_btn3 setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
            }
            else {
                [_btn3 setTitle:@"双十一图标" forState:UIControlStateNormal];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageNamed:@"twoIcon"];
                    [_btn3 setImage:image forState:UIControlStateNormal];
                });
            }
        }];
    }
    else if (btn.tag == 3) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
