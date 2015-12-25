//
//  TitleDetailTableViewController.h
//  QFForum
//
//  Created by 张广洋 on 15/12/23.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseTableViewController.h"

#import "OneTitleModel.h"

@interface TitleDetailTableViewController : BaseTableViewController

//一个主题模型
@property (nonatomic,strong) OneTitleModel * oneModel;

@end
