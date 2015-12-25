//
//  ZGYUserManager.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGYUserManager : NSObject

+(instancetype)manager;

//用户ID
@property (nonatomic,copy) NSString * userId;

//用户姓名
@property (nonatomic,copy) NSString * userName;

//用户信息
@property (nonatomic,strong) NSDictionary * userInfo;

@end
