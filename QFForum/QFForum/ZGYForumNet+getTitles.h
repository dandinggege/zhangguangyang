//
//  ZGYForumNet+getTitles.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYForumNet.h"

@interface ZGYForumNet (getTitles)

/**
 *  获取标题信息
 *
 *  @param pageNum   哪一🍃，必须>=1;
 *  @param pageCount    一页多少条数据，必须>=1;
 *  @param handle 结果回调
 */
+(void)getTitlesWithPageNum:(NSInteger)pageNum
                  pageCount:(NSInteger)pageCount
                     handle:(NetHandle)handle;

@end
