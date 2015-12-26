//
//  ZGYForumNet+submitOneTitle.m
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYForumNet+submitOneTitle.h"

#import <UIKit/UIKit.h>

#import "ZGYUserManager.h"

@implementation ZGYForumNet (submitOneTitle)

+(void)submitTitleWithDescryption:(NSString *)titleDescryption
                             imgs:(NSArray *)imgs
                           handle:(NetHandle)handle{
    //创建一个请求:
    NSString *URLStr=[NSString stringWithFormat:@"%@%@",ZGY_DOMAIN_NAME,ZGY_TITLE_SUBMIT];
    NSURL * APOSTURL=[NSURL URLWithString:URLStr];
    //请求头 下
    NSMutableURLRequest *postRequest=[NSMutableURLRequest requestWithURL:APOSTURL];
    //指定请求的方式为POST
    [postRequest setHTTPMethod:@"POST"];
    //时间戳，加密串
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"publishTitleQF%@",timeStamp]];
    //用户
    NSString * userName=[ZGYUserManager manager].userName;
    NSString * userId=[ZGYUserManager manager].userId;
    NSString * userPhoto=@"";
    if ([ZGYUserManager manager].userInfo) {
        userPhoto=[ZGYUserManager manager].userInfo[@"uPhoto"];
        if (userPhoto.length>0) {
            NSRange range=[userPhoto rangeOfString:@"/" options:NSBackwardsSearch];
            userPhoto=[userPhoto substringFromIndex:range.location+1];
        }
    }
    //参数字符串
    NSMutableString * premStr=[[NSMutableString alloc]init];
    [premStr appendFormat:@"sign=%@",md5Str];
    [premStr appendFormat:@"&timeStamp=%@",timeStamp];
    [premStr appendFormat:@"&auterName=%@",userName];
    [premStr appendFormat:@"&auterUid=%@",userId];
    [premStr appendFormat:@"&auterPhoto=%@",userPhoto];
    [premStr appendFormat:@"&descryption=%@",titleDescryption];
    
    
    //拼接图片的字符串
    for (int i=0;i<imgs.count;i++) {
        UIImage * img = imgs[i];
        NSData * imageData=UIImageJPEGRepresentation(img, 0.1);
        NSLog(@"img:%@",imageData);
        NSString * imageStr=[ZGYBase64Encode base64StrFromData:imageData];
        NSString * keyStr=[NSString stringWithFormat:@"img%d",i];
        [premStr appendFormat:@"&%@=%@",keyStr,imageStr];
    }
    
    NSLog(@"%@",premStr);
    //设置请求题
    [postRequest setHTTPBody:[UTF8Encode(premStr) dataUsingEncoding:NSUTF8StringEncoding]];
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
