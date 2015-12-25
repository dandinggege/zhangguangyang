//
//  RegisterViewController.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

//注册成功之后的回调。
typedef void (^RegiserSuccessBack)(NSString * ,NSString *);

@interface RegisterViewController : UIViewController

@property (nonatomic,copy) RegiserSuccessBack registerSuccess;

@end
