//
//  TextInputCheck.m
//  QFForum
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "TextInputCheck.h"

#import "ZGYUIFactory.h"

#import "ZGYFunction.h"

@implementation TextInputCheck

//帐号输入是否合法
+(BOOL)accountCheckWithTF:(UITextField *)accountTF byVC:(UIViewController *)byVC{
    //1，帐号不能为空
    if ((accountTF.text==nil)||[accountTF.text isEqualToString:@""]) {
        [ZGYUIFactory showAlertMsg:@"请填写帐号！" by:byVC];
        return NO;
    }
    //2，帐号长度为2-50个字符
    if ((accountTF.text.length<2)||(accountTF.text.length>50)) {
        [ZGYUIFactory showAlertMsg:@"帐号长度至少两个字符，最多50个字符！" by:byVC];
        return NO;
    }
    return YES;
}

//密码是否合法
+(BOOL)passwordCheckWithTF:(UITextField *)passwordTF byVC:(UIViewController *)byVC{
    //1，帐号不能为空
    if ((passwordTF.text==nil)||[passwordTF.text isEqualToString:@""]) {
        [ZGYUIFactory showAlertMsg:@"请填写密码！" by:byVC];
        return NO;
    }
    //2，密码长度为4-50个字符
    if ((passwordTF.text.length<4)||(passwordTF.text.length>50)) {
        [ZGYUIFactory showAlertMsg:@"帐号长度至少两个字符，最多50个字符！" by:byVC];
        return NO;
    }
    //3，只允许字母数字下划线
    if (![ZGYFunction regularMatchWithRegex:@"^[a-zA-Z0-9_]+$" content:passwordTF.text]) {
        [ZGYUIFactory showAlertMsg:@"密码只允许字母，数字，下划线！" by:byVC];
        return NO;
    }
    return YES;
}

//检查年龄
+(BOOL)ageCheckWithTF:(UITextField *)ageTF byVC:(UIViewController *)byVC{
    if (ageTF.text.length>0) {
        if (![ZGYFunction regularMatchWithRegex:@"^[1-9][0-9]{0,2}$" content:ageTF.text]) {
            [ZGYUIFactory showAlertMsg:@"必须输入三位以内的纯数字!" by:byVC];
            return NO;
        }
    }
    return YES;
}

//检查邮箱
+(BOOL)emailCheckWithTF:(UITextField *)emailTF byVC:(UIViewController *)byVC{
    //如果用户输入内容，才检测，否则直接算真。
    if (emailTF.text.length>0) {
        //用正则匹配邮箱地址
        if (![ZGYFunction regularMatchWithRegex:@"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$" content:emailTF.text]) {
            [ZGYUIFactory showAlertMsg:@"请输入合法邮箱!" by:byVC];
            return NO;
        }
    }
    return YES;
}

//检查地址
+(BOOL)addressCheckWithTF:(UITextField *)addressTF byVC:(UIViewController *)byVC{
    if (addressTF.text.length>200) {
        [ZGYUIFactory showAlertMsg:@"不能多于200字符!" by:byVC];
        return NO;
    }
    return YES;
}

//检查主题
+(BOOL)titleDescryptionCheckWithTF:(UITextView *)titleTV byVC:(UIViewController *)byVC{
    if (titleTV.text.length>500) {
        [ZGYUIFactory showAlertMsg:@"不能多于500字符!" by:byVC];
        return NO;
    }
    if (titleTV.text.length<15) {
        [ZGYUIFactory showAlertMsg:@"描述不能少于15个字!" by:byVC];
        return NO;
    }
    return YES;
}

@end
