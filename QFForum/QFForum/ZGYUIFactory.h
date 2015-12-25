//
//  ZGYUIFactory.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

//字符合并的宏
#define STR_COMBIN(str1,str2) ([NSString stringWithFormat:@"%@%@",str1,str2])

@interface ZGYUIFactory : NSObject

/**
 *  显示提示框
 *
 *  @param msg 提示信息
 */
+(void)showAlertMsg:(NSString *)msg by:(UIViewController *)byVC;

/**
 *  输入文本框左侧标题
 *
 *  @param title 标题名称
 *
 *  @return 标签
 */
+(UILabel *)inputFieldLeftLabelWithTitle:(NSString *)title;

@end
