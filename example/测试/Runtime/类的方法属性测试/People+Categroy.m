//
//  People+Categroy.m
//  example
//
//  Created by d2c_cyf on 17/4/14.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "People+Categroy.h"

@implementation People (Categroy)
- (void)pleaseTellMeName {
    NSLog(@"my name is cyf");
}

- (NSArray *)myHousesArray {
    NSArray *object = objc_getAssociatedObject(self, @selector(myHousesArray));
    if (!object) {
        object = [[NSArray alloc] init];
        objc_setAssociatedObject(self, @selector(myHousesArray), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return object;
}

- (NSInteger)carNum {
    NSNumber *object = objc_getAssociatedObject(self, @selector(carNum));
    if (!object) {
        object = [[NSNumber alloc] initWithInt:999];
        objc_setAssociatedObject(self, @selector(carNum), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [object integerValue];
}
- (UILabel *)peopleLabel {
    UILabel *object = objc_getAssociatedObject(self, @selector(peopleLabel));
    if (!object) {
        object = [[UILabel alloc] init];
        object.text = @"cyf god like";
        object.frame = CGRectMake(0, 0, 100, 61.8);
        object.backgroundColor = [UIColor yellowColor];
        objc_setAssociatedObject(self, @selector(peopleLabel), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return object;
}

- (void)setPeopleLabel:(UILabel *)peopleLabel {
    objc_setAssociatedObject(self, @selector(peopleLabel), peopleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
