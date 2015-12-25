//
//  TitleNoImgTableViewCell.h
//  QFForum
//
//  Created by 张广洋 on 15/12/23.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleNoImgTableViewCell : UITableViewCell

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//作者名字
@property (weak, nonatomic) IBOutlet UILabel *autorNameLab;
//发布日期
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
//评论数量
@property (weak, nonatomic) IBOutlet UILabel *commentCountLab;

@end
