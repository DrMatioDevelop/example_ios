//
//  PeopleProperty.h
//  example
//
//  Created by d2c_cyf on 16/12/2.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PeopleProperty : NSObject
@property(nonatomic,copy  )NSString   *name;
@property(nonatomic,assign)NSInteger  age;
@property(nonatomic,strong)NSString   *sex;

+ (UIButton *)buyNewCar:(UIFont *)font;

- (UILabel *)createSmallCar:(NSArray *)array;
@end
