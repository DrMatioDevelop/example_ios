//
//  KIHotFixTool.h
//  example
//
//  Created by d2c_cyf on 2018/3/12.
//  Copyright © 2018年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Aspects.h>

@interface KIHotFixTool : NSObject
+ (void)fixIt;
+ (void)evalString:(NSString *)javaScriptString;
@end
