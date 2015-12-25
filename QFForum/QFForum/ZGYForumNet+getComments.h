//
//  ZGYForumNet+getComments.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYForumNet.h"

@interface ZGYForumNet (getComments)

/**
 *  获取评论
 *
 *  @param titleId   主题ID
 *  @param pageNum   页数
 *  @param pageCount 每页条数
 *  @param handle    回调
 */
+(void)getCommentsWithTitleId:(NSString *)titleId
                      pageNum:(NSInteger)pageNum
                    pageCount:(NSInteger)pageCount
                       handle:(NetHandle)handle;

@end
