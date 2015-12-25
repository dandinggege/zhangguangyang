//
//  OneVideoModel.h
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "JSONModel.h"

@protocol OneVideoModel <NSObject>

@end

@interface OneVideoModel : JSONModel

//视频发布者名字
@property (nonatomic,copy) NSString * videoAutorName;
//视频发布者头像
@property (nonatomic,copy) NSString * videoAutorPhoto;
//视频发布者id
@property (nonatomic,copy) NSString * videoAutorUid;
//视频所属分类
@property (nonatomic,copy) NSString * videoCagegory;
//视频发布日期
@property (nonatomic,copy) NSString * videoDate;
//视频id
@property (nonatomic,copy) NSString * videoId;
//视频截图
@property (nonatomic,copy) NSString * videoImg;
//视频名称
@property (nonatomic,copy) NSString * videoName;

@end
