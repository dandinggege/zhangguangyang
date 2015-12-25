//
//  OneCommentModel.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "JSONModel.h"

@protocol OneCommentModel <NSObject>

@end

@interface OneCommentModel : JSONModel

//评论人名字
@property (nonatomic,copy)NSString * commentAutorName;
//评论人头像
@property (nonatomic,copy)NSString * commentAutorPhoto;
//评论人uid
@property (nonatomic,copy)NSString * commentAutorUid;
//评论日期
@property (nonatomic,copy)NSString * commentDate;
//评论描述
@property (nonatomic,copy)NSString * commentDescryption;
//评论id
@property (nonatomic,copy)NSString * commentId;
//评论图片
@property (nonatomic,copy)NSString * commentImages;
//标题id
@property (nonatomic,copy)NSString * titleId;

@end
