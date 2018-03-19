//
//  PeopleProperty.m
//  example
//
//  Created by d2c_cyf on 16/12/2.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "PeopleProperty.h"

@implementation PeopleProperty

- (UILabel *)createSmallCar:(NSArray *)array {
    UILabel *label = [[UILabel alloc] init];
    if (array) {
        label.text = [array componentsJoinedByString:@","];
    }
    else {
        label.text = @"null";
    }
    return label;
}

+ (UIButton *)buyNewCar:(UIFont *)font {
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = font;
    
    [button setTitle:@"newCar" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return button;
}
@end
