//
//  BaseTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/24.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化
    _dataArray=[[NSMutableArray alloc]init];
    //获取数据
    [self getData];
    //设置上拉下来刷新
    [self setRefresh];
    //状态
    _IS_LOADING=NO;
    _IS_UP_OR_DOWN_REFRESH=0;
}


#pragma mark - 获取数据 -

-(void)getData{
    
}


#pragma mark - 设置上拉下拉刷新 -

-(void)setRefresh{
    //添加下拉刷新功能
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    //设置头部提示
    self.tableView.headerPullToRefreshText=@"继续下拉可以刷新";
    self.tableView.headerReleaseToRefreshText=@"松开即可刷新";
    self.tableView.headerRefreshingText=@"刷新中...";
    
    //上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //设置底部提示
    self.tableView.footerPullToRefreshText=@"继续向上拉可以加载更多";
    self.tableView.footerReleaseToRefreshText=@"松开即可加载更多";
    self.tableView.footerRefreshingText=@"加载中...";
}

//下啦刷新操作
-(void)headerRefreshing{
    //页数清零
    _currentPage=0;
    //标记下拉
    _IS_UP_OR_DOWN_REFRESH=2;
    //加载数据
    [self getData];
}

-(void)footerRefreshing{
    //标记上拉
    _IS_UP_OR_DOWN_REFRESH=1;
    //加载数据
    [self getData];
}


#pragma mark - 其他方法 -

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
