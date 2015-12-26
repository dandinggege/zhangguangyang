//
//  ZGYAccountNet+updatePhoto.m
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYAccountNet+updatePhoto.h"

@implementation ZGYAccountNet (updatePhoto)

+(void)postImgWithUid:(NSString *)userId
                image:(UIImage *)image
               handle:(NetHandle)handle
{
    //创建一个请求:
    NSString *URLStr=[NSString stringWithFormat:@"%@%@",ZGY_DOMAIN_NAME,ZGY_ACCOUNT_PHOTO_PRO];
    NSURL * APOSTURL=[NSURL URLWithString:URLStr];
    //请求头 下
    NSMutableURLRequest *postRequest=[NSMutableURLRequest requestWithURL:APOSTURL];
    //指定请求的方式为POST
    [postRequest setHTTPMethod:@"POST"];
    //设置请求体，把参数连接转换为data类型
    NSData * imageData=UIImageJPEGRepresentation(image, 0.1);
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
    [ZGYURLConnect accessServerWithRequest:postRequest andHandler:^(NSData *resultData, NSString *resultStr, NSError *error) {
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
