//
//  ZGYAccountNet+updateUserInfo.m
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet+updateUserInfo.h"

@implementation ZGYAccountNet (updateUserInfo)

//更新用户信息
+(void)updateUserInfoWithUserId:(NSString *)userId
                            Age:(NSString *)age
                          Email:(NSString *)email
                        address:(NSString *)address
                         handle:(NetHandle)handle{
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"updateUIQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@?",ZGY_DOMAIN_NAME,ZGY_ACCOUNT_UPDATEUSERINFO_PRO];
    [URLStr appendFormat:@"uId=%@",userId];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    if (age)
        [URLStr appendFormat:@"&uAge=%@",age];
    if (email)
        [URLStr appendFormat:@"&uEmail=%@",email];
    if (address)
        [URLStr appendFormat:@"&uAddress=%@",address];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //请求
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:ZGY_NET_OUT_TIME];
    //同步请求数据
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
