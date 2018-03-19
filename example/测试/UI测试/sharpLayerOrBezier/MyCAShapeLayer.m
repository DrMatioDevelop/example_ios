//
//  MyCAShapeLayer.m
//  example
//
//  Created by d2c_cyf on 17/4/6.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "MyCAShapeLayer.h"

@implementation MyCAShapeLayer
- (NSDictionary *)infoDic {
    if (!_infoDic) {
        _infoDic = [[NSDictionary alloc] init];
    }
    return _infoDic;
}
@end
