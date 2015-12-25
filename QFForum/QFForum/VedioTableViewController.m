//
//  VedioTableViewController.m
//  QFForum
//
//  Created by 张广洋 on 15/12/25.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "VedioTableViewController.h"

#import "ZGYVedioNetI.h"

#import "ZGYUIFactory.h"

#import "MyMusicPlayer.h"

#import "VedioListTableViewController.h"

@interface VedioTableViewController ()
{
    NSMutableArray * _dataArray;
}
@end

@implementation VedioTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[[NSMutableArray alloc]init];
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [[MyMusicPlayer player]playWater1];
}


#pragma mark - 获取数据 -

-(void)getData{
    __weak typeof(self) weakSelf=self;
    [ZGYVedioNet getVedioCategory:^(id result, NSError * error) {
        if (!error) {
            NSLog(@"%@",result);
            [_dataArray addObjectsFromArray:result[@"categorys"]];
            [weakSelf.tableView reloadData];
        }else{
            [ZGYUIFactory showAlertMsg:@"访问服务器失败!" by:self];
        }
    }];
}


#pragma mark - 其他方法 -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vedioCategoryCellId" forIndexPath:indexPath];
    //更新数据
    NSDictionary * oneCategory=_dataArray[indexPath.row];
    cell.textLabel.text=oneCategory[@"categoryName"];
    cell.textLabel.textColor=[UIColor blueColor];
    cell.textLabel.font=[UIFont systemFontOfSize:20];
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
    if ([segue.identifier isEqualToString:@"vedioListTV"]) {
        VedioListTableViewController * vedioListTV=segue.destinationViewController;
        NSIndexPath * indexPath=[self.tableView indexPathForSelectedRow];
        NSDictionary * videoCategoryDic=[_dataArray objectAtIndex:indexPath.row];
        vedioListTV.title=videoCategoryDic[@"categoryName"];
        vedioListTV.videoCategoryId=videoCategoryDic[@"categoryId"];
    }
}


@end
