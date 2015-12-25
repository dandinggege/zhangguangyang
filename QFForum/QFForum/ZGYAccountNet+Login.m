//
//  ZGYAccountNet+Login.m
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet+Login.h"

#import "ZGYUserManager.h"

#import "ZGYAccountNet+userInfo.h"

@implementation ZGYAccountNet (Login)

+(void)loginWithUsername:(NSString *)userName andPassword:(NSString *)password handle:(NetHandle)handle{
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"loginQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@?",ZGY_DOMAIN_NAME,ZGY_ACCOUNT_LOGIN_PRO];
    [URLStr appendFormat:@"username=%@",userName];
    [URLStr appendFormat:@"&password=%@",password];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"登陆url：%@",str);
    //请求
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:ZGY_NET_OUT_TIME];
    //同步请求数据
    [ZGYURLConnect accessServerWithRequest:request andHandler:^(NSData *resultData, NSString *resultStr, NSError *error) {
        if(!error){
            NSLog(@"访问服务器结果：%@",resultStr);
            //解析
            NSDictionary * dic=[self dicFromJsonData:resultData];
            //单例记忆用户信息
            [ZGYUserManager manager].userId=dic[@"uId"];
            [ZGYUserManager manager].userName=userName;
            //回调结果
            handle(dic,error);
            //获取用户信息
            [self getUserInfo];
        }else{
            //回调结果
            handle(nil,error);
        }
    }];
}

+(void)getUserInfo{
    //id
    NSString * userId=[ZGYUserManager manager].userId;
    //访问接口
    [self getUserInfoWithUserId:userId handle:^(id result, NSError * error) {
        NSLog(@"%@",result);
        //获取后进行保存
        [ZGYUserManager manager].userInfo=result;
    }];
}

@end
