//
//  ZGYVedioNet+getCategory.h
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYVedioNet.h"

@interface ZGYVedioNet (getCategory)

/**
 *  获取视频分类
 *
 *  @param handle 回调
 */
+(void)getVedioCategory:(NetHandle)handle;

@end
