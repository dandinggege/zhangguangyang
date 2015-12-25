//
//  TitleDetailTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/23.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "TitleDetailTableViewController.h"

#import "TitleDetailTableViewCell.h"

#import "ZGYNetHeader.h"

#import "UIImageView+WebCache.h"

#import "MyMusicPlayer.h"

#import "PublishTitleViewController.h"

#import "ZGYUIFactory.h"

#import "ZGYForumNetI.h"

#import "CommentsModel.h"

#import "OneCommentModel.h"

@interface TitleDetailTableViewController ()
{
}
@end

@implementation TitleDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    //播放音效
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
    [ZGYForumNet getCommentsWithTitleId:self.oneModel.titleId pageNum:_currentPage+1 pageCount:5 handle:^(id result, NSError * error) {
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
        //分析结果
        if (!error) {
            NSLog(@"%@",result);
            NSString * statusStr=result[@"status"];
            NSString * message=result[@"msg"];
            if (statusStr.intValue==1000) {
                CommentsModel * commentModel=[[CommentsModel alloc]initWithDictionary:result error:nil];
                if (commentModel.comments.count==0) {
                    NSLog(@"获取评论为空");
                    return ;
                }
                [_dataArray addObjectsFromArray:commentModel.comments];
                NSLog(@"%@",_dataArray);
                _currentPage++;
                [self.tableView reloadData];
            }else{
                [ZGYUIFactory showAlertMsg:message by:self];
            }
        }else{
            NSLog(@"访问服务器失败");
            [ZGYUIFactory showAlertMsg:@"访问服务器失败!" by:self];
        }
    }];
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
    return _dataArray.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        float theHeight=0;
        NSArray * imgs=[self.oneModel.titleImages componentsSeparatedByString:@";"];
        for (int i=0;i<imgs.count-1;i++) {
            NSString * oneImgName=imgs[i];
            float oneHeight=oneImgName.floatValue*(self.tableView.frame.size.width-20);
            theHeight +=(oneHeight+5);
        }
        NSString * descryption=self.oneModel.titleDescryption;
        CGRect rect=[descryption boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
        return 60+theHeight+rect.size.height+5;
    }else{
        float theHeight=0;
        OneCommentModel * oneCommentModel=_dataArray[indexPath.row-1];
        NSArray * imgs=[oneCommentModel.commentImages componentsSeparatedByString:@";"];
        for (int i=0;i<imgs.count-1;i++) {
            NSString * oneImgName=imgs[i];
            float oneHeight=oneImgName.floatValue*(self.tableView.frame.size.width-20);
            NSLog(@"某高：%f",oneHeight);
            theHeight +=(oneHeight+5);
        }
        NSString * descryption=oneCommentModel.commentDescryption;
        CGRect rect=[descryption boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
        return 60+theHeight+rect.size.height+5;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //出队列一个cell
    TitleDetailTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"theTitleCellId" forIndexPath:indexPath];
    //获取数据
    NSString * descryptionStr;
    NSString * autorNameStr;
    NSString * writeDateStr;
    NSString * autorphotoStr;
    NSString * imgsStr;
    if (indexPath.row==0) {
        descryptionStr=self.oneModel.titleDescryption;
        autorNameStr=self.oneModel.titleAutorName;
        writeDateStr=self.oneModel.titleDate;
        autorphotoStr=self.oneModel.titleAutorPhoto;
        imgsStr=self.oneModel.titleImages;
    }else{
        OneCommentModel * oneCommentM=_dataArray[indexPath.row-1];
        descryptionStr=oneCommentM.commentDescryption;
        autorNameStr=oneCommentM.commentAutorName;
        writeDateStr=oneCommentM.commentDate;
        autorphotoStr=oneCommentM.commentAutorPhoto;
        imgsStr=oneCommentM.commentImages;
    }
    
    //更新数据
    cell.titleDescryptionLab.text=descryptionStr;
    cell.autorNameLab.text=autorNameStr;
    cell.titleDateLab.text=writeDateStr;
    if (autorphotoStr.length>0) {
        NSString * photoUrlStr=[NSString stringWithFormat:@"%@LoginWeb/photos/%@",ZGY_DOMAIN_NAME,autorphotoStr];
        NSLog(@"%@",photoUrlStr);
        [cell.autorPhotoImgV sd_setImageWithURL:[NSURL URLWithString:photoUrlStr] placeholderImage:[UIImage imageNamed:@"photo_holdplace"]];
    }else{
        cell.autorPhotoImgV.image=[UIImage imageNamed:@"photo_holdplace"];
    }
    //设置所有image隐藏
    cell.tImg0.hidden=YES;
    cell.tImg1.hidden=YES;
    cell.tImg2.hidden=YES;
    cell.tImg3.hidden=YES;
    cell.tImg4.hidden=YES;
    //如果有图片
    if (imgsStr.length>0) {
        NSArray * imgs=[imgsStr componentsSeparatedByString:@";"];
        //我说分割的数组会多处一个你信吗
        for (int i=0;i<imgs.count-1;i++) {
            NSString * oneImgName=imgs[i];
            NSLog(@"%@",oneImgName);
            //设置某个宽高＋图片
            float oneHeight=oneImgName.floatValue*(self.tableView.frame.size.width-20);
            NSString * imgUrlStr=[NSString stringWithFormat:@"%@LoginWeb/titleImgs/%@",ZGY_DOMAIN_NAME,oneImgName];
            NSLog(@"%@",imgUrlStr);
            switch (i) {
                case 0:
                    cell.tImg0.hidden=NO;
                    cell.tImg0H_C.constant=oneHeight;
                    [cell.tImg0 sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil];
                    break;
                case 1:
                    cell.tImg1.hidden=NO;
                    cell.tImg1H_C.constant=oneHeight;
                    [cell.tImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil];
                    break;
                case 2:
                    cell.tImg2.hidden=NO;
                    cell.tImg2H_C.constant=oneHeight;
                    [cell.tImg2 sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil];
                    break;
                case 3:
                    cell.tImg3.hidden=NO;
                    cell.tImg3H_C.constant=oneHeight;
                    [cell.tImg3 sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil];
                    break;
                case 4:
                    cell.tImg4.hidden=NO;
                    cell.tImg4H_C.constant=oneHeight;
                    [cell.tImg4 sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil];
                    break;
                default:
                    break;
            }
        }
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"answerId"]){
        //回复界面
        PublishTitleViewController * answerVC=segue.destinationViewController;
        answerVC.titleId=self.oneModel.titleId;
        __weak typeof(self) weakSelf=self;
        answerVC.publishSuccess=^{
            //提示回复成功
            [ZGYUIFactory showAlertMsg:@"回复成功！" by:weakSelf];
            //重新加载数据
            _currentPage=0;
            _IS_UP_OR_DOWN_REFRESH=3;
            [weakSelf getData];
        };
    }
}


@end
