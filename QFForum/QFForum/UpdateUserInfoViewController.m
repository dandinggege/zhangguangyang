//
//  UpdateUserInfoViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/20.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "UpdateUserInfoViewController.h"

#import "MyMusicPlayer.h"

#import "ZGYUserManager.h"

#import "UIImageView+WebCache.h"

#import "TextInputCheck.h"

#import "ZGYUIFactory.h"

#import "ZGYAccountNetI.h"

#import "UIView+autoLayout.h"

@interface UpdateUserInfoViewController ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextFieldDelegate>
{
    //是否选择过图片
    BOOL _SELECTED_PHOTO;
}

//头像
@property (weak, nonatomic) IBOutlet UIImageView *photoImgV;
//年龄文本框
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
//email文本框
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
//地址文本框
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@end

@implementation UpdateUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //头像选择状态
    _SELECTED_PHOTO=NO;
    //显示用户信息
    [self showUserInfo];
    //显示当前头像
    self.photoImgV.image=self.oldPhotoImg;
    //背景图片
    [self createBgImgV];
}

-(void)viewWillDisappear:(BOOL)animated{
    //收回键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)createBgImgV{
    UIImageView * bgImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"updateUserInfo_bg.jpg"]];
    [self.view addSubview:bgImgV];
    [self.view sendSubviewToBack:bgImgV];
    bgImgV.top=0;
    bgImgV.leading=0;
    bgImgV.bottom=0;
    bgImgV.widthHeightAspactRatio=2.0;
}


#pragma mark - 按钮触发事件 -

//选择照片
- (IBAction)choosePhotoBtnClicked:(id)sender {
    //隐藏键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //播放音效
    [[MyMusicPlayer player]playWater0];
    //显示选择框
    UIAlertController * alertC=[UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //弹出选择框
    __weak typeof(self) weakSelf = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction * cameraBtn=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf showPictureView:0];
        }];
        [alertC addAction: cameraBtn];
    }
    UIAlertAction * pictureBtn=[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [weakSelf showPictureView:1];
    }];
    [alertC addAction:pictureBtn];
    UIAlertAction * cancelBtn=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:cancelBtn];
    [self presentViewController:alertC animated:YES completion:nil];
}
//提交更改
- (IBAction)submitChangeBtnClicked:(id)sender {
    //隐藏键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //播放音效
    [[MyMusicPlayer player]playWater0];
    //检索输入内容
    if ([TextInputCheck ageCheckWithTF:self.ageTF byVC:self] &&
        [TextInputCheck emailCheckWithTF:self.emailTF byVC:self] &&
        [TextInputCheck addressCheckWithTF:self.addressTF byVC:self]) {
        NSLog(@"可以更新用户信息了");
        //查看用户年龄是否有变
        BOOL IS_AGE_CHANGE=YES;
        NSString * newAgeStr=self.ageTF.text;
        NSNumber * ageNum=[ZGYUserManager manager].userInfo[@"uAge"];
        if([newAgeStr isEqualToString:@""]||
           [newAgeStr isEqualToString:[NSString stringWithFormat:@"%@",ageNum]]){
            NSLog(@"年龄没有更改!");
            IS_AGE_CHANGE=NO;
            newAgeStr=nil;
        }
        //查看email是否有变
        BOOL IS_EMAIL_CHANGE=YES;
        NSString * newEmailStr=self.emailTF.text;
        if ([newEmailStr isEqualToString:@""]||
            [newEmailStr isEqualToString:[ZGYUserManager manager].userInfo[@"uEmail"]]) {
            NSLog(@"email没有变化");
            IS_EMAIL_CHANGE=NO;
            newEmailStr=nil;
        }
        //查看address是否有变
        BOOL IS_ADDRESS_CHANGE=YES;
        NSString * newAddressStr=self.addressTF.text;
        if ([newAddressStr isEqualToString:@""]||
            [newAddressStr isEqualToString:[ZGYUserManager manager].userInfo[@"uAddress"]]) {
            NSLog(@"address没有变化");
            IS_ADDRESS_CHANGE=NO;
            newAddressStr=nil;
        }
        //如果三个都没变滑，并且照片也没有选择，则无需访问服务器
        if (!IS_AGE_CHANGE &&
            !IS_EMAIL_CHANGE &&
            !IS_ADDRESS_CHANGE &&
            !_SELECTED_PHOTO) {
            [ZGYUIFactory showAlertMsg:@"没有作出任何修改，无内容可提交！" by:self];
            return;
        }
        //用户id
        NSString * userId=[ZGYUserManager manager].userId;
        __weak typeof(self) weakSelf=self;
        if (IS_AGE_CHANGE || IS_EMAIL_CHANGE || IS_ADDRESS_CHANGE) {
            //开始上传用户信息
            [ZGYAccountNet updateUserInfoWithUserId:userId Age:newAgeStr Email:newEmailStr address:newAddressStr handle:^(id result, NSError * error) {
                if (!error) {
                    //判断结果
                    NSString * statusStr=result[@"status"];
                    NSString * message=result[@"msg"];
                    if (statusStr.intValue==1000) {
                        //让信息页面获取一次信息
                        self.updateSuccess();
                        //如果用户选择了头像，就上传头像
                        if (_SELECTED_PHOTO) {
                            //上传头像
                            [weakSelf updatePhoto];
                        }else{
                            [ZGYUIFactory showAlertMsg:message by:self];
                        }
                    }else{
                        [ZGYUIFactory showAlertMsg:message by:self];
                    }
                }else{
                    [ZGYUIFactory showAlertMsg:@"访问服务器失败" by:self];
                }
                
            }];
        }else if(_SELECTED_PHOTO){
            [self updatePhoto];
        }
    }
}

