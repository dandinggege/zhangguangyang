//
//  LoginViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/18.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"

#import "UIView+autoLayout.h"

#import "TextInputCheck.h"

#import "MyMusicPlayer.h"

#import "ZGYUIFactory.h"

#import "MySecurity.h"

#import "ZGYHeader.h"

#import "ZGYAccountNetI.h"

@interface LoginViewController ()
{
    int _once;
}

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
//用户名文本输入框
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
//用户密码文本输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _once=0;
    //输入框标签
    self.userNameTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"用户名:  "];
    self.userNameTF.leftViewMode=UITextFieldViewModeAlways;
    self.passwordTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"密码:  "];
    self.passwordTF.leftViewMode=UITextFieldViewModeAlways;
}

-(void)viewWillAppear:(BOOL)animated{
    //保证只显示一次
    if (_once==0) {
        [self.view sendSubviewToBack:self.bgImgV];
        //自带欢迎界面
        [self createWelcomeView];
        //欢迎界面消失
        [self missWelcomeView];
        _once=1;
    }
    //获取上次登陆用户信息
    [self getLastLoginUserInfo];
}

-(void)missWelcomeView{
    UIView * welcomeView=[self.view viewWithTag:10086];
    //动画消失
    [UIView animateWithDuration:2.0 animations:^{
        welcomeView.alpha=0;
    } completion:^(BOOL finished) {
        [welcomeView removeFromSuperview];
    }];
}

//初始化过程中的遮挡界面
-(void)createWelcomeView{
    //显示欢迎界面
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


#pragma mark - 按钮事件 -

//用户点击了登陆按钮
- (IBAction)loginBtnClicked:(id)sender {
    //音效
    [[MyMusicPlayer player]playWater0];
    //检查输入是否合法
    if ([TextInputCheck accountCheckWithTF:self.userNameTF byVC:self] &&
        [TextInputCheck passwordCheckWithTF:self.passwordTF byVC:self]) {
        [ZGYUIFactory showShelterView:@"登录中..."];
        [ZGYAccountNet loginWithUsername:self.userNameTF.text andPassword:self.passwordTF.text handle:^(id result, NSError * error) {
            [ZGYUIFactory missShelterView];
            if (!error) {
                //状态
                NSString * statusStr=result[@"status"];
                if (statusStr.intValue==1000) {
                    //保存上次登陆用户信息
                    [self saveLastUserInfo];
                    //登陆界面消失
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    NSString * message=result[@"msg"];
                    [ZGYUIFactory showAlertMsg:message by:self];
                }
            }else{
                [ZGYUIFactory showAlertMsg:@"访问服务器失败" by:self];
            }
        }];
    }
}

- (IBAction)registerBtnClicked:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //音效
    [[MyMusicPlayer player]playWater0];
}

#pragma mark - 一些代理方法 -

//为了隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


#pragma mark - 其他处理方法 -

//显示上次登陆用户信息
-(void)getLastLoginUserInfo{
    NSUserDefaults * standardUD=[NSUserDefaults standardUserDefaults];
    NSDictionary * lastUserInfo=[standardUD objectForKey:ZGY_LAST_LOGIN_USER_INFO];
    if (lastUserInfo) {
        NSString * userNameStr=[lastUserInfo objectForKey:ZGY_MD5(@"userName")];
        NSString * passwordStr=[lastUserInfo objectForKey:ZGY_MD5(@"password")];
        self.userNameTF.text=[MySecurity strFromBase64Str:userNameStr];
        self.passwordTF.text=[MySecurity strFromBase64Str:passwordStr];
    }
}

//如果登陆成功，执行保存用户信息操作
-(void)saveLastUserInfo{
    //获取用户名＋密码的加密字符串
    NSString * usernameStr=[MySecurity base64StrFromStr:self.userNameTF.text];
    NSString * passwordStr=[MySecurity base64StrFromStr:self.passwordTF.text];
    //保存用户名 密码加密字符串到NSUserDefault
    NSDictionary * dic=@{ZGY_MD5(@"userName"):usernameStr,ZGY_MD5(@"password"):passwordStr};
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:ZGY_LAST_LOGIN_USER_INFO];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//segue被调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToRegister"]) {
        //segue正向传值
        RegisterViewController * registerVC=segue.destinationViewController;
        //等注册成功后的回调
        __weak typeof(self) weakSelf = self;
        registerVC.registerSuccess=^(NSString * username,NSString *password){
            weakSelf.userNameTF.text=username;
            weakSelf.passwordTF.text=password;
            //显示结果
            [ZGYUIFactory showAlertMsg:@"注册成功！" by:self];
        };
    }
}


@end
