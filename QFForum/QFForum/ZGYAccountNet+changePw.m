//
//  ZGYAccountNet+changePw.m
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet+changePw.h"

@implementation ZGYAccountNet (changePw)

//修改密码
+(void)changePwWithUserName:(NSString *)userName
                   password:(NSString *)password
                      newPw:(NSString *)newPw
                     handle:(NetHandle)handle{
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"changePWQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@?",ZGY_DOMAIN_NAME,ZGY_ACCOUNT_CHANGEPW_PRO];
    [URLStr appendFormat:@"username=%@",userName];
    [URLStr appendFormat:@"&password=%@",password];
    [URLStr appendFormat:@"&newPassword=%@",newPw];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",str);
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
