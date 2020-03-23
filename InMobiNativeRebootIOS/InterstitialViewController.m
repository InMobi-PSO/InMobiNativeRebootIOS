//
//  InterstitialViewController.m
//  ImmobiSDKDemo
//
//  Created by Westy.zhang on 2020/3/20.
//  Copyright © 2020 Westy.zhang. All rights reserved.
//

#import "InterstitialViewController.h"
#import <InMobiSDK/IMInterstitial.h>
@interface InterstitialViewController ()<IMInterstitialDelegate>
@property (nonatomic,strong) IMInterstitial * interstitial;
@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Interstitial";
    self.interstitial = [[IMInterstitial alloc] initWithPlacementId:1583890456405 delegate:self];
    [self.interstitial load];
    self.view.backgroundColor = [UIColor whiteColor];
}

//app调用getSignals后，给的回调
-(void)interstitial:(IMInterstitial*)interstitial gotSignals:(NSData*)signals{
    NSLog(@"Interstitial gotSignals %@",signals);
}
//app调用getSignals后，回调失败
-(void)interstitial:(IMInterstitial*)interstitial failedToGetSignalsWithError:(IMRequestStatus*)status{
    NSLog(@"Interstitial failedToGetSignalsWithError %@",status);
}
//sdk已经收到了广告，正在加载素材中
-(void)interstitialDidReceiveAd:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial interstitialDidReceiveAd");
}
//广告加载成功，可以显示了
-(void)interstitialDidFinishLoading:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial interstitialDidFinishLoading");
    if (interstitial.isReady) {
        [interstitial showFromViewController:self];
    }
}
//广告加载失败
-(void)interstitial:(IMInterstitial*)interstitial didFailToLoadWithError:(IMRequestStatus *)error{
    NSLog(@"Interstitial didFailToLoadWithError %@",error);
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:1];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [alter addAction:alertAction];
    [self presentViewController:alter animated:YES completion:nil];
}
//interstitial广告将要显示？？？？？
-(void)interstitialWillPresent:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial interstitialWillPresent");
}
//interstitial广告已经显示????
-(void)interstitialDidPresent:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial interstitialDidPresent");
}
//interstitial广告已经显示失败
-(void)interstitial:(IMInterstitial*)interstitial didFailToPresentWithError:(IMRequestStatus*)error{
    NSLog(@"Interstitial didFailToPresentWithError %@",error);
}
//interstitial广告将要消失
-(void)interstitialWillDismiss:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial interstitialWillDismiss");
}
//interstitial广告已经消失
-(void)interstitialDidDismiss:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial interstitialDidDismiss");
}
//用户点击了广告
-(void)interstitial:(IMInterstitial*)interstitial didInteractWithParams:(NSDictionary*)params{
    NSLog(@"Interstitial didInteractWithParams %@",params);
}
//奖励视频已经结束
-(void)interstitial:(IMInterstitial*)interstitial rewardActionCompletedWithRewards:(NSDictionary*)rewards{
    NSLog(@"Interstitial rewardActionCompletedWithRewards %@",rewards);
}
//用户点击了广告，用户将要离开app
-(void)userWillLeaveApplicationFromInterstitial:(IMInterstitial*)interstitial{
    NSLog(@"Interstitial userWillLeaveApplicationFromInterstitial");
}

@end
