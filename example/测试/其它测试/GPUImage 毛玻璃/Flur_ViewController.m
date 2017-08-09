//
//  Flur_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/8/8.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Flur_ViewController.h"

@interface Flur_ViewController ()
@property(nonatomic, strong)UILabel *showLabel;
@property(nonatomic ,strong)UISegmentedControl *segmentControl;
@property(nonatomic , strong)UIBlurEffect       *blur;
@end

@implementation Flur_ViewController {
    UIVisualEffectView *_effectView;
    UISlider           *_slider;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _effectView= [[UIVisualEffectView alloc] initWithEffect:self.blur];
    _effectView.frame = CGRectMake(0, 200, SSize.width, 50);
    
    
    UIScrollView *Scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SSize.width, SSize.height)];
    Scrollview.contentSize = CGSizeMake(0, SSize.height * 1.618);
    Scrollview.backgroundColor = [UIColor grayColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, SSize.width - 40, SSize.height * 0.618)];
    imgView.image = [UIImage imageNamed:@"iphone.jpg"];
    [Scrollview addSubview:imgView];
    
    
    [self.view addSubview:Scrollview];
    [self.view addSubview:_effectView];
    
    
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(20, SSize.height - 30 , SSize.width - 40 , 30)];
    [_slider addTarget:self action:@selector(changeSlider:) forControlEvents:UIControlEventValueChanged];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1.0;
    _slider.value = 1.0;
    _slider.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.showLabel];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:_slider];
    
    [self setShowLabel];
    
}

- (void)changeSlider:(UISlider *)slider {
    NSLog(@"%lf",slider.value);
    _effectView.alpha = slider.value;
    [self setShowLabel];
}

- (void)segment:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            break;
        case 1:
            self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];

            break;
        case 2:
            self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

            break;
        default:
            break;
    }
    
    _effectView.effect = self.blur;
    _effectView.alpha = 1.0;
//    _effectView.backgroundColor = [UIColor blueColor];
    _slider.value = 1.0;
    [self setShowLabel];
}


- (void)setShowLabel {
    NSString *Style;

    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            Style = @"light";
            break;
        case 1:
            Style = @"Regular";
            break;
        case 2:
            Style = @"dark";
            break;
        default:
            break;
    }
    NSString *str = [NSString stringWithFormat:@"style:%@  alpha:%.2lf",Style,_slider.value];
    self.showLabel.text = str;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - Getter
- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [KIUIContainerControl getLabel:CGRectMake(0, SSize.height - 120, SSize.width, 40)];
        _showLabel.textColor = [UIColor whiteColor];
        _showLabel.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_showLabel];
    }
    return _showLabel;
}
- (UIBlurEffect *)blur {
    if (!_blur) {
        _blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    return _blur;
}
- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"light",@"Regular",@"dark"]];
        [_segmentControl addTarget:self action:@selector(segment:) forControlEvents:UIControlEventValueChanged];
        _segmentControl.frame = CGRectMake(20, SSize.height - 70, SSize.width - 40, 30);
        _segmentControl.selectedSegmentIndex = 0;
        [self.view addSubview:_segmentControl];
    }
    return _segmentControl;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
