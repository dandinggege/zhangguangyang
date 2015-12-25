//
//  ZGYForumNet+submitOneTitle.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYForumNet.h"

@interface ZGYForumNet (submitOneTitle)

/**
 *  提交主题内容
 *
 *  @param titleDescryption 主题描述
 *  @param imgs             图片数组（UIImage元素的数组）
 *  @param handle           回调
 */
+(void)submitTitleWithDescryption:(NSString *)titleDescryption
                             imgs:(NSArray *)imgs
                           handle:(NetHandle)handle;

@end
