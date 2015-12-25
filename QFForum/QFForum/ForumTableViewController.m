//
//  ForumTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ForumTableViewController.h"

#import "UIView+autoLayout.h"

#import "MyMusicPlayer.h"

#import "PublishTitleViewController.h"

#import "ZGYUIFactory.h"

#import "ZGYForumNetI.h"

#import "TitlesModel.h"

#import "OneTitleModel.h"

#import "TitleTableViewCell.h"

#import "TitleNoImgTableViewCell.h"

#import "ZGYNetHeader.h"

#import "UIImageView+WebCache.h"

#import "UIScrollView+MJRefresh.h"

#import "TitleDetailTableViewController.h"

@interface ForumTableViewController ()
{
    int _once;
    
}
@end

@implementation ForumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置下预估高度
    self.tableView.estimatedRowHeight=2;
    //初始化状态值
    _once=0;
}

-(void)viewWillAppear:(BOOL)animated{
    //只显示一次
    if (_once==0) {
        //显示过度用遮挡界面
        [self initShelterView];
        //显示登陆界面
        [self showLoginView];
        _once=1;
    }else{
        [[MyMusicPlayer player]playWater1];
    }
}

//显示登陆界面
-(void)showLoginView{
    UIStoryboard * mainSB=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //从StoryBoard中找到登陆界面对象
    UIViewController * loginVC=[mainSB instantiateViewControllerWithIdentifier:@"login_vc"];
    //推出登陆界面
    __weak typeof(self) weakSelf = self;
    [self presentViewController:loginVC animated:NO completion:^{
        //移除过度用的遮挡界面。
        [weakSelf dismissShelterView];
    }];
}

//初始化过程中的遮挡界面
-(void)initShelterView{
    //隐藏导航栏和选项栏
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden=YES;
    //显示遮挡界面
    //因为使用自动布局控制位置和大小，所以无需设置frame
    UIImageView * shelterImgV=[[UIImageView alloc]init];
    [self.view addSubview:shelterImgV];
    shelterImgV.image=[UIImage imageNamed:@"welcome_bg1.png"];
    //设置tag方便移除
    shelterImgV.tag=10086;
    //调用自定义UIView类别添加约束
    shelterImgV.top=0;
    shelterImgV.bottom=0;
    shelterImgV.leading=0;
    shelterImgV.widthHeightAspactRatio=1.8;
}

//移除过度用遮挡界面
-(void)dismissShelterView{
    //隐藏导航栏和选项栏
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden=NO;
    //赋值兼容
    UIView * view=[self.view viewWithTag:10086];
    [view removeFromSuperview];
}

#pragma mark - 获取数据接口 -

-(void)getData{
    //判断当前是否正在执行下载操作
    if (_IS_LOADING) {
        NSLog(@"正在加载数据中，不能再执行下载操作");
        return;
    }
    //设置正在下载标记
    _IS_LOADING=YES;
    [ZGYForumNet getTitlesWithPageNum:_currentPage+1 pageCount:10 handle:^(id result, NSError * error) {
        //结束上拉／下拉刷新显示
        if (_IS_UP_OR_DOWN_REFRESH==2) {
            [self.tableView headerEndRefreshing];
            //清空数组
            [_dataArray removeAllObjects];
        }else if (_IS_UP_OR_DOWN_REFRESH==1){
            [self.tableView footerEndRefreshing];
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
                
                //jsonModel解析成对象
                TitlesModel * titlesModel=[[TitlesModel alloc]initWithDictionary:result error:nil];
                if (titlesModel.titles.count==0) {
                    NSLog(@"获取标题为空");
                    return ;
                }
                _currentPage+=1;
                [_dataArray addObjectsFromArray:titlesModel.titles];
                NSLog(@"%@",_dataArray);
                [self.tableView reloadData];
            }else{
                [ZGYUIFactory showAlertMsg:message by:self];
            }
        }else{
            NSLog(@"%@",error);
            [ZGYUIFactory showAlertMsg:@"访问服务器失败！" by:self];
        }
    }];
}


#pragma mark - 按钮触发事件 -


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
    OneTitleModel * oneModel=_dataArray[indexPath.row];
    NSString * descryption=oneModel.titleDescryption;
    CGRect rect=[descryption boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]} context:nil];
    if (oneModel.titleImages.length>0) {
        if (rect.size.height>22) {
            return 140;
        }else{
            return 117;
        }
    }else{
        if (rect.size.height>22) {
            return 112;
        }else{
            return 90;
        }
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取数据
    OneTitleModel * oneModel=_dataArray[indexPath.row];
    //获取第一张图片
    NSString * imgs=oneModel.titleImages;
    if (imgs.length>0) {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCellId" forIndexPath:indexPath];
        
        NSRange range=[imgs rangeOfString:@";"];
        NSString * imgName=[imgs substringToIndex:range.location];
        NSString * urlStr=[NSString stringWithFormat:@"%@LoginWeb/titleImgs/%@",ZGY_DOMAIN_NAME,imgName];
        NSLog(@"%@",urlStr);
        //刷新数据
        cell.titleLab.text=oneModel.titleDescryption;
        cell.auterNameLab.text=STR_COMBIN(@"by:",oneModel.titleAutorName);
        cell.publishDateLab.text=oneModel.titleDate;
        cell.commentNumLab.text=STR_COMBIN(oneModel.commentCount, @"条回复");
        [cell.oneImgV sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        return cell;
    }else{
        TitleNoImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCellNoImgId" forIndexPath:indexPath];
        //刷新数据
        cell.titleLab.text=oneModel.titleDescryption;
        cell.autorNameLab.text=STR_COMBIN(@"by:",oneModel.titleAutorName);
        cell.publishDate.text=oneModel.titleDate;
        cell.commentCountLab.text=STR_COMBIN(oneModel.commentCount, @"条回复");
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld行",indexPath.row);
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
    if ([segue.identifier isEqualToString:@"publishTitle"]) {
        PublishTitleViewController * publishTitleVC=segue.destinationViewController;
        publishTitleVC.IS_PUBLISH_TITLE=YES;
        __weak typeof(self) weakSelf=self;
        publishTitleVC.publishSuccess=^{
            [ZGYUIFactory showAlertMsg:@"发帖完成！" by:weakSelf];
            _currentPage=0;
            [_dataArray removeAllObjects];
            [weakSelf getData];
        };
    }else if ([segue.identifier isEqualToString:@"titleDetailVC"]){
        //选择了哪一个
        NSIndexPath * indexPath=[self.tableView indexPathForSelectedRow];
        NSLog(@"选择了%@",indexPath);
        TitleDetailTableViewController * titleDetailVC=segue.destinationViewController;
        titleDetailVC.oneModel=_dataArray[indexPath.row];
    }
}


@end
