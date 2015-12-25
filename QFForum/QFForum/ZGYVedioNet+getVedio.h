//
//  ZGYVedioNet+getVedio.h
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYVedioNet.h"

@interface ZGYVedioNet (getVedio)

/**
 *  获取视频列表
 *
 *  @param vedioCagegory 视频分类id
 *  @param pageNum       那一夜
 *  @param pageCount     多少条一页
 *  @param handle        回调
 */
+(void)getVediosWithVedioCategory:(NSString *)vedioCagegory
                          pageNum:(NSInteger)pageNum
                        pageCount:(NSInteger)pageCount
                           handle:(NetHandle)handle;

@end
