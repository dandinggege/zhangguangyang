//
//  MeTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "MeTableViewController.h"

#import "ZGYAccountNetI.h"

#import "ZGYUserManager.h"

#import "ZGYUIFactory.h"

#import "UIImageView+WebCache.h"

#import "MyMusicPlayer.h"

#import "UpdateUserInfoViewController.h"

#import "ChangePWViewController.h"

@interface MeTableViewController ()

//头像
@property (weak, nonatomic) IBOutlet UIImageView *photo;

//用户名显示
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
//用户年龄
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
//用户邮箱
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
//用户住址
@property (weak, nonatomic) IBOutlet UILabel *addressLab;


@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置表格分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //获取用户信息
    [self getUserInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    //播放音效
    [[MyMusicPlayer player]playWater1];
}


#pragma mark - 其他方法 -

-(void)getUserInfo{
    //id
    NSString * userId=[ZGYUserManager manager].userId;
    //判断是否已经获取用户信息
    if(![ZGYUserManager manager].userInfo){
        __weak typeof(self) weakSelf=self;
        //访问接口
        [ZGYAccountNet getUserInfoWithUserId:userId handle:^(id result, NSError * error) {
            NSLog(@"%@",result);
            /*
             date = "2015-12-20 06:20:07";
             msg = "\U67e5\U8be2\U6210\U529f";
             status = 1000;
             uAddress = "";
             uAge = 0;
             uEmail = "";
             uPhoto = "";
             */
            //获取后进行保存
            [ZGYUserManager manager].userInfo=result;
            [weakSelf showUserInfo];
        }];
    }else{
        [self showUserInfo];
    }
}

//显示用户信息
-(void)showUserInfo{
    //头像
    NSString * photoUrlStr=[ZGYUserManager manager].userInfo[@"uPhoto"];
    if (![photoUrlStr isEqualToString:@""]) {
        NSString * needPhotoStr=[photoUrlStr stringByReplacingOccurrencesOfString:@"http://zgyhandsome.hicp.net/" withString:ZGY_DOMAIN_NAME];
        [self.photo sd_setImageWithURL:[NSURL URLWithString:needPhotoStr] completed:nil];
    }
    //用户名
    self.userNameLab.text=[ZGYUserManager manager].userName;
    //用户年龄
    NSNumber * age=[ZGYUserManager manager].userInfo[@"uAge"];
    self.ageLab.text=[NSString stringWithFormat:@"%@岁",age];
    //email
    NSString * emailStr=[ZGYUserManager manager].userInfo[@"uEmail"];
    if (![emailStr isEqualToString:@""]) {
        self.emailLab.text=emailStr;
    }else{
        self.emailLab.text=@"(暂未提供)";
    }
    //住址
    NSString * addressStr=[ZGYUserManager manager].userInfo[@"uAddress"];
    if (![addressStr isEqualToString:@""]) {
        self.addressLab.text=addressStr;
    }else{
        self.addressLab.text=@"(暂未提供)";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //音效
    [[MyMusicPlayer player]playWater0];
    if ([segue.identifier isEqualToString:@"updateUserInfo"]) {
        //用户信息
        UpdateUserInfoViewController * updateUserInfoVC=segue.destinationViewController;
        __weak typeof(self) weakSelf=self;
        updateUserInfoVC.updateSuccess=^{
            [ZGYUserManager manager].userInfo=nil;
            [weakSelf getUserInfo];
        };
        updateUserInfoVC.oldPhotoImg=self.photo.image;
    }else if ([segue.identifier isEqualToString:@"changePassword"]){
        //用户信息
        ChangePWViewController * changePwVC=segue.destinationViewController;
        __weak typeof(self) weakSelf=self;
        changePwVC.changePwSuccess=^{
            [ZGYUIFactory showAlertMsg:@"修改密码成功！" by:weakSelf];
        };
    }
}

@end
