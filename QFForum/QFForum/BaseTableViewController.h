//
//  BaseTableViewController.h
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+MJRefresh.h"

@interface BaseTableViewController : UITableViewController
{
    //数据数组
    NSMutableArray * __block _dataArray;
    //当前页
    NSInteger __block _currentPage;
    //正在加载数据的操作
    BOOL _IS_LOADING;
    //是上拉，下拉，还是什么都不是。0，什么都不是；1，上拉；2，下拉
    int _IS_UP_OR_DOWN_REFRESH;
}

//获取数据
-(void)getData;

//设置上拉下拉刷新
-(void)setRefresh;
//下拉刷新
-(void)headerRefreshing;
//上拉刷新
-(void)footerRefreshing;

@end
