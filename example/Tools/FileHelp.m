//
//  FileHelp.m
//  example
//
//  Created by d2c_cyf on 17/2/17.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import "FileHelp.h"

@implementation FileHelp
+ (FileHelp *)fileManagerShareInstance {
    static dispatch_once_t onceToken;
    static FileHelp *fileManager = nil;
    dispatch_once(&onceToken, ^{
        fileManager = [[self alloc] init];
    });
    return fileManager;
}


+ (BOOL)existFileWithUrlStr:(NSString *)str {
    if (!str) {
        return NO;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:str];
}


+ (NSInteger)getDeepFileCountWithUrlStr:(NSString *)str {
    return [FileHelp getFileWithUrlStr:str fileType:nil].count;
}

+ (NSInteger)getFileCountWithUrlStr:(NSString *)urlStr fileType:(NSString *)fileType {
    return [FileHelp getFileWithUrlStr:urlStr fileType:fileType].count;
}

+ (NSArray *)getFileWithUrlStr:(NSString *)urlStr fileType:(NSString *)fileType {
    if (!urlStr) {
        return [[NSArray alloc] init];
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    if (fileType) {
        NSArray *array = [manager contentsOfDirectoryAtPath:urlStr error:&error];
        if (error) {
            NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
            return [[NSArray alloc] init];
        }
        NSPredicate *predicateStr = [NSPredicate predicateWithFormat:@"self ENDSWITH[cd] %@",fileType];
        return [array filteredArrayUsingPredicate:predicateStr];
       
    }
    else {
        NSArray *array = [manager subpathsOfDirectoryAtPath:urlStr error:&error];
        if (error) {
            NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
        }
        return array;
    }
}

+ (BOOL)createDirectoriesWithUrlStr:(NSString *)urlStr intermediateDirectories:(BOOL)intermediate {
    if (!urlStr) {
        return NO;
    }
    NSError *error = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isYES= [manager createDirectoryAtPath:urlStr withIntermediateDirectories:intermediate attributes:nil error:&error];
    if (error) {
        NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
        return NO;
    }
    return isYES;
    
}

+ (BOOL)createFileWithUrlStr:(NSString *)urlStr data:(NSData *)data {
    if (!urlStr) {
        return NO;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isYES = [manager createFileAtPath:urlStr contents:data attributes:nil];
    return isYES;
}

+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath {
    if (!atPath || !toPath) {
        return NO;
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError       *error   = nil;
    BOOL isYES = [manager copyItemAtPath:atPath toPath:toPath error:&error];
    if (error) {
        NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
        return NO;
    }
    return isYES;
}

+ (BOOL)removeFileAndKeepDirectoryWithUrlStr:(NSString *)urlStr fileTypes:(NSArray *)fileTypes {
    if (!urlStr) {
        return NO;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError       *error   = nil;
    
    NSMutableArray *muarray = [NSMutableArray arrayWithArray:[manager contentsOfDirectoryAtPath:urlStr error:&error]];
    if (error) {
        NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
        return NO;
    }
    else {
        for (int i = 0; i < fileTypes.count - 1; i++) {
            NSString *fileType = fileTypes[i];
            NSArray *sameFileAttributesArray = nil;
            
            for (int j = 0; j < muarray.count - 1; j++) {
                NSPredicate *predicateStr = [NSPredicate predicateWithFormat:@"self ENDWIDTH[cd] %@",fileType];
                sameFileAttributesArray   = [muarray filteredArrayUsingPredicate:predicateStr];
            }
            
            for (NSString *fileName in sameFileAttributesArray) {
                BOOL isYES = [FileHelp removeFileWithUrlStr:[urlStr stringByAppendingPathComponent:fileName]];
                if (!isYES) {
                    NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
                    return NO;
                }
            }
        }

        return YES;
    }
}

/**
 删除目录文件/ 删除唯一的文件

 @param urlStr 目录地址
 @return 是否删除成功
 */
+ (BOOL)removeFileWithUrlStr:(NSString *)urlStr {
    if (!urlStr) {
        return NO;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError       *error   = nil;
    BOOL isYES = [manager removeItemAtPath:urlStr error:&error];
    if (error) {
        NSLog(@"%@_%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd),error);
        return NO;
    }
    return isYES;
}

@end
