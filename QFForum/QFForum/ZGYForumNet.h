//
//  ZGYForumNet.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZGYNetHeader.h"

#import "ZGYURLConnect.h"

#import "ZGYFunction.h"

#import "ZGYBase64Encode.h"

@interface ZGYForumNet : NSObject

/**
 *  json字符串转换成Dictionary
 *
 *  @param jsonData json数据
 *
 *  @return 解析出的字典
 */
+(NSDictionary *)dicFromJsonData:(NSData *)jsonData;

@end
