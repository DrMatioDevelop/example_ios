//
//  GPU_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/3/16.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "GPU_ViewController.h"
#import "UIImage+FEBoxBlur.h"
#import "UIImage+GPUImage.h"

@interface GPU_ViewController ()
@property  (strong,nonatomic)  UITextField  *textField;
@property  (strong,nonatomic)  UIButton     *button;

@property  (strong,nonatomic)  UIImage      *image;
@property  (strong,nonatomic)  UILabel      *selectImgInfo;
@property  (strong,nonatomic)  UIButton     *resetBtn;
@property  (strong,nonatomic)  UIImageView  *imageView;
@property  (strong,nonatomic)  UIImageView  *imageView1;
@property  (strong,nonatomic)  UIImageView  *imageView2;
@property  (strong,nonatomic)  UITapGestureRecognizer *tap;
@property  (assign,nonatomic)  NSInteger    tapTag;
@end

@implementation GPU_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    [self configSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

#pragma mark - UIButton
-(void)changeImageBlur:(UIButton *)sender{
    CGFloat value=[self.textField.text floatValue];
    switch (self.tapTag) {
        case 0:
            self.imageView.image=[UIImage coreBlurImage:[UIImage imageNamed:@"Person"] withBlurNumber:value];
            
            break;
        case 1:
            self.imageView1.image=[UIImage boxblurImage:[UIImage imageNamed:@"Person"] withBlurNumber:value];
            
            break;
        case 2:
            self.imageView2.image = [UIImage applayGaussianSelectiveBlur:[UIImage imageNamed:@"Person"] withBlurNumber:value];
            break;
        default:
            break;
    }
}
- (void)clickResetBtn:(UIButton *)btn {
    self.imageView.image = [UIImage imageNamed:@"Person"];
    self.imageView1.image = [UIImage imageNamed:@"Person"];
    self.imageView2.image = [UIImage imageNamed:@"Person"];
}

- (void)clickTap:(UITapGestureRecognizer *)tap {
    
    UIView *view = [tap view];
    self.tapTag = view.tag;
    
    switch (self.tapTag) {
        case 0:
            self.selectImgInfo.text = @"coreimg(0-n,10)";
            break;
        case 1:
            self.selectImgInfo.text = @"vImage(0-1,0.5)";
            
            break;
        case 2:
            self.selectImgInfo.text = @"GPUImg(0-n,5)";
            break;
        case 3:
            self.selectImgInfo.text = @"原图";
            break;
        default:
            break;
    }
}
#pragma mark - SubViews
-(void)configSubviews{
    [self.view addSubview:self.textField];
    [self.view addSubview:self.button];
    [self.view addSubview:self.selectImgInfo];
    [self.view addSubview:self.resetBtn];
    
    [self configImageOne];
    [self configImageTwo];
    [self configImageThree];
    [self configImageFour];
}
-(void)configImageOne{
    self.imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 110, SSize.width, 100)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage coreBlurImage:self.image withBlurNumber:10];
    self.imageView.clipsToBounds=YES;
    self.imageView.tag = 0;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
    [self.view addSubview:self.imageView];
}

-(void)configImageTwo{
    self.imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 220, SSize.width, 100)];
    self.imageView1.contentMode=UIViewContentModeScaleAspectFill;
    self.imageView1.image=[UIImage boxblurImage:self.image withBlurNumber:0.5];
    self.imageView1.clipsToBounds=YES;
    self.imageView1.tag = 1;
    self.imageView1.userInteractionEnabled = YES;
    [self.imageView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
    [self.view addSubview:self.imageView1];
}

-(void)configImageThree{
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 330, SSize.width, 100)];
    self.imageView2.contentMode=UIViewContentModeScaleAspectFill;
    self.imageView2.image= [UIImage applayGaussianSelectiveBlur:self.image withBlurNumber:5.0];
    self.imageView2.clipsToBounds=YES;
    self.imageView2.tag = 2;
    self.imageView2.userInteractionEnabled = YES;
    [self.imageView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
    [self.view addSubview:self.imageView2];
}

-(void)configImageFour{
    UIImageView *image =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 440, SSize.width, 100)];
    image.contentMode=UIViewContentModeScaleAspectFill;
    image.image= self.image;
    image.clipsToBounds=YES;
    image.tag = 3;
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
    [self.view addSubview:image];
}

#pragma mark  - getter and  setter
-(UIButton *)button{
    if (!_button) {
        _button=[[UIButton alloc]initWithFrame:CGRectMake(285,64, 80, 40)];
        _button.layer.borderColor=[[UIColor redColor] CGColor];
        _button.layer.borderWidth=1.0f;
        [_button setTitle:@"设置" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_button addTarget:self action:@selector(changeImageBlur:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(200, 64, 80, 40)];
        [_textField setPlaceholder:@"测试"];
        [_textField setBorderStyle:UITextBorderStyleLine];
        [_textField setFont:[UIFont systemFontOfSize:14]];
        _textField.keyboardType = UIKeyboardTypeDefault;
    }
    return _textField;
}

-(UIImage *)image{
    if (!_image) {
        _image=[UIImage imageNamed:@"Person"];
    }
    return _image;
}
- (UILabel *)selectImgInfo {
    if (!_selectImgInfo) {
        _selectImgInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 100, 40)];
        _selectImgInfo.font = [UIFont systemFontOfSize:12.0];
        _selectImgInfo.layer.borderColor=[[UIColor redColor] CGColor];
        _selectImgInfo.layer.borderWidth=1.0f;
        _selectImgInfo.numberOfLines = 0;
        _selectImgInfo.textColor = [UIColor redColor];
    }
    return _selectImgInfo;
}
- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn=[[UIButton alloc]initWithFrame:CGRectMake(110, 64, 80, 40)];
        _resetBtn.layer.borderColor=[[UIColor redColor] CGColor];
        _resetBtn.layer.borderWidth=1.0f;
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_resetBtn addTarget:self action:@selector(clickResetBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _resetBtn;
}

@end
