//
//  BannerViewController.m
//  ImmobiSDKDemo
//
//  Created by Westy.zhang on 2020/3/20.
//  Copyright © 2020 Westy.zhang. All rights reserved.
//

#import "BannerViewController.h"
#import <InMobiSDK/IMBanner.h>
@interface BannerViewController ()<IMBannerDelegate>
@property (nonatomic,strong) IMBanner * banner;
@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Banner";
    self.view.backgroundColor = [UIColor whiteColor];
    self.banner = [[IMBanner alloc] initWithFrame:CGRectMake(0, 400, 320, 50) placementId:1584339357654 delegate:self];
    [self.banner load];
    [self.view addSubview:self.banner];
}


//广告加载成功
-(void)bannerDidFinishLoading:(IMBanner*)banner{
    NSLog(@"Banner bannerDidFinishLoading");
}
//广告加载失败
-(void)banner:(IMBanner*)banner didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"Banner didFailToLoadWithError %@",error);
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:1];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [alter addAction:alertAction];
    [self presentViewController:alter animated:YES completion:nil];
}
//当用户调用getSignals方法后，给用户的回调
-(void)banner:(IMBanner*)banner gotSignals:(NSData*)signals{
    NSLog(@"Banner gotSignals %@",signals);
}
//当用户调用getSignals方法后，没有找到合适的signal
-(void)banner:(IMBanner*)banner failedToGetSignalsWithError:(IMRequestStatus*)status{
    NSLog(@"Banner failedToGetSignalsWithError %@",status);
}
//用户点击了广告
-(void)banner:(IMBanner*)banner didInteractWithParams:(NSDictionary*)params{
    NSLog(@"Banner didInteractWithParams %@",params);
}
//用户点击了广告，将要离开app
-(void)userWillLeaveApplicationFromBanner:(IMBanner*)banner{
    NSLog(@"Banner userWillLeaveApplicationFromBanner");
}
//banner将要展示一个全屏的内容
-(void)bannerWillPresentScreen:(IMBanner*)banner{
    NSLog(@"Banner bannerWillPresentScreen");
}
//banner已经展示了一个全屏的内容
-(void)bannerDidPresentScreen:(IMBanner*)banner{
    NSLog(@"Banner bannerDidPresentScreen");
}
//banner将要移除全屏的内容
-(void)bannerWillDismissScreen:(IMBanner*)banner{
    NSLog(@"Banner bannerWillDismissScreen");
}
//banner已经移除全屏的内容
-(void)bannerDidDismissScreen:(IMBanner*)banner{
    NSLog(@"Banner bannerDidDismissScreen");
}
//banner奖励视频，用户已经完成
-(void)banner:(IMBanner*)banner rewardActionCompletedWithRewards:(NSDictionary*)rewards{
    NSLog(@"Banner rewardActionCompletedWithRewards %@",rewards);
}

@end

