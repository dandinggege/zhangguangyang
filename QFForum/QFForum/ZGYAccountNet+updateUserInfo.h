//
//  ZGYAccountNet+updateUserInfo.h
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet.h"

@interface ZGYAccountNet (updateUserInfo)

/**
 *  更新用户信息
 *
 *  @param userId  用户的uId
 *  @param age     年龄
 *  @param email   邮箱
 *  @param address 地址
 */
+(void)updateUserInfoWithUserId:(NSString *)userId
                            Age:(NSString *)age
                          Email:(NSString *)email
                        address:(NSString *)address
                         handle:(NetHandle)handle;

@end
