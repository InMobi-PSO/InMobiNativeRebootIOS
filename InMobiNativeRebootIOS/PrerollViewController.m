//
//  PrerollViewController.m
//  ImmobiSDKDemo
//
//  Created by Westy.zhang on 2020/3/20.
//  Copyright © 2020 Westy.zhang. All rights reserved.
//

#import "PrerollViewController.h"
#import <InMobiSDK/IMNative.h>
@interface PrerollViewController ()<IMNativeDelegate>
@property (nonatomic,strong) UIView * prerollView;
@property (nonatomic,strong) IMNative * prerollNative;
@end

@implementation PrerollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Preroll";
    self.prerollNative = [[IMNative alloc] initWithPlacementId:1582957771934 delegate:self];
    [self.prerollNative load];
    self.view.backgroundColor = [UIColor whiteColor];
}





//sdk已经获取到了广告，正在下载素材
-(void)nativeAdIsAvailable:(IMNative*)native{
    NSLog(@"Preroll nativeAdIsAvailable");
}
//sdk已经渲染好了广告，app可以展示了
-(void)nativeDidFinishLoading:(IMNative*)native{
    NSLog(@"Preroll nativeDidFinishLoading");
    self.prerollView = [native primaryViewOfWidth:[UIScreen mainScreen].bounds.size.width];
    [[UIApplication sharedApplication].keyWindow addSubview:self.prerollView];
}
//sdk加载广告失败
-(void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"Preroll didFailToLoadWithError %@",error);
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:1];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [alter addAction:alertAction];
    [self presentViewController:alter animated:YES completion:nil];
}

//sdk播放完了视频
-(void)nativeDidFinishPlayingMedia:(IMNative*)native{
    NSLog(@"Preroll nativeDidFinishPlayingMedia");
    [self dismissAd];
}
-(void)dismissAd{
    [self.prerollView removeFromSuperview];
}


//调用getSignals后返回的signal
-(void)native:(IMNative*)native gotSignals:(NSData*)signals{
    NSLog(@"Preroll gotSignals %@",signals);
}
//调用getSignals后返回的signal
-(void)native:(IMNative*)native failedToGetSignalsWithError:(IMRequestStatus*)status{
    NSLog(@"Preroll failedToGetSignalsWithError %@",status);
}
//当用户点击广告后，sdk将要展示一个全屏内容（不是广告将要显示的回调）
-(void)nativeWillPresentScreen:(IMNative*)native{
    NSLog(@"Preroll nativeWillPresentScreen");
}
//当用户点击广告后，sdk已经展示一个全屏内容（不是广告显示的回调）
-(void)nativeDidPresentScreen:(IMNative*)native{
    NSLog(@"Preroll nativeDidPresentScreen");
}
//当用户点击广告后，sdk展示全屏内容后，将要关闭全屏内容（不是广告将要关闭的回调）
-(void)nativeWillDismissScreen:(IMNative*)native{
    NSLog(@"Preroll nativeWillDismissScreen");
}
//当用户点击广告后，sdk展示全屏内容后，已经关闭全屏内容（不是广告关闭的回调）
-(void)nativeDidDismissScreen:(IMNative*)native{
    NSLog(@"Preroll nativeDidDismissScreen");
}
//用户将要从广告中离开app
-(void)userWillLeaveApplicationFromNative:(IMNative*)native{
    NSLog(@"Preroll userWillLeaveApplicationFromNative");
}
//广告已经曝光
-(void)nativeAdImpressed:(IMNative*)native{
    NSLog(@"Preroll nativeAdImpressed");
}
//用户点击了广告
-(void)native:(IMNative*)native didInteractWithParams:(NSDictionary*)params{
    NSLog(@"Preroll didInteractWithParams %@",params);
}
//用户点击了视频的跳过按钮
-(void)userDidSkipPlayingMediaFromNative:(IMNative*)native{
    NSLog(@"Preroll userDidSkipPlayingMediaFromNative");
}
//当媒体声音变化时调用，audioStateMuted为YES代表声音被关掉，NO代表声音被打开
-(void)native:(IMNative*)native adAudioStateChanged:(BOOL)audioStateMuted{
    NSLog(@"Preroll adAudioStateChanged");
}
@end
