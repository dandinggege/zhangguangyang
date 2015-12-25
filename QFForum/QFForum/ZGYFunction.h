//
//  ZGYFunction.h
//  AccountSystemTestDemo
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGYFunction : NSObject

#pragma mark - 获取参数 -

/**
 *  获取事件戳
 *
 *  @return 获取时间戳，1970到当前的毫秒数
 */
+ (NSString *)getTimeStamp;


#pragma mark - 功能处理 -
/**
 *  md5加密
 *
 *  @param beforeMD5String 加密前的字符串
 *
 *  @return md5加密后的字符串
 */
+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String;


#pragma mark - 正则匹配 -
/**
 *  正则匹配
 *
 *  @param regexStr 匹配规则字符串
 *  @param content  匹配内容字符串
 *
 *  @return YES：匹配；NO：不匹配
 */
+(BOOL)regularMatchWithRegex:(NSString *)regexStr content:(NSString *)content;

@end
