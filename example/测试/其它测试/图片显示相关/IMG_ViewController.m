//
//  IMG_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/5/15.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "IMG_ViewController.h"

@interface IMG_ViewController ()
@property(nonatomic , strong)UIImageView *imgView;
@property(nonatomic , strong)UIImageView *originImgView;
@end

@implementation IMG_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showImageWithSize];

    
}
#pragma mark - 设置img的size 与 imgView的显示模式
- (void)showImageWithSize {
    self.imgView.frame = CGRectMake(50, 100, 150, 150);
    //会首先满足一个宽或者高  并且居中图片
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
//    self.imgView.clipsToBounds = YES;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.d2c.cn/2017/04/15/062525c0c993c33d6029e3313a3e7f921d290e.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            NSLog(@"c:%ld w:%lf  h:%lf",(long)cacheType, image.size.width, image.size.height);
        }
    }];
    
    
    self.originImgView.frame = CGRectMake(270, 100, 100.0, 155.0);
    [self.originImgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.d2c.cn/2017/04/15/062525c0c993c33d6029e3313a3e7f921d290e.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            NSLog(@"o:%ld w:%lf  h:%lf",(long)cacheType, image.size.width, image.size.height);
        }
    }];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.borderColor = [UIColor blueColor].CGColor;
        _imgView.layer.borderWidth = 1.0;
        [self.view addSubview:_imgView];
    }
    return _imgView;
}


- (UIImageView *)originImgView {
    if (!_originImgView) {
        _originImgView = [[UIImageView alloc] init];
        _originImgView.layer.borderColor = [UIColor blueColor].CGColor;
        _originImgView.layer.borderWidth = 1.0;
        [self.view addSubview:_originImgView];
    }
    return _originImgView;
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
