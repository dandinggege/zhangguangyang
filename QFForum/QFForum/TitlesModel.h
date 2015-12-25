//
//  TitlesModel.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "JSONModel.h"

#import "OneTitleModel.h"

@interface TitlesModel : JSONModel

//状态
@property (nonatomic,copy) NSString * status;
//提示信息
@property (nonatomic,copy) NSString * msg;
//服务器处理日期
@property (nonatomic,copy) NSDate * date;
//主题
@property (nonatomic,strong) NSArray<OneTitleModel> * titles;

@end
