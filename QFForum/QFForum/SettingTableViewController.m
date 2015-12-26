//
//  SettingTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/26.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "SettingTableViewController.h"

#import "MyMusicPlayer.h"

@interface SettingTableViewController ()
//音效开关
@property (weak, nonatomic) IBOutlet UISwitch *needPlaySwitch;

@end

@implementation SettingTableViewController

-(void)viewWillAppear:(BOOL)animated{
    //播放音效
    [[MyMusicPlayer player]playWater1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化自己状态
    self.needPlaySwitch.on=[[NSUserDefaults standardUserDefaults]boolForKey:@"soundEffectOpen"];
}


#pragma mark - 各种事件处理 -

- (IBAction)switchBtnClicked:(UISwitch *)sender {
    [[MyMusicPlayer player]playWater0];
    //设置标记
    [[NSUserDefaults standardUserDefaults]setBool:sender.on forKey:@"soundEffectOpen"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //发送广播给音乐中心，停止播放音乐
    [[NSNotificationCenter defaultCenter]postNotificationName:@"soundEffectSetChanged" object:nil];
}



#pragma mark - 其他方法 -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
