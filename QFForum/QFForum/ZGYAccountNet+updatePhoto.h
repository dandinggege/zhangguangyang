//
//  ZGYAccountNet+updatePhoto.h
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet.h"

#import <UIKit/UIKit.h>

@interface ZGYAccountNet (updatePhoto)

/**
 *  post上传头像
 *
 *  @param userId 用户ID
 *  @param image  图片
 *  @param handle 回调
 */
+(void)postImgWithUid:(NSString *)userId
                image:(UIImage *)image
               handle:(NetHandle)handle;

@end
