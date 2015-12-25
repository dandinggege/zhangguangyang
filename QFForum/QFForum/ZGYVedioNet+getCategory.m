//
//  ZGYVedioNet+getCategory.m
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYVedioNet+getCategory.h"

@implementation ZGYVedioNet (getCategory)

+(void)getVedioCategory:(NetHandle)handle{
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@",ZGY_DOMAIN_NAME,ZGY_VEDIO_URL];
    //请求
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]];
    //链接
    [ZGYURLConnect accessServerWithRequest:request andHandler:^(NSData *resultData, NSString *resultStr, NSError *error) {
        if (!error) {
            NSLog(@"访问服务器结果：%@",resultStr);
            //简单解析
            NSDictionary * dic=[self dicFromJsonData:resultData];
            handle(dic,error);
        }else{
            handle(nil,error);
        }
    }];
}

@end
