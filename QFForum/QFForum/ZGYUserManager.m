//
//  ZGYUserManager.m
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYUserManager.h"

@implementation ZGYUserManager

-(instancetype)init{
    if (self=[super init]) {
        self.userInfo=nil;
    }
    return self;
}

+(instancetype)manager{
    static ZGYUserManager * manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager==nil) {
            manager=[[ZGYUserManager alloc]init];
        }
    });
    return manager;
}

@end
