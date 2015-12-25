//
//  ZGYAccountNet+changePw.h
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet.h"

@interface ZGYAccountNet (changePw)

/**
 *  修改密码接口
 *
 *  @param userName 用户名
 *  @param password 用户旧的密码
 *  @param newPw    新密码
 *  @param handle   回调
 */
+(void)changePwWithUserName:(NSString *)userName
                   password:(NSString *)password
                      newPw:(NSString *)newPw
                     handle:(NetHandle)handle;

@end
