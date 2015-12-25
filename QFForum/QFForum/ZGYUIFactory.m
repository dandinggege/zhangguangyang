//
//  ZGYUIFactory.m
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ZGYUIFactory.h"

#import "MyMusicPlayer.h"

@implementation ZGYUIFactory

//显示提示框
+(void)showAlertMsg:(NSString *)msg by:(UIViewController *)byVC{
    //弹框控制器
    UIAlertController * alertC=[UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    //确定按钮
    UIAlertAction * sureBtn=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //音效
//        [[MyMusicPlayer player]playWater0];
    }];
    [alertC addAction:sureBtn];
    //显示弹框
    [byVC presentViewController:alertC animated:YES completion:nil];
}

//左侧标签
+(UILabel *)inputFieldLeftLabelWithTitle:(NSString *)title{
    //创建一个label
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    //背景色透明
    label.backgroundColor=[UIColor clearColor];
    //蓝色字体
    label.textColor=[UIColor blueColor];
    //字体大小
    label.font=[UIFont systemFontOfSize:15];
    //右对齐
    label.textAlignment=NSTextAlignmentRight;
    //标题
    label.text=title;
    //右边线
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(78, 4, 2, 32)];
    view.backgroundColor=[UIColor grayColor];
    view.alpha=0.3;
    [label addSubview:view];
    return label;
}

@end
