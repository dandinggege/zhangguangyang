//
//  PublishTitleViewController.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PublishTitleSuccess)(void);

@interface PublishTitleViewController : UIViewController

//主题id
@property (nonatomic,copy) NSString * titleId;
//是否是发表主题，YES，发布主题；NO，回复主题
@property (nonatomic) BOOL IS_PUBLISH_TITLE;
//发布成功的回调通知
@property (nonatomic,copy) PublishTitleSuccess publishSuccess;

@end
