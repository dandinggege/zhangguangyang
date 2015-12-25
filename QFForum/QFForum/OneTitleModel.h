//
//  OneTitleModel.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "JSONModel.h"

@protocol OneTitleModel <NSObject>

@end

@interface OneTitleModel : JSONModel

//评论数
@property (nonatomic,copy) NSString * commentCount;
//作者名字
@property (nonatomic,copy) NSString * titleAutorName;
//作者头像
@property (nonatomic,copy) NSString * titleAutorPhoto;
//作者uid
@property (nonatomic,copy) NSString * titleAutorUid;
//发布日期
@property (nonatomic,copy) NSString * titleDate;
//问题描述
@property (nonatomic,copy) NSString * titleDescryption;
//问题id
@property (nonatomic,copy) NSString * titleId;
//问题图片
@property (nonatomic,copy) NSString * titleImages;

@end
