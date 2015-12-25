//
//  ChangePWViewController.h
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangePWSuccess)(void);

@interface ChangePWViewController : UIViewController

//修改密码成功以后的回调
@property (nonatomic,copy) ChangePWSuccess changePwSuccess;

@end
