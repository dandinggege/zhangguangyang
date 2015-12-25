//
//  TitleTableViewCell.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleTableViewCell : UITableViewCell
//主题描述
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//发布人名字
@property (weak, nonatomic) IBOutlet UILabel *auterNameLab;
//发布日期
@property (weak, nonatomic) IBOutlet UILabel *publishDateLab;
//一副图片
@property (weak, nonatomic) IBOutlet UIImageView *oneImgV;
//评论数
@property (weak, nonatomic) IBOutlet UILabel *commentNumLab;

@end
