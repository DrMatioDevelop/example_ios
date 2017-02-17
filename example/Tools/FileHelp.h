//
//  FileHelp.h
//  example
//
//  Created by d2c_cyf on 17/2/17.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelp : NSObject

/**
 文件是否存在当前目录

 @param str  当前目录地址
 @return     BOOL
 */
+ (BOOL)existFileWithUrlStr:(NSString *)str;

/**
 获取文件路径下的内容  fileType为制定的文件类型  制定则返回当前文件下所有的内容，包括子文件夹

 @param urlStr    目录地址
 @param fileType  文件属性
 @return          数组
 */
+ (NSArray *)getFileWithUrlStr:(NSString *)urlStr fileType:(NSString *)fileType;
/**
 发返回当前目录下文件的个数  会查找子文件夹下

 @param str 当前目录地址
 @return    目录下文件个数  未存在目录或者目录下无文件均返回0
 */
+ (NSInteger)getDeepFileCountWithUrlStr:(NSString *)str;


/**
 发返回当前目录下文件的个数

 @param urlStr 前目录地址
 @param fileType 文件属性
 @return 目录下文件个数
 */
+ (NSInteger)getFileCountWithUrlStr:(NSString *)urlStr fileType:(NSString *)fileType;


/**
 创建目录

 @param urlStr       目录地址
 @param intermediate YES创建缺失的中间目录  NO不创建缺失的中间目录;
 @return             是否创建成功
 */
+ (BOOL)createDirectoriesWithUrlStr:(NSString *)urlStr intermediateDirectories:(BOOL)intermediate;


/**
 写文件  会覆盖

 @param urlStr <#urlStr description#>
 @param data <#data description#>
 @return <#return value description#>
 */
+ (BOOL)createFileWithUrlStr:(NSString *)urlStr data:(NSData *)data;


/**
 拷贝文件

 @param atPath <#atPath description#>
 @param toPath <#toPath description#>
 @return <#return value description#>
 */
+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;


/**
 删除文件（多属性） 保留目录

 @param urlStr   目录地址
 @param fileTypes 为空删除目录下的所有文件  不为空按照属性删除
 @return BOOL是否删除成功
 */
+ (BOOL)removeFileAndKeepDirectoryWithUrlStr:(NSString *)urlStr fileTypes:(NSArray *)fileTypes;

/**
 删除目录文件/ 删除唯一的文件
 
 @param urlStr 目录地址
 @return 是否删除成功
 */
+ (BOOL)removeFileWithUrlStr:(NSString *)urlStr ;
@end
