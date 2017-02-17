//
//  AFNHelp.m
//  example
//
//  Created by d2c_cyf on 17/2/15.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "AFNHelp.h"

@implementation AFNHelp
+ (void)RequestWithHttpType:(HttpMethod)httpType urlStr:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    if (httpType == GET) {
        [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@",downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];

    }
    else {
       [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
           NSLog(@"%@",uploadProgress);
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           success(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           failure(error);
       }];
    }
}


@end
