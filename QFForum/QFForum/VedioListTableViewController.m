//
//  VedioListTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "VedioListTableViewController.h"

#import "MyMusicPlayer.h"

#import "ZGYVedioNetI.h"

#import "ZGYUIFactory.h"

#import "VideoModel.h"

#import "OneVideoTableViewCell.h"

#import "UIImageView+WebCache.h"

#import <MediaPlayer/MediaPlayer.h>

#import <AVFoundation/AVFoundation.h>

@interface VedioListTableViewController ()

@end

@implementation VedioListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[MyMusicPlayer player]playWater0];
}


#pragma mark - 获取数据 -

-(void)getData{
    //判断当前是否正在执行下载操作
    if (_IS_LOADING) {
        NSLog(@"正在加载数据中，不能再执行下载操作");
        return;
    }
    //设置正在下载标记
    _IS_LOADING=YES;
    [ZGYVedioNet getVediosWithVedioCategory:self.videoCategoryId pageNum:_currentPage+1 pageCount:5 handle:^(id result, NSError * error) {
        //结束上拉／下拉刷新显示
        if (_IS_UP_OR_DOWN_REFRESH==2) {
            [self.tableView headerEndRefreshing];
            //清空数组
            [_dataArray removeAllObjects];
        }else if (_IS_UP_OR_DOWN_REFRESH==1){
            [self.tableView footerEndRefreshing];
        }else if (_IS_UP_OR_DOWN_REFRESH==3){
            [_dataArray removeAllObjects];
        }
        _IS_UP_OR_DOWN_REFRESH=0;
        //结束加载标记
        _IS_LOADING=NO;
        if (!error) {
            NSLog(@"%@",result);
            VideoModel * videoModel=[[VideoModel alloc]initWithDictionary:result error:nil];
            if (videoModel.videos.count==0) {
                NSLog(@"获取视频列表空");
                return ;
            }
            _currentPage++;
            [_dataArray addObjectsFromArray:videoModel.videos];
            [self.tableView reloadData];
            
        }else{
            [ZGYUIFactory showAlertMsg:@"访问服务器失败" by:self];
        }
    }];
}


#pragma mark - 按钮事件 -

- (IBAction)editBtnClicked:(id)sender {
    [[MyMusicPlayer player]playWater0];
    if (self.tableView.editing) {
        self.tableView.editing=NO;
    }else{
        self.tableView.editing=YES;
    }
}

- (IBAction)downloadBtnClicked:(id)sender {
    [[MyMusicPlayer player]playWater0];
    if (self.tableView.editing) {
        [ZGYUIFactory showAlertMsg:@"下载功能还没做" by:self];
    }else{
        [ZGYUIFactory showAlertMsg:@"请先点击“编辑选择”按钮，选中想要下载的视频。" by:self];
    }
}


#pragma mark - 按钮时间 -

- (IBAction)playBtnClicked:(UIButton *)sender {
    [[MyMusicPlayer player]playWater0];
    //获取数据
    OneVideoModel * oneVideoModel=_dataArray[sender.tag-1000];
    NSString * urlStr=[NSString stringWithFormat:@"%@%@/%@",ZGY_DOMAIN_NAME,ZGY_VEDIO_DIC,oneVideoModel.videoName];
    urlStr=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"视频地址：%@",urlStr);
    //播放视频
    MPMoviePlayerViewController * moviePlayerV=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStr]];
    //推出视图
    [self presentMoviePlayerViewControllerAnimated:moviePlayerV];
//    AVPlayerViewController * avPlayerController=[AVPlayerViewController alloc]ini
}


#pragma mark - 其他方法 -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据
    OneVideoModel * oneVideoModel=_dataArray[indexPath.row];
    //tup
    NSString * imgName=oneVideoModel.videoImg;
    return 40+imgName.floatValue*(self.tableView.frame.size.width-20);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCellId" forIndexPath:indexPath];
    //获取数据
    OneVideoModel * oneVideoModel=_dataArray[indexPath.row];
    //更新数据
    cell.videoTitle.text=oneVideoModel.videoName;
    NSString * urlStr=[NSString stringWithFormat:@"%@%@/%@",ZGY_DOMAIN_NAME,ZGY_VEDIO_IMG,oneVideoModel.videoImg];
    NSLog(@"图片:%@",urlStr);
    urlStr=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [cell.videoImg sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    cell.playBtn.tag=1000+indexPath.row;
    cell.imgHeight.constant=oneVideoModel.videoImg.floatValue*(self.tableView.frame.size.width-20);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
