//
//  CommentsModel.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "JSONModel.h"

#import "OneCommentModel.h"

@interface CommentsModel : JSONModel

//状态
@property (nonatomic,copy) NSString * status;
//消息
@property (nonatomic,copy) NSString * msg;
//服务器处理日期
@property (nonatomic,copy) NSString * date;
//评论列表
@property (nonatomic,strong) NSArray<OneCommentModel> * comments;

@end
