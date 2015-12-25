//
//  UpdateUserInfoViewController.h
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateSuccess)(void);

@interface UpdateUserInfoViewController : UIViewController

//更新信息完成以后的回调
@property (nonatomic,copy) UpdateSuccess updateSuccess;
//当前头像
@property (nonatomic,copy) id oldPhotoImg;

@end
