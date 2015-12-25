//
//  HomeViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "HomeViewController.h"

#import "UIView+autoLayout.h"

#import "ZGYUIFactory.h"

#import "ZGYForumNetI.h"

#import "TitlesModel.h"

#import "OneTitleModel.h"

#import "PublishTitleViewController.h"

#import "ATitleTableViewCell.h"

@interface HomeViewController ()
{
    int _once;
    //当前页面
    NSInteger __block _currentPage;
    //数据源
    NSMutableArray * __block _dataArray;
}

@property (weak, nonatomic) IBOutlet UITableView *titleTV;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _once=0;
    _currentPage=0;
    //实例化
    _dataArray=[[NSMutableArray alloc]init];
    //获取数据
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    //只显示一次
    if (_once==0) {
        //显示过度用遮挡界面
        [self initShelterView];
        //显示登陆界面
        [self showLoginView];
        _once=1;
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


#pragma mark - 获取数据 -

-(void)getData{
    __weak typeof(self) weakSelf=self;
    [ZGYForumNet getTitlesWithPageNum:_currentPage+1 pageCount:10 handle:^(id result, NSError * error) {
        if (!error) {
            NSLog(@"%@",result);
            NSString * statusStr=result[@"status"];
            NSString * message=result[@"msg"];
            if (statusStr.intValue==1000) {
                _currentPage+=1;
                //jsonModel解析成对象
                TitlesModel * titlesModel=[[TitlesModel alloc]initWithDictionary:result error:nil];
                [_dataArray addObjectsFromArray:titlesModel.titles];
                NSLog(@"%@",_dataArray);
                [weakSelf.titleTV reloadData];
            }else{
                [ZGYUIFactory showAlertMsg:message by:self];
            }
        }else{
            NSLog(@"%@",error);
            [ZGYUIFactory showAlertMsg:@"访问服务器失败！" by:self];
        }
    }];
}


#pragma mark - tableView代理方法 -

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleId" forIndexPath:indexPath];
    //获取数据
    OneTitleModel * oneModel=_dataArray[indexPath.row];
    //获取第一张图片
    NSString * imgs=oneModel.titleImages;
    cell.titleLab.text=oneModel.titleDescryption;
//    if (imgs.length>0) {
//        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCellId" forIndexPath:indexPath];
//        
//        NSRange range=[imgs rangeOfString:@";"];
//        NSString * imgName=[imgs substringToIndex:range.location];
//        NSString * urlStr=[NSString stringWithFormat:@"%@/LoginWeb/titleImgs/%@",ZGY_DOMAIN_NAME,imgName];
//        NSLog(@"%@",urlStr);
//        //刷新数据
//        cell.titleLab.text=oneModel.titleDescryption;
//        //        cell.auterNameLab.text=oneModel.titleAutorName;
//        //        cell.publishDateLab.text=oneModel.titleDate;
//        //        __weak NSIndexPath *iPath = indexPath;
//        //        __weak typeof(self) weakSelf = self;
//        //        [cell.oneImgV sd_setImageWithURL:[NSURL URLWithString:urlStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //            NSLog(@"weqwe");
//        //            [weakSelf.tableView reloadRowsAtIndexPaths:@[iPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        //        }];
//        return cell;
//    }else{
//        TitleNoImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCellNoImgId" forIndexPath:indexPath];
//        //刷新数据
//        cell.titleLab.text=oneModel.titleDescryption;
//        cell.autorNameLab.text=oneModel.titleAutorName;
//        cell.publishDate.text=oneModel.titleDate;
//        return cell;
//    }
    
    
    return cell;
}


#pragma mark - 其他方法 -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"publishTitle"]) {
        PublishTitleViewController * publishTitleVC=segue.destinationViewController;
        __weak typeof(self) weakSelf=self;
        publishTitleVC.publishSuccess=^{
            [ZGYUIFactory showAlertMsg:@"发帖完成！" by:weakSelf];
            _currentPage=0;
            [_dataArray removeAllObjects];
            [weakSelf getData];
        };
    }
}

@end
