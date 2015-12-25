//
//  ZGYURLConnect.h
//  AccountSystemTestDemo
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

/*
 
 －访问URL连接的类
 
 －可以支持post和get形势的 NSURLRequest，服务器返回结果，通过black回调。
 
 －回调还书black有两个参数：
 resultData:服务器的返回数据
 error:访问服务器是否失败
 
 */



#import <Foundation/Foundation.h>

//定义一个回调函数block
typedef void (^ZGYAccessServerHandler)(NSData * resultData,NSString * resultStr,NSError * error);

@interface ZGYURLConnect : NSObject
<NSURLConnectionDataDelegate,
NSURLConnectionDelegate>
{
    //接收服务器数据的MutableData
    NSMutableData * _connectData;
}

/*一个block用来把访问服务器的结果返回给请求的函数*/
@property (nonatomic,copy)ZGYAccessServerHandler handler;

/**
 *	@brief	接口，用来访问服务器，支持post和get格式
 *
 *	@param 	request 	访问接口的Request，get或者post形式
 *	@param 	aHandler 	从服务器获取到数据以后的回调black，格式见上面自定义的black格式。
 *
 *	@return	NSURLConnect对象，可以被接收，进行其他操纵，暂停终止等。
 */
+(NSURLConnection *)accessServerWithRequest:(NSURLRequest *)request
                                 andHandler:(ZGYAccessServerHandler)aHandler;


@end

