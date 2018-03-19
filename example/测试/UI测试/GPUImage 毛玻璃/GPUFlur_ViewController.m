//
//  GPUFlur_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/8/9.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "GPUFlur_ViewController.h"

@interface GPUFlur_ViewController ()

@end

@implementation GPUFlur_ViewController


/**
 网上对使用GPUImage进行时时毛玻璃的效果，  首先将一张长的图片进行毛玻璃 ； 然后头上添加一个view，再添加一个毛玻璃后的view进行滚动以达到毛玻璃的效果
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIScrollView *Scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SSize.width, SSize.height)];
    Scrollview.contentSize = CGSizeMake(0, SSize.height * 1.618);
    Scrollview.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, SSize.width - 40, SSize.height * 0.618)];
    imgView.image = [UIImage imageNamed:@"iphone.jpg"];
    [Scrollview addSubview:imgView];
    [self.view addSubview:Scrollview];
    
    
    GPUImageGaussianBlurFilter *gaussianBlur = [[GPUImageGaussianBlurFilter alloc] init];
    gaussianBlur.blurRadiusInPixels = 5.0f;
    UIImage *gaussImage = [gaussianBlur imageByFilteringImage:imgView.image];
    
    
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SSize.width, 50)];

    UIImageView *imgViewFlur = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, SSize.width, 200)];
    imgViewFlur.image = gaussImage;
    [self.view addSubview:imgViewFlur];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
