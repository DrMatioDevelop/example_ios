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
    
    //    [self showImageWithSize];
//    [self webPImage];

    [self cutImage];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat scale1 = [UIScreen mainScreen].nativeScale;
    NSLog(@"%lf  %lf",scale,scale1);
    
}
- (void)webPImage {
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 155)];
    NSString *str2 = @"https://d2c-pic.b0.upaiyun.com/2017/06/06/0857088a333a5af9f3448de4635e8c9d40fb7a.jpg!/format/webp/both/86x86";
    NSString *str = @"https://d2c-pic.b0.upaiyun.com/2017/06/06/0857088a333a5af9f3448de4635e8c9d40fb7a.jpg!/both/86x86";
    [image sd_setImageWithURL:[NSURL URLWithString:str2] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"Image down load");
    }];
    [self.view addSubview:image];
}
- (void)cutImage {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 100, 100)];
    [self.view addSubview:imgView];

    NSString *str = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1497326382&di=f513a7198f90f6d5cdbcafa2c03922e2&src=http://img.bbs.cnhubei.com/forum/dvbbs/2004-4/200441915031894.jpg";
    [imgView sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGSize size = image.size;
        
        CGFloat bili = size.width / size.height;
        
        imgView.width  = 500 * bili;
        imgView.height = 500;
        
        
        UIImageView *imageRight = [[UIImageView alloc] initWithFrame:CGRectMake(200, 70, 150, 200)];
        imageRight.backgroundColor = [UIColor redColor];
        UIImage *img = [self imageByScalingAndCroppingForSize:CGSizeMake(150, 200) withSourceImage:imgView.image];
        imageRight.image = img;
        [self.view addSubview:imageRight];
    }];
    
    

}
/**
 * 图片剪切到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        //先用目标宽比原始宽  目标高比原始高  然后比较比例  取最大比例 保证图片完全被
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
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
