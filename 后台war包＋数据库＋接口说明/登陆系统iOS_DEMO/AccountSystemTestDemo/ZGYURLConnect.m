//
//  ZGYURLConnect.m
//  AccountSystemTestDemo
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYURLConnect.h"

@implementation ZGYURLConnect

-(void)dealloc
{
    if (_connectData)
    {
        [_connectData autorelease];
    }
    [super dealloc];
}

-(id)init
{
    self=[super init];
    if (self)
    {
        _connectData=nil;
    }
    return self;
}

#pragma mark - 对外接口,通过一个NSURLRequest访问服务器，并通过一个block把结果返回给请求方法 -
+(NSURLConnection *)accessServerWithRequest:(NSURLRequest *)request
                                 andHandler:(ZGYAccessServerHandler)aHandler
{
    //创建一个对象，等待服务器返回返回值。
    ZGYURLConnect * connectObject=[[ZGYURLConnect alloc]init];
    connectObject.handler=aHandler;
    NSURLConnection * connection =[NSURLConnection connectionWithRequest:request
                                                                delegate:connectObject];
    [connection start];
    return connection;
}

#pragma mark - 监听NSURLConnect访问结果 -
//接收到请求头
-(void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    _connectData=[[NSMutableData alloc]initWithCapacity:10];
}
//接收到数据中
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_connectData appendData:data];
}
//接收数据完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString * resultStr=[[[NSString alloc]initWithData:_connectData
                                               encoding:NSUTF8StringEncoding]autorelease];
    if (self.handler)
    {
        self.handler(_connectData,resultStr,nil);
        [self.handler release];
    }
    [self release];
}
//接收数据失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.handler)
    {
        self.handler(nil,nil,error);
        [self.handler release];
    }
    [self release];
}

@end
