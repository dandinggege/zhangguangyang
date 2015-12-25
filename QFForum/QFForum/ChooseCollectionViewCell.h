//
//  ChooseCollectionViewCell.h
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCollectionViewCell : UICollectionViewCell

//图片
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
//删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
