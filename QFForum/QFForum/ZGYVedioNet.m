//
//  ZGYVedioNet.m
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYVedioNet.h"

@implementation ZGYVedioNet

+(NSDictionary *)dicFromJsonData:(NSData *)jsonData{
    //json解析
    NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dic;
}

@end
