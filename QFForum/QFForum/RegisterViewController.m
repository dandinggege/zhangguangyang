//
//  RegisterViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "RegisterViewController.h"

#import "TextInputCheck.h"

#import "ZGYAccountNetI.h"

#import "MyMusicPlayer.h"

#import "ZGYUIFactory.h"

@interface RegisterViewController ()
<UITextFieldDelegate>

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
//用户名
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
//用户密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
//确认用户密码
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //输入框标签
    self.usernameTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"用户名:  "];
    self.usernameTF.leftViewMode=UITextFieldViewModeAlways;
    self.passwordTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"密码:  "];
    self.passwordTF.leftViewMode=UITextFieldViewModeAlways;
    self.surePasswordTF.leftView=[ZGYUIFactory inputFieldLeftLabelWithTitle:@"确认密码:  "];
    self.surePasswordTF.leftViewMode=UITextFieldViewModeAlways;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view sendSubviewToBack:self.bgImgV];
}


#pragma mark - 按钮触发事件 -

//返回按钮
- (IBAction)backBtnClicked:(id)sender {
    //音效
    [[MyMusicPlayer player]playWater0];
    //收回键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //自我消失
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册按钮
- (IBAction)registerBtnClicked:(id)sender {
    //收回键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //音效
    [[MyMusicPlayer player]playWater0];
    //检查输入合法性
    if ([TextInputCheck accountCheckWithTF:self.usernameTF byVC:self] &&
        [TextInputCheck passwordCheckWithTF:self.passwordTF byVC:self] &&
        [TextInputCheck passwordCheckWithTF:self.surePasswordTF byVC:self  ] &&
        [self.passwordTF.text isEqualToString:self.surePasswordTF.text]) {
        //如果都没有问题，开始注册
        [ZGYAccountNet registerWithUsername:self.usernameTF.text andPassword:self.passwordTF.text handle:^(id result   , NSError * error) {
            if (!error) {
                //状态
                NSString * status=result[@"status"];
                //消息
                NSString * message=result[@"msg"];
                if (status.intValue==1000) {
                    //注册成功
                    [self dismissViewControllerAnimated:YES completion:^{
                        //回调注册成功。
                        self.registerSuccess(self.usernameTF.text,self.passwordTF.text);
                    }];
                }else{
                    //显示结果
                    [ZGYUIFactory showAlertMsg:message by:self];
                }
                
            }else{
                NSLog(@"%@",error);
                [ZGYUIFactory showAlertMsg:@"访问服务器失败！" by:self];
            }
        }];
    }
}


#pragma mark - textField代理方法 -
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.usernameTF) {
        [self.passwordTF becomeFirstResponder];
    }else if (textField==self.passwordTF){
        [self.surePasswordTF becomeFirstResponder];
    }else{
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }
    return YES;
}


#pragma mark - 其他方法 -

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
