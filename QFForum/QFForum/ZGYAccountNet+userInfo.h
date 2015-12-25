//
//  ZGYAccountNet+userInfo.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet.h"

@interface ZGYAccountNet (userInfo)

/**
 *  获取用户信息
 *
 *  @param userId 用户id
 */
+(void)getUserInfoWithUserId:(NSString *)userId handle:(NetHandle)handle;

@end
