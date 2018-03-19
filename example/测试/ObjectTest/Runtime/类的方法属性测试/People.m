//
//  People.m
//  example
//
//  Created by d2c_cyf on 16/12/2.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import "People.h"
#import "People+Categroy.h"

@interface People ()
@property(nonatomic, strong)UILabel *testLabel;
@end
@implementation People{
    NSString *_address;
}
- (instancetype)init {
    if (self = [super init]) {
        self.pProperty = [[PeopleProperty alloc] init];
    }
    return self;
}
- (UILabel *)createSmallCar:(NSArray *)array {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 61.8);
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

- (UILabel *)createBigHouse {
    NSLog(@"%s is a private method",__FUNCTION__);
    return [UILabel new];
}

- (NSString *)normalMsgSendTest:(NSString *)str {
    NSLog(@"%s : %@",__FUNCTION__, str);
    return str;
}

- (NSString *)changeMethod:(NSString *)str {
    NSString *returnStr = [NSString stringWithFormat:@"cyf %@",str];
    NSLog(@"%@",returnStr);
    return returnStr;
}

+ (NSString *)classMsgSendTest:(NSString *)str {
    NSLog(@"%s : %@",__FUNCTION__ , str);
    return str;
}

@end
