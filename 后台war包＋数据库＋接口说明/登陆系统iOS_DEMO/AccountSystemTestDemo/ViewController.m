//
//  ViewController.m
//  AccountSystemTestDemo
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ViewController.h"

#import "ZGYFunction.h"

#import "ZGYURLConnect.h"

#import "ZGYBase64Encode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //注册接口
//    [self registerWithUserName:@"旺财" password:@"123"];
    //登陆接口qf1450409598428
    [self loginWithUserName:@"旺财" password:@"456"];
//    //修改密码接口
//    [self changePwWithUserName:@"旺财" password:@"123" newPw:@"456"];
//    //更新用户信息
//    [self updateUserInfoWith:@"qf1450409598428" age:@"12" email:@"xxx@qq.com" address:@"郑州金水区"];
//    //上传头像
//    [self postImgWithUid:@"qf1450409598428" image:[UIImage imageNamed:@"photo"]];
//    //获取用户信息
//    [self userInfoWithId:@"qf1450409598428"];
}


#pragma mark - 注册接口 -

-(void)registerWithUserName:(NSString *)userName password:(NSString *)password{
    NSError * error=nil;
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"registerQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendString:@"http://zgyhandsome.hicp.net/LoginWeb/register?"];
    [URLStr appendFormat:@"username=%@",userName];
    [URLStr appendFormat:@"&password=%@",password];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",str);
    //同步请求数据
    NSString * str2=[NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }else{
        NSLog(@"result:%@",str2);
    }
}


#pragma mark - 登陆接口 -

-(void)loginWithUserName:(NSString *)userName password:(NSString *)password{
    NSError * error=nil;
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"loginQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendString:@"http://zgyhandsome.hicp.net/LoginWeb/login?"];
    [URLStr appendFormat:@"username=%@",userName];
    [URLStr appendFormat:@"&password=%@",password];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",str);
    //同步请求数据
    NSString * str2=[NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }else{
        NSLog(@"result:%@",str2);
    }
}


#pragma mark - 修改密码 -

-(void)changePwWithUserName:(NSString *)userName password:(NSString *)password newPw:(NSString *)newPw{
    NSError * error=nil;
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"changePWQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendString:@"http://zgyhandsome.hicp.net/LoginWeb/changePW?"];
    [URLStr appendFormat:@"username=%@",userName];
    [URLStr appendFormat:@"&password=%@",password];
    [URLStr appendFormat:@"&newPassword=%@",newPw];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",str);
    //同步请求数据
    NSString * str2=[NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }else{
        NSLog(@"result:%@",str2);
    }
}


#pragma mark - 更新用户信息接口 -

-(void)updateUserInfoWith:(NSString *)userId age:(NSString *)age email:(NSString *)email address:(NSString *)address{
    NSError * error=nil;
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"updateUIQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendString:@"http://zgyhandsome.hicp.net/LoginWeb/updateUserInfo?"];
    //uId=%@&sign=%@&timeStamp=%@&uAge=%@&uAddress=%@
    [URLStr appendFormat:@"uId=%@",userId];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    [URLStr appendFormat:@"&uAge=%@",age];
    [URLStr appendFormat:@"&uEmail=%@",email];
    [URLStr appendFormat:@"&uAddress=%@",address];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",str);
    //同步请求数据
    NSString * str2=[NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }else{
        NSLog(@"result:%@",str2);
    }
}


#pragma mark - 上传头像 -

-(void)postImgWithUid:(NSString *)userId image:(UIImage *)image
{
    //创建一个请求:
    NSString *URLStr=@"http://zgyhandsome.hicp.net/LoginWeb/photo";
    NSURL * APOSTURL=[NSURL URLWithString:URLStr];
    //请求头 下
    NSMutableURLRequest *postRequest=[NSMutableURLRequest requestWithURL:APOSTURL];
    //指定请求的方式为POST
    [postRequest setHTTPMethod:@"POST"];
    //设置请求体，把参数连接转换为data类型
    NSData * imageData=UIImageJPEGRepresentation(image, 0.5);
    NSLog(@"img:%@",imageData);
    NSString * imageStr=[ZGYBase64Encode base64StrFromData:imageData];
    //时间戳，加密串
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"photoQF%@",timeStamp]];
    
    //参数字符串
    NSMutableString * premStr=[[NSMutableString alloc]init];
    [premStr appendFormat:@"userid=%@",userId];
    [premStr appendFormat:@"&image=%@",imageStr];
    [premStr appendFormat:@"&sign=%@",md5Str];
    [premStr appendFormat:@"&timeStamp=%@",timeStamp];
    NSLog(@"%@",premStr);
    //设置请求题
    [postRequest setHTTPBody:[premStr dataUsingEncoding:NSUTF8StringEncoding]];
    //格式设置
    [postRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //连接本次请求
    [ZGYURLConnect accessServerWithRequest:postRequest
                                 andHandler:^(NSData * resultData,NSString * resultStr,NSError * error){
                                     NSLog(@"--%@ --%@",resultStr,error);
                                 }];
}


#pragma mark - 获取用户信息 -

-(void)userInfoWithId:(NSString *)userId{
    NSError * error=nil;
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"userInfoQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendString:@"http://zgyhandsome.hicp.net/LoginWeb/userInfo?"];
    [URLStr appendFormat:@"uId=%@",userId];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",str);
    //同步请求数据
    NSString * str2=[NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }else{
        NSLog(@"result:%@",str2);
    }
}

@end
