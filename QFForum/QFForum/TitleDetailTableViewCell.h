//
//  TitleDetailTableViewCell.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleDetailTableViewCell : UITableViewCell

//作者头像
@property (weak, nonatomic) IBOutlet UIImageView *autorPhotoImgV;
//作者名称
@property (weak, nonatomic) IBOutlet UILabel *autorNameLab;
//发帖日期
@property (weak, nonatomic) IBOutlet UILabel *titleDateLab;
//帖子主题
@property (weak, nonatomic) IBOutlet UILabel *titleDescryptionLab;

//图片1
@property (weak, nonatomic) IBOutlet UIImageView *tImg0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tImg0H_C;
//图片2
@property (weak, nonatomic) IBOutlet UIImageView *tImg1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tImg1H_C;
//图片3
@property (weak, nonatomic) IBOutlet UIImageView *tImg2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tImg2H_C;
//图片4
@property (weak, nonatomic) IBOutlet UIImageView *tImg3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tImg3H_C;
//图片5
@property (weak, nonatomic) IBOutlet UIImageView *tImg4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tImg4H_C;

@end
