//
//  People+Categroy.h
//  example
//
//  Created by d2c_cyf on 17/4/14.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "People.h"

@interface People (Categroy)
- (void)pleaseTellMeName;

@property(nonatomic, strong, readonly)NSArray   *myHousesArray;

@property(nonatomic, assign, readonly)NSInteger carNum;

@property(nonatomic, strong)UILabel *peopleLabel;
@end
