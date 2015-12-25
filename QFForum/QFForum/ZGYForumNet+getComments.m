//
//  ZGYForumNet+getComments.m
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYForumNet+getComments.h"

@implementation ZGYForumNet (getComments)

//获取信息
+(void)getCommentsWithTitleId:(NSString *)titleId
                      pageNum:(NSInteger)pageNum
                    pageCount:(NSInteger)pageCount
                       handle:(NetHandle)handle{
    //获取时间戳
    NSString * timeStamp=[ZGYFunction getTimeStamp];
    NSString * md5Str=[ZGYFunction getMD5StrFromString:[NSString stringWithFormat:@"getCommentsQF%@",timeStamp]];
    //拼接URL
    NSMutableString * URLStr=[[NSMutableString alloc]init];
    [URLStr appendFormat:@"%@%@?",ZGY_DOMAIN_NAME,ZGY_COMMENT_GET_CS];
    [URLStr appendFormat:@"&pageNum=%ld",pageNum];
    [URLStr appendFormat:@"&pageCount=%ld",pageCount];
    [URLStr appendFormat:@"&titleId=%@",titleId];
    [URLStr appendFormat:@"&sign=%@",md5Str];
    [URLStr appendFormat:@"&timeStamp=%@",timeStamp];
    //url转码
    NSString * str=[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"获取评论列表url：%@",str);
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
