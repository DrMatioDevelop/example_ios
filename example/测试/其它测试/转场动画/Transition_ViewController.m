//
//  Transition_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/6/27.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "Transition_ViewController.h"
#import "ChangeArray.h"

#import "TargetViewController.h"
#import "TransitionDelegate.h"
typedef NS_ENUM(NSInteger , btnType) {
    //自上而下
    btnTypeCoverVertical = 0,
    //中心翻转效果
    btnTypeFlipHorizontal,
    //淡出效果
    btnTypeCrossDissolve,
    //上下翻页效果
    btnTypePartialCurl,
    //自定义翻页效果
    btnTypeCustom,
};

@interface Transition_ViewController ()<UIViewControllerTransitioningDelegate>
@property(strong, nonatomic)ChangeArray *object;
@property(strong, nonatomic)Model *model;
@end

@implementation Transition_ViewController
- (void)dealloc {
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自下而上
    UIButton *coverVerticalBtn = [self addBtnWithTitle:@"自下而上" buttonType:btnTypeCoverVertical];
    [self.view addSubview:coverVerticalBtn];
    coverVerticalBtn.frame = CGRectMake(0, 100, coverVerticalBtn.width, coverVerticalBtn.height);
    
    //中心翻转
    UIButton *flipHorizontalBtn = [self addBtnWithTitle:@"中心翻转" buttonType:btnTypeFlipHorizontal];
    [self.view addSubview:flipHorizontalBtn];
    flipHorizontalBtn.frame = CGRectMake(0, 160, flipHorizontalBtn.width, flipHorizontalBtn.height);
    
    //淡出效果
    UIButton *crossDissolveBtn = [self addBtnWithTitle:@"淡出效果" buttonType:btnTypeCrossDissolve];
    [self.view addSubview:crossDissolveBtn];
    crossDissolveBtn.frame = CGRectMake(0, 220, crossDissolveBtn.width, crossDissolveBtn.height);
    
    //上下翻页效果
    UIButton *partialCurlBtn = [self addBtnWithTitle:@"上下翻页效果" buttonType:btnTypePartialCurl];
    [self.view addSubview:partialCurlBtn];
    partialCurlBtn.frame = CGRectMake(0, 280, partialCurlBtn.width, partialCurlBtn.height);
    
    //自定义翻页效果
    UIButton *customBtn = [self addBtnWithTitle:@"自定义效果" buttonType:btnTypeCustom];
    [self.view addSubview:customBtn];
    customBtn.frame = CGRectMake(0, 340, customBtn.width, customBtn.height);
    
}

- (UIButton *)addBtnWithTitle:(NSString *)title buttonType:(btnType)type {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = type;
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClick:(UIButton *)btn {
    TargetViewController *targetVC = [[TargetViewController alloc] init];
    
    switch (btn.tag) {
            case btnTypeCoverVertical:{
                targetVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                break;
            }
            case btnTypeFlipHorizontal:{
                targetVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                break;
            }
            case btnTypeCrossDissolve:{
                targetVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                break;
            }
            case btnTypePartialCurl:{
                targetVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
                break;
            }
            case btnTypeCustom:{
                targetVC.modalPresentationStyle = UIModalPresentationCustom;
                targetVC.transitioningDelegate = [TransitionDelegate shareInstance];
                break;
            }
        default:
            break;
    }
    
    
    [self presentViewController:targetVC animated:YES completion:nil];
}

@end














@implementation Model
-(NSMutableArray *)modelArray{
    if(!_modelArray){
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
