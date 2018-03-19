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

@property(nonatomic, strong)NSDictionary *textReviewDic;
@end

@implementation UI_Input_VC
//_textReviewDic 成员变量
//textReviewDic  属性
@synthesize textReviewDic = _textReviewDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.myTextField];
    
    [self copyOrMutableCopy];


}


/**
 浅拷贝 指针拷贝，深拷贝 内存拷贝;能拷贝的对象必须尊徐<NSCopying>协议
 结论：1.copy        永远是不可变的. 对于不可变的对象不会产生新的内存  对于可变对象生成新的内存
      2.mutableCopy 都会生成新的内存
 */
- (void)copyOrMutableCopy {
//        NSDictionary *testDic = @{@"1":@"1",@"2":@"2",@"3":@"3"};
//        NSDictionary *testDic1 = [testDic mutableCopy];
//        NSLog(@"1.---self.textReviewDic:%p %@ \ntestDic1:%p %@",testDic,testDic,testDic1,testDic1);
//
//        testDic1 = @{@"a":@"a",@"b":@"b",@"c":@"c"};
//        NSLog(@"2.---self.textReviewDic:%p %@ \ntestDic1:%p %@",testDic,testDic,testDic1,testDic1);
//
//        testDic = @{@"A":@"A",@"B":@"B",@"C":@"C"};
//        NSLog(@"3.---self.textReviewDic:%p %@ \ntestDic1:%p %@",testDic,testDic,testDic1,testDic1);
    
        NSLog(@"NSMutableArray-------------");
        NSMutableArray *muarray = [[NSMutableArray alloc] initWithArray:@[@1,@2,@3,@4,@5,@6]];
        NSMutableArray *muarray1 = [muarray copy];
        NSMutableArray *muarray2 = [muarray mutableCopy];
        NSLog(@"\nmuarray:%p %@ \nmuarray1:%p %@ \nmuarray2:%p %@",muarray,muarray,muarray1,muarray1,muarray2,muarray2);
    
        [muarray addObject:@"7"];
    //    [muarray1 addObject:@"a"]; //copy拷贝不可变
        [muarray2 removeLastObject];
        NSLog(@"\nmuarray:%p %@ \nmuarray1:%p %@ \nmuarray2:%p %@",muarray,muarray,muarray1,muarray1,muarray2,muarray2);
    
        NSLog(@"NSArray-------------");
        NSArray *array = @[@1,@2,@3,@4,@5,@6];
        NSArray *array1 = [array copy];
        NSMutableArray *array2 = [array mutableCopy];
        NSLog(@"\n array:%p %@ \n array1:%p %@ \n array2:%p %@",array,array,array1,array1,array2,array2);

        [array2 addObject:@(7)];
        NSLog(@"\n array:%p %@ \n array1:%p %@ \n array2:%p %@",array,array,array1,array1,array2,array2);
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

- (NSDictionary *)textReviewDic {
    return _textReviewDic;
}
- (void)setTextReviewDic:(NSDictionary *)textReviewDic {
    _textReviewDic = textReviewDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
