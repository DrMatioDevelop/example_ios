//
//  People.h
//  example
//
//  Created by d2c_cyf on 16/12/2.
//  Copyright © 2016年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleProperty.h"

@interface People : NSObject
@property(nonatomic,assign)float     weight ;
@property(nonatomic,copy  )NSString  *likely;
@property(nonatomic,strong)PeopleProperty *pProperty;

+ (UIButton *)buyNewCar:(UIFont *)font;

- (UILabel *)createSmallCar:(NSArray *)array;

- (NSString *)normalMsgSendTest:(NSString *)str;

+ (NSString *)classMsgSendTest:(NSString *)str;

- (NSString *)changeMethod:(NSString *)str;
@end
