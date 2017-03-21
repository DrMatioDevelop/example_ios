//
//  UI_ViewController.m
//  example
//
//  Created by d2c_cyf on 17/3/21.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "UI_ViewController.h"

@interface UI_ViewController ()
@property (nonatomic , strong)UITextField *myTextField;
@property (nonatomic , strong)UISearchBar *searchBar;
@end

@implementation UI_ViewController
- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.title = @"UI测试";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myTextField];
    
    [self.view addSubview:self.searchBar];
    
}

- (UITextField *)myTextField {
    if (!_myTextField) {
        _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(70.0 / 2.0, 100, SSize.width - 70.0, 30)];
        _myTextField.backgroundColor = ColorRGBA(240, 240, 240, 1);
        _myTextField.font = Font(14);
        _myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _myTextField.returnKeyType = UIReturnKeySearch;
        _myTextField.layer.cornerRadius = 5.0;
        _myTextField.contentMode = UIViewContentModeCenter;
        
        UIImageView *searchImage  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 28)];
        searchImage.image         = [UIImage imageNamed:@"icon_a_search_l"];
        _myTextField.leftView     = searchImage;
        _myTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        NSString *holdText = @"商品、设计师搜索";

        NSMutableAttributedString *placeholderAttribute = [[NSMutableAttributedString alloc] initWithString:holdText];
        [placeholderAttribute addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(0, holdText.length)];
        [placeholderAttribute addAttribute:NSForegroundColorAttributeName value:ColorRGB(283, 85, 98) range:NSMakeRange(0, holdText.length)];
        _myTextField.attributedPlaceholder = placeholderAttribute;
    }
    return _myTextField;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60.0 / 2.0, 150, SSize.width - 60.0, 30)];
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.contentMode = UIViewContentModeCenter;
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.placeholder = @"商品、设计师搜索";
        for (UIView *view in _searchBar.subviews) {
            for (UIView *view2 in view.subviews) {
                if ([view2 isMemberOfClass:[NSClassFromString(@"UISearchBarBackground") class]]) {
                    [view2 removeFromSuperview];
                }
                if ([view2 isMemberOfClass:[NSClassFromString(@"UISearchBarTextField") class]]) {
                    UITextField *textField = (UITextField *)view2;
                    textField.backgroundColor = ColorRGBA(240, 240, 240, 1);
                    textField.font = Font(14);
                    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
                    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
                }
            }
        }
    }
    return _searchBar;
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
