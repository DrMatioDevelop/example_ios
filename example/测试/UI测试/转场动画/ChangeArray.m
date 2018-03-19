//
//  ChangeArray.m
//  example
//
//  Created by d2c_cyf on 17/6/30.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "ChangeArray.h"

@implementation ChangeArray
- (NSMutableArray *)muarray {
    if (!_muarray) {
        _muarray = [[NSMutableArray alloc] init];
    }
    return _muarray;
}
@end
