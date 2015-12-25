//
//  VideoModel.h
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "JSONModel.h"

#import "OneVideoModel.h"

@interface VideoModel : JSONModel

//服务器处理日期
@property (nonatomic,copy) NSString * date;
//消息
@property (nonatomic,copy) NSString * msg;
//状态
@property (nonatomic,copy) NSString * status;
//视频列表
@property (nonatomic,strong) NSArray<OneVideoModel> * videos;

@end