//上传头像
-(void)updatePhoto{
    //用户id
    NSString * userId=[ZGYUserManager manager].userId;
    [ZGYAccountNet postImgWithUid:userId image:self.photoImgV.image handle:^(id result, NSError * error) {
        if (!error) {
            //判断结果
            NSString * statusStr=result[@"status"];
            NSString * message=result[@"msg"];
            if (statusStr.intValue==1000) {
                //如果用户选择了头像，就上传头像
                if (_SELECTED_PHOTO) {
                    //上传头像
                    [ZGYUIFactory showAlertMsg:@"更新信息成功！" by:self];
                    self.updateSuccess();
                }else{
                    [ZGYUIFactory showAlertMsg:message by:self];
                }
            }else{
                [ZGYUIFactory showAlertMsg:message by:self];
            }
        }else{
            [ZGYUIFactory showAlertMsg:@"上传头像时候，访问服务器失败！" by:self];
        }
    }];
}


#pragma mark - 辅助方法 -

//显示照片选择
-(void)showPictureView:(int)flag{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if (flag==0)
        sourceType = UIImagePickerControllerSourceTypeCamera;
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    // 展示
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

//显示用户信息
-(void)showUserInfo{
    //头像
    NSString * photoUrlStr=[ZGYUserManager manager].userInfo[@"uPhoto"];
    if (![photoUrlStr isEqualToString:@""]) {
        [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:photoUrlStr] completed:nil];
    }
    //用户年龄
    NSNumber * age=[ZGYUserManager manager].userInfo[@"uAge"];
    if (age.intValue>0)
        self.ageTF.text=[NSString stringWithFormat:@"%@",age];
    else
        //之所以设置@"",
        self.ageTF.text=@"";
    //email
    NSString * emailStr=[ZGYUserManager manager].userInfo[@"uEmail"];
    if (![emailStr isEqualToString:@""])
        self.emailTF.text=emailStr;
    else
        self.emailTF.text=@"";
    //住址
    NSString * addressStr=[ZGYUserManager manager].userInfo[@"uAddress"];
    if (![addressStr isEqualToString:@""])
        self.addressTF.text=addressStr;
    else
        self.addressTF.text=@"";
}


#pragma mark - 代理方法 -

//获取到照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    //标记选择过图片
    _SELECTED_PHOTO=YES;
    //显示头像图片
    self.photoImgV.image=image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.ageTF) {
        [self.emailTF becomeFirstResponder];
    }else if (textField==self.emailTF){
        [self.addressTF becomeFirstResponder];
    }else{
        //收回键盘
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
