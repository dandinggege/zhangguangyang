//
//  ChangePWViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/21.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "ChangePWViewController.h"

#import "TextInputCheck.h"

#import "ZGYAccountNetI.h"

#import "ZGYUIFactory.h"

#import "MyMusicPlayer.h"

#import "MySecurity.h"

#import "ZGYHeader.h"

#import "UIView+autoLayout.h"

@interface ChangePWViewController ()
<UITextFieldDelegate>
{
    CGFloat _oldY;
    CGFloat _oldConstrainC;
}

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *xinPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *sureNewPasswordTF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *surePWTFUpSpaceLC;

@end

@implementation ChangePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加标签
    self.userNameTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"用户名: "];
    self.userNameTF.leftViewMode=UITextFieldViewModeAlways;
    self.oldPasswordTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"原始密码: "];
    self.oldPasswordTF.leftViewMode=UITextFieldViewModeAlways;
    self.xinPasswordTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"新密码: "];
    self.xinPasswordTF.leftViewMode=UITextFieldViewModeAlways;
    self.sureNewPasswordTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"确认密码: "];
    self.sureNewPasswordTF.leftViewMode=UITextFieldViewModeAlways;
    //监听键盘活动
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
    //记住原始位置
    _oldY=self.sureNewPasswordTF.frame.origin.y;
    _oldConstrainC=self.surePWTFUpSpaceLC.constant;
    //背景图片
    [self createBgImgV];
}

-(void)createBgImgV{
    UIImageView * bgImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"changePw_bg.jpg"]];
    [self.view addSubview:bgImgV];
    [self.view sendSubviewToBack:bgImgV];
    bgImgV.top=0;
    bgImgV.leading=0;
    bgImgV.bottom=0;
    bgImgV.widthHeightAspactRatio=2.0;
}


#pragma mark - 按钮触发方法 -
//提交修改
- (IBAction)submitBtnClicked:(id)sender {
    //音效
    [[MyMusicPlayer player]playWater0];
    //收回键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //判断输入是否合法
    if ([TextInputCheck accountCheckWithTF:self.userNameTF byVC:self] &&
        [TextInputCheck passwordCheckWithTF:self.oldPasswordTF byVC:self] &&
        [TextInputCheck passwordCheckWithTF:self.xinPasswordTF byVC:self] &&
        [TextInputCheck passwordCheckWithTF:self.sureNewPasswordTF byVC:self]) {
        //检查输入密码是否一致
        if (![self.xinPasswordTF.text isEqualToString:self.sureNewPasswordTF.text]) {
            [ZGYUIFactory showAlertMsg:@"两次输入密码不一致！" by:self];
            return;
        }
        //检查新旧密码是否一致
        if ([self.xinPasswordTF.text isEqualToString:self.oldPasswordTF.text]) {
            [ZGYUIFactory showAlertMsg:@"跟原密码比，没有区别！" by:self];
            return;
        }
        //
        [ZGYUIFactory showShelterView:@"修改中..."];
        //执行
        [ZGYAccountNet changePwWithUserName:self.userNameTF.text password:self.oldPasswordTF.text newPw:self.xinPasswordTF.text handle:^(id result, NSError * error) {
            [ZGYUIFactory missShelterView];
            if(!error){
                NSString * statusStr=result[@"status"];
                NSString * message=result[@"msg"];
                if (statusStr.intValue==1000) {
                    //推出当前界面
                    [self.navigationController popViewControllerAnimated:YES];
                    //回调修改密码成功
                    self.changePwSuccess();
                }else{
                    [ZGYUIFactory showAlertMsg:message by:self];
                }
            }else{
                [ZGYUIFactory showAlertMsg:@"访问服务器失败!" by:self];
            }
        }];
    }
}


#pragma mark - 代理方法 -

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.userNameTF) {
        [self.oldPasswordTF becomeFirstResponder];
    }else if (textField==self.oldPasswordTF){
        [self.xinPasswordTF becomeFirstResponder];
    }else if (textField==self.xinPasswordTF){
        [self.sureNewPasswordTF becomeFirstResponder];
    }else{
        //收回键盘
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==self.sureNewPasswordTF) {
        [UIView animateWithDuration:0.3 animations:^{
            self.surePWTFUpSpaceLC.constant=_oldConstrainC;
            [self.view layoutIfNeeded];
        }];
    }
    return YES;
}


#pragma mark - 键盘广播方法 -

//键盘尺寸即将发生变化
- (void) keyboardWillChangeFrame:(NSNotification *) notf
{
    if (self.sureNewPasswordTF.isEditing) {
        NSDictionary *info = [notf userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        CGFloat dY=(self.view.frame.size.height-keyboardSize.height)-(_oldY+45);
        NSLog(@"keyBoard:%f", keyboardSize.height);  //216
        NSLog(@"%f",dY);
        if (dY<0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.surePWTFUpSpaceLC.constant=_oldConstrainC-45;
                [self.view layoutIfNeeded];
            }];
        }
    }
}

-(void)keyboardDidHidden{
    NSLog(@"keyboardDidHidden");
    [UIView animateWithDuration:0.3 animations:^{
        self.surePWTFUpSpaceLC.constant=_oldConstrainC;
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - 其他方法 -

//如果登陆成功，执行保存用户信息操作
-(void)saveLastUserInfo{
    //获取用户名＋密码的加密字符串
    NSString * usernameStr=[MySecurity base64StrFromStr:self.userNameTF.text];
    NSString * passwordStr=[MySecurity base64StrFromStr:self.xinPasswordTF.text];
    //保存用户名 密码加密字符串到NSUserDefault
    NSDictionary * dic=@{ZGY_MD5(@"userName"):usernameStr,ZGY_MD5(@"password"):passwordStr};
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:ZGY_LAST_LOGIN_USER_INFO];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //收回键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
