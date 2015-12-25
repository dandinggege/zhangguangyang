//
//  ZGYForumNet+submitComment.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYForumNet.h"

@interface ZGYForumNet (submitComment)

/**
 *  提交评论
 *
 *  @param titleId     主题id
 *  @param descryption 评论描述
 *  @param imgs        图片数组（UIImage的数组）
 *  @param handle      回调
 */
+(void)submitCommentWithTitleId:(NSString *)titleId
                    descryption:(NSString *)descryption
                           imgs:(NSArray *)imgs
                         handle:(NetHandle)handle;

@end
