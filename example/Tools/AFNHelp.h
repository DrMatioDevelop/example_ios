//
//  AFNHelp.h
//  example
//
//  Created by d2c_cyf on 17/2/15.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HttpMethod){
    GET,
    POST,
    OTHER
};
@interface AFNHelp : NSObject
+ (void)RequestWithHttpType:(HttpMethod)httpType urlStr:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^) (NSDictionary *responseJson))success failure:(void (^) (NSError *error))failure;
@end
