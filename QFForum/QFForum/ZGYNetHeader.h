//
//  ZGYAccountHeader.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#ifndef ZGYAccountHeader_h
#define ZGYAccountHeader_h

//网络回调block
typedef void (^NetHandle)(id ,NSError *);
//utf8转码
#define UTF8Encode(str) ([str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]])

//域名的宏
//#define ZGY_DOMAIN_NAME (@"http://192.168.5.102:8080/")
#define ZGY_DOMAIN_NAME (@"http://zgyhandsome.hicp.net/")
//超时时间,如果用户请求数据，超过30秒，即可算作超时
#define ZGY_NET_OUT_TIME 30.0


//＊＊＊＊＊＊＊＊账户：
//注册的后台接口
#define ZGY_ACCOUNT_REGISTER_PRO (@"LoginWeb/register")
//登陆的后台接口
#define ZGY_ACCOUNT_LOGIN_PRO (@"LoginWeb/login")
//修改密码的后台接口
#define ZGY_ACCOUNT_CHANGEPW_PRO (@"LoginWeb/changePW")
//更新用户信息的后台接口
#define ZGY_ACCOUNT_UPDATEUSERINFO_PRO (@"LoginWeb/updateUserInfo")
//上传用户头像的后台接口
#define ZGY_ACCOUNT_PHOTO_PRO (@"LoginWeb/photo")
//获取用户信息的后台接口
#define ZGY_ACCOUNT_USERINFO_PRO (@"LoginWeb/userInfo")


//＊＊＊＊＊＊＊＊论坛
//上传主题
#define ZGY_TITLE_SUBMIT (@"LoginWeb/submitOneTitle")
//上传主题描述
#define ZGY_TITLE_DESCRYPTION (@"LoginWeb/submitTitle")
//主题图片接口
#define ZGY_TITLE_IMGS (@"LoginWeb/titleImg")
//获取主题接口
#define ZGY_TITLE_GET_TS (@"LoginWeb/getTitles")
//提交评论
#define ZGY_COMMENT_SUBMIT (@"LoginWeb/submitComment")
//获取评论
#define ZGY_COMMENT_GET_CS (@"LoginWeb/getComments")


//＊＊＊＊＊＊＊＊视频
//获取视频分类
#define ZGY_VEDIO_URL (@"LoginWeb/versions/categorys.txt")
//获取某个分类视频列表
#define ZGY_VEDIO_LIST (@"LoginWeb/getVideo")
//视频预览图片
#define ZGY_VEDIO_IMG (@"LoginWeb/videoImgs")
//视频下载地址
#define ZGY_VEDIO_DIC (@"LoginWeb/videos")

#endif /* ZGYAccountHeader_h */
