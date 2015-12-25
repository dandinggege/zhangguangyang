//
//  RootTabBarController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //iOS8问题
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"home_selected_tabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"move_selected_tabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"me_selected_tabbar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     //
    self.tabBar.tintColor=[UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
