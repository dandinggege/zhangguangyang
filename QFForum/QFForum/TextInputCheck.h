//
//  TextInputCheck.h
//  QFForum
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 *  该类用来检查用户的各种输入是否合法
 */
@interface TextInputCheck : NSObject

/**
 *  检查帐号输入是否合法
 *
 *  @param accountTF 帐号的文本框
 *
 *  @return YES，合法；NO，不合法
 */
+(BOOL)accountCheckWithTF:(UITextField *)accountTF byVC:(UIViewController *)byVC;

/**
 *  检查输入密码是否合法
 *
 *  @param passwordTF 密码的文本框
 *
 *  @return YES，合法；NO，不合法
 */
+(BOOL)passwordCheckWithTF:(UITextField *)passwordTF byVC:(UIViewController *)byVC;

/**
 *  检查年龄输入是否合法,输入空，算是合法！！！
 *
 *  @param ageTF 年龄文本框
 *  @param byVC  弹框依托的VC
 *
 *  @return YES，合法；NO，不合法
 */
+(BOOL)ageCheckWithTF:(UITextField *)ageTF byVC:(UIViewController *)byVC;

/**
 *  检查邮箱输入是否合法,输入空，算是合法！！！
 *
 *  @param emailTF 邮箱文本框
 *  @param byVC    弹框依托VC
 *
 *  @return YES，合法；NO，不合法
 */
+(BOOL)emailCheckWithTF:(UITextField *)emailTF byVC:(UIViewController *)byVC;

/**
 *  家庭住址是否合法，输入空，算是合法！
 *
 *  @param addressTF 家庭住址邮箱
 *  @param byVC      弹框依托VC
 *
 *  @return YES，合法；NO，不合法
 */
+(BOOL)addressCheckWithTF:(UITextField *)addressTF byVC:(UIViewController *)byVC;

/**
 *  检查主题描述是否合法
 *
 *  @param titleTV 主题视图
 *  @param byVC    弹框依托VC
 *
 *  @return YES，合法；NO，不合法
 */
+(BOOL)titleDescryptionCheckWithTF:(UITextView *)titleTV byVC:(UIViewController *)byVC;

@end
