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

//获取时间戳，1970到当前的毫秒数
+ (NSString *)getTimeStamp;


#pragma mark - 功能处理 -

//md5加密
+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String;

@end
