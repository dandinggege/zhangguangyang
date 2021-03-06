//
//  ZGYAccountNet+Register.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet.h"

@interface ZGYAccountNet (Register)

/**
 *  用户注册接口
 *
 *  @param userName 用户名
 *  @param password 用户密码
 */
+(void)registerWithUsername:(NSString *)userName andPassword:(NSString *)password handle:(NetHandle)handle;

@end
