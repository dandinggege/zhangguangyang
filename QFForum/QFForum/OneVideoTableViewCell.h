//
//  OneVideoTableViewCell.h
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneVideoTableViewCell : UITableViewCell

//视频标题
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
//视频预览
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;
//播放按钮
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
//预览图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;

@end
