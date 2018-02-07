//
//  UI_Input_VC.m
//  example
//
//  Created by d2c_cyf on 2018/2/6.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import "UI_Input_VC.h"

//并不能实现文章中效果 http://blog.csdn.net/minggeqingchun/article/details/68942473
@interface UI_Input_VC ()
@property(nonatomic, strong)UITextField *myTextField;
//弹出的视图      键盘的位置
@property(nonatomic, strong)UILabel      *customInputView;
//弹出的辅助视图   键盘的辅助视图
@property(nonatomic, strong)UIToolbar   *customAccessoryView;
@end

@implementation UI_Input_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.myTextField];
}
- (void)clickConfirm:(UIBarButtonItem *)barItem {
    NSLog(@"%s",__func__);
}
- (void)clickCancle:(UIBarButtonItem *)barItem {
    NSLog(@"%s",__func__);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.myTextField resignFirstResponder];
}
- (UITextField *)myTextField {
    if (!_myTextField) {
        _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 100, 38)];
        _myTextField.centerX   = self.view.centerX;
        _myTextField.placeholder = @"自定义弹出视图验证";
        _myTextField.inputView          = self.customInputView;
        _myTextField.inputAccessoryView = self.customAccessoryView;
        [self.view addSubview:_myTextField];
    }
    return _myTextField;
}
- (UIToolbar *)customAccessoryView {
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 220)];
        _customAccessoryView.barTintColor = [UIColor orangeColor];
        UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(clickConfirm:)];
        UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(clickCancle:)];
        
        [_customAccessoryView setItems:@[cancleBtn, confirmBtn]];
    }
    return _customAccessoryView;
}
- (UILabel *)customInputView {
    if (!_customInputView) {
        _customInputView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SSize.width, 220)];
        _customInputView.text = @"键盘位置的自定义弹出窗";
        _customInputView.backgroundColor = [UIColor clearColor];
        _customInputView.textColor = [UIColor cyanColor];
    }
    return _customInputView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
