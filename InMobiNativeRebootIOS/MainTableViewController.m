//
//  MainTableViewController.m
//  ImmobiSDKDemo
//
//  Created by Westy.zhang on 2020/3/20.
//  Copyright © 2020 Westy.zhang. All rights reserved.
//

#import "MainTableViewController.h"
#import "InfeedTableViewController.h"
#import "SplashViewController.h"
#import "BannerViewController.h"
#import "InterstitialViewController.h"
#import "PrerollViewController.h"
#import "RewardViewController.h"

@interface MainTableViewController ()

@property (nonatomic,strong) NSArray *adTypeItems;
@property (nonatomic,strong) NSArray *adTypeItems_image;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.adTypeItems = @[@"原生广告 数据流 InFeed",@"开屏 Splash",@"前贴 Preroll",@"Banner",@"普通插屏 Interstitial",@"激励视频 Reward"];
    self.adTypeItems_image = @[@"business", @"social", @"utilities", @"sports", @"travel",@"travel"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adTypeItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        InfeedTableViewController * vc = [[InfeedTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        SplashViewController * vc = [[SplashViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        PrerollViewController * vc = [[PrerollViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        BannerViewController * vc = [[BannerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        InterstitialViewController * vc = [[InterstitialViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        RewardViewController * vc = [[RewardViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SimpleTableCell"];
    }
    cell.textLabel.text = [self.adTypeItems objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.adTypeItems_image objectAtIndex:indexPath.row]];
    return cell;
}




@end
