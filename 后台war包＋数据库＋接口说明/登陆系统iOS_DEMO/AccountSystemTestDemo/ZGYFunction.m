//
//  ZGYFunction.m
//  AccountSystemTestDemo
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYFunction.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation ZGYFunction

+ (NSString *)getTimeStamp
{
    double secondTime=[[[NSDate alloc]init]timeIntervalSince1970];
    double millisecondTime=secondTime*1000;
    NSString * millisecondTimeStr=[NSString stringWithFormat:@"%f",millisecondTime];
    NSRange pointRange=[millisecondTimeStr rangeOfString:@"."];
    NSString * MSTime=[millisecondTimeStr substringToIndex:pointRange.location];
    //判断全打印
    return MSTime;
}


+(NSString *)getMD5StrFromString:(NSString *)beforeMD5String
{
    const char * cString = [beforeMD5String UTF8String];
    unsigned char result[16];
    CC_MD5(cString, (CC_LONG)strlen((const char *)cString), result);
    NSString *sign= [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    return [sign uppercaseString];
}

@end
