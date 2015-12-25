//
//  PublishTitleViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/22.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "PublishTitleViewController.h"

#import "MyMusicPlayer.h"

#import "ChooseCollectionViewCell.h"

#import "TextInputCheck.h"

#import "ZGYUIFactory.h"

#import "ZGYForumNetI.h"

@interface PublishTitleViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextViewDelegate,
UIPopoverPresentationControllerDelegate>
{
    //存储用户选中图片的数组
    NSMutableArray * _imageArray;
}

//标题描述
@property (weak, nonatomic) IBOutlet UITextView *descryptionTV;
//选择图片
@property (weak, nonatomic) IBOutlet UICollectionView *imageCV;
//内容描述
@property (weak, nonatomic) IBOutlet UILabel *descryptionLab;

@end

@implementation PublishTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化
    _imageArray=[[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[MyMusicPlayer player]playWater0];
    //如果是在回复主题内容
    if (!self.IS_PUBLISH_TITLE) {
        self.title=@"回复主题贴";
        self.view.backgroundColor=[UIColor grayColor];
        self.descryptionLab.text=@"回复内容描述(不要超过500字符)。";
        self.navigationItem.rightBarButtonItem.title=@"发送回复";
    }else{
        self.title=@"发表帖子";
        self.navigationItem.rightBarButtonItem.title=@"发表";
    }
}


#pragma mark - 按钮事件 -

//发布按钮触发
- (IBAction)publishBtnClicked:(id)sender {
    //隐藏键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //播放音效
    [[MyMusicPlayer player]playWater0];
    //回调block
    __weak typeof(self) weakSelf=self;
    NetHandle handle=^(id result, NSError * error) {
        if (!error) {
            NSString * statusStr=result[@"status"];
            NSString * message=result[@"msg"];
            if (statusStr.intValue==1000) {
                NSLog(@"提交成功！");
                //退出界面
                [weakSelf.navigationController popViewControllerAnimated:YES];
                weakSelf.publishSuccess();
            }else{
                [ZGYUIFactory showAlertMsg:message by:self];
            }
        }else{
            [ZGYUIFactory showAlertMsg:@"访问网络失败!" by:self];
        }
    };
    //如果输入合法
    if ([TextInputCheck titleDescryptionCheckWithTF:self.descryptionTV byVC:self]) {
        if (self.IS_PUBLISH_TITLE) {
            //提交主题描述
            [ZGYForumNet submitTitleWithDescryption:self.descryptionTV.text imgs:_imageArray handle:handle];
        }else{
            //提交评论
            [ZGYForumNet submitCommentWithTitleId:self.titleId descryption:self.descryptionTV.text imgs:_imageArray handle:handle];
        }
        
    }
}

//某个图片的删除按钮
- (IBAction)deleteBtnClicked:(UIButton *)sender {
    //隐藏键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //播放音效
    [[MyMusicPlayer player]playWater0];
    //看看点击了哪个按钮
    NSLog(@"%d",sender.tag);
    //删除
    [_imageArray removeObjectAtIndex:sender.tag-1000];
    [self.imageCV reloadData];
}

//添加图片按钮触发了
- (IBAction)addImgBtnClicked:(UIButton *)sender {
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
    alertC.popoverPresentationController.sourceView=sender;
    alertC.popoverPresentationController.sourceRect=sender.bounds;
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}


#pragma mark - 接收到照片的代理方法 -
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

//获取到照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    //添加图片，重新显示数据
    [_imageArray addObject:image];
    [self.imageCV reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

// Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the
// dismissal of the view.
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return YES;
}

// Called on the delegate when the user has taken action to dismiss the popover. This is not called when the popover is dimissed programatically.
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

// -popoverPresentationController:willRepositionPopoverToRect:inView: is called on your delegate when the
// popover may require a different view or rectangle.
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view {
    *rect = self.view.frame;// 显示在中心位置
    * view=self.view;
}


#pragma mark - textView代理 -

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //目前长度
    if (textView.text.length>499) {
        [ZGYUIFactory showAlertMsg:@"长度不能超过500字符！" by:self];
        return NO;
    }
    //如果输入换行，直接退出编辑
    if ([text isEqualToString:@"\n"]) {
        [textView endEditing:YES];
        return NO;
    }
    return YES;
}


#pragma mark - collection代理 -
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //多出一个，最后多一个添加按钮,如果是5个，不许再添加
    if (_imageArray.count==5) {
        return 5;
    }
    return _imageArray.count+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //如果是多出一个，应该显示添加图片的按钮
    if (indexPath.row==_imageArray.count) {
        UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"addImage" forIndexPath:indexPath];
        return cell;
    }
    //不是多出的，应该显示图片
    ChooseCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.imgV.image=_imageArray[indexPath.row];
    cell.deleteBtn.tag=1000+indexPath.row;
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 80);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
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
