//
//  InfeedTableViewController.m
//  ImmobiSDKDemo
//
//  Created by Westy.zhang on 2020/3/20.
//  Copyright © 2020 Westy.zhang. All rights reserved.
//

#import "InfeedTableViewController.h"
#import <InMobiSDK/IMNative.h>
#import "InfeedData.h"
#import "InFeedTableCell.h"
@interface InfeedTableViewController ()<IMNativeDelegate>
@property (nonatomic,strong) IMNative * feedNative;
@property (nonatomic,strong) NSMutableArray * dataMutableArray;
@end
CGFloat primaryImageViewWidth = 0;
CGRect primaryImageViewFrame;

@implementation InfeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Infeed";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.feedNative = [[IMNative alloc] initWithPlacementId:1584152330991 delegate:self];
    [self.feedNative load];
    self.dataMutableArray = [NSMutableArray array];
    [self loadInitialData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.estimatedRowHeight = 500;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
//sdk已经渲染好了广告，app可以展示了
-(void)nativeDidFinishLoading:(IMNative*)native{
    NSLog(@"Infeed nativeDidFinishLoading");
    self.title = @"获取到了广告";
    int x = arc4random() % self.dataMutableArray.count;
    [self.dataMutableArray insertObject:native atIndex:x];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMutableArray.count;
}

- (BOOL)isNativeAdAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.dataMutableArray objectAtIndex:indexPath.row] isKindOfClass:[IMNative class]];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id data = [self.dataMutableArray objectAtIndex:indexPath.row];
    if ([data isKindOfClass:[IMNative class]]) {
        [(IMNative*)data recyclePrimaryView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InFeedTableCell *tableCell = (InFeedTableCell *)cell;
    [tableCell layoutIfNeeded];
    primaryImageViewWidth =  tableCell.primaryImageView.frame.size.width;
    primaryImageViewFrame = tableCell.primaryImageView.frame;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;

    InFeedTableCell *cell = (InFeedTableCell *)[tableView dequeueReusableCellWithIdentifier:@"InFeedTableCell"];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InFeedTableCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    [cell layoutIfNeeded];
    
    id slide = [self.dataMutableArray objectAtIndex:indexPath.row];
    
    if ([self isNativeAdAtIndexPath:indexPath]) {
        
        IMNative *currentNativeAd = slide;
        cell.iconImageView.image = currentNativeAd.adIcon;
        cell.titleLabel.text = [currentNativeAd adTitle];
        cell.subTitleLabel.text = @"Sponsored";
        cell.descriptionLabel.text = currentNativeAd.adDescription;
        cell.ctaLabel.text = currentNativeAd.adCtaText;
        cell.primaryImageView.image = [UIImage imageNamed:@"placeholder.png"];

        UIView* adContainerView = [[UIView alloc] initWithFrame:primaryImageViewFrame];
        UIView* AdPrimaryViewOfCorrectWidth = [currentNativeAd primaryViewOfWidth:primaryImageViewWidth];
        [AdPrimaryViewOfCorrectWidth setBackgroundColor:[UIColor whiteColor]];
        [adContainerView addSubview:AdPrimaryViewOfCorrectWidth];
        [cell addSubview:adContainerView];
        return cell;
    }
    else {
        InfeedData *appContentSlide = slide;
        cell.titleLabel.text = appContentSlide.titleText;
        cell.subTitleLabel.text = appContentSlide.subtitleText;
        cell.descriptionLabel.text = appContentSlide.descriptionText;
        cell.ctaLabel.text = appContentSlide.ctaText;
        cell.iconImageView.image = [UIImage imageNamed:appContentSlide.iconImageName];
        cell.primaryImageView.image = [UIImage imageNamed:appContentSlide.primaryImageName];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printClickLog)];
        cell.iconImageView.userInteractionEnabled = YES;
        [cell.iconImageView addGestureRecognizer:singleTap];
        return cell;
    }
}

-(void)printClickLog{
    NSLog(@"Content Clicked");
}

//sdk已经获取到了广告，正在下载素材
-(void)nativeAdIsAvailable:(IMNative*)native{
    NSLog(@"Infeed nativeAdIsAvailable");
}
//sdk加载广告失败
-(void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"Infeed didFailToLoadWithError %@",error);
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:1];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:nil];
    [alter addAction:alertAction];
    [self presentViewController:alter animated:YES completion:nil];
}
//调用getSignals后返回的signal
-(void)native:(IMNative*)native gotSignals:(NSData*)signals{
    NSLog(@"Infeed gotSignals %@",signals);
}
//调用getSignals后返回的signal
-(void)native:(IMNative*)native failedToGetSignalsWithError:(IMRequestStatus*)status{
    NSLog(@"Infeed failedToGetSignalsWithError %@",status);
}
//当用户点击广告后，sdk将要展示一个全屏内容（不是广告将要显示的回调）
-(void)nativeWillPresentScreen:(IMNative*)native{
    NSLog(@"Infeed nativeWillPresentScreen");
}
//当用户点击广告后，sdk已经展示一个全屏内容（不是广告显示的回调）
-(void)nativeDidPresentScreen:(IMNative*)native{
    NSLog(@"Infeed nativeDidPresentScreen");
}
//当用户点击广告后，sdk展示全屏内容后，将要关闭全屏内容（不是广告将要关闭的回调）
-(void)nativeWillDismissScreen:(IMNative*)native{
    NSLog(@"Infeed nativeWillDismissScreen");
}
//当用户点击广告后，sdk展示全屏内容后，已经关闭全屏内容（不是广告关闭的回调）
-(void)nativeDidDismissScreen:(IMNative*)native{
    NSLog(@"Infeed nativeDidDismissScreen");
}
//用户将要从广告中离开app
-(void)userWillLeaveApplicationFromNative:(IMNative*)native{
    NSLog(@"Infeed userWillLeaveApplicationFromNative");
}
//广告已经曝光
-(void)nativeAdImpressed:(IMNative*)native{
    NSLog(@"Infeed nativeAdImpressed");
}
//用户点击了广告
-(void)native:(IMNative*)native didInteractWithParams:(NSDictionary*)params{
    NSLog(@"Infeed didInteractWithParams %@",params);
}
//sdk播放完了视频
-(void)nativeDidFinishPlayingMedia:(IMNative*)native{
    NSLog(@"Infeed nativeDidFinishPlayingMedia");
}
//用户点击了视频的跳过按钮
-(void)userDidSkipPlayingMediaFromNative:(IMNative*)native{
    NSLog(@"Infeed userDidSkipPlayingMediaFromNative");
}
//当媒体声音变化时调用，audioStateMuted为YES代表声音被关掉，NO代表声音被打开
-(void)native:(IMNative*)native adAudioStateChanged:(BOOL)audioStateMuted{
    NSLog(@"Infeed adAudioStateChanged");
}

- (void)loadInitialData {
    
    InfeedData *item1 = [[InfeedData alloc] init];
    item1.titleText = @"Neha Jha(测试数据)";
    item1.subtitleText = @"Product Manager";
    item1.descriptionText = @"Looking out for a Sponsorship Manager with 5+ yrs exp for a sports tourism company in Bangalore with strong grasp of media planning principles & excellent understanding of target segment, market intelligence and media medium technicalities. For more infos contact me at neha@zyoin.com";
    item1.iconImageName = @"neha_jha.jpg";
    item1.primaryImageName = @"neha_jha_big.png";
    item1.ctaText = @"Know More";
    [self.dataMutableArray addObject:item1];
    
    InfeedData *item2 = [[InfeedData alloc] init];
    item2.titleText = @"Nazia Firdose(测试数据)";
    item2.subtitleText = @"HR";
    item2.descriptionText = @"Please pray for these children in Syria after the death of their mother. The oldest sister has to take care of her younger siblings. -Ayad L Gorgees. ***Please don't scroll past without Typing Amen! because they need our prayers!!";
    item2.iconImageName = @"nazia.jpg";
    item2.primaryImageName = @"nazia_big.png";
    item2.ctaText = @"Know More";
    [self.dataMutableArray addObject:item2];
    
    InfeedData *item3 = [[InfeedData alloc] init];
    item3.titleText = @"Dharmesh Shah(测试数据)";
    item3.subtitleText = @"Founder at HubSpot";
    item3.descriptionText = @"Why, dear God, haven't you started marketing yet? http://dharme.sh/1Ewu63k by @gjain via @Inboundorg";
    item3.iconImageName = @"dharmesh.jpg";
    item3.primaryImageName = @"dharmesh_big.png";
    item3.ctaText = @"Know More";
    [self.dataMutableArray addObject:item3];
    
    InfeedData *item4 = [[InfeedData alloc] init];
    item4.titleText = @"Piyush Shah(测试数据)";
    item4.subtitleText = @"CPO";
    item4.descriptionText = @"With mobile being accepted as the definitive medium to access consumers’ minds and wallets, Brands have begun a multi-million dollar spending race to allure and retain customers.  Read on: https://lnkd.in/e8mcUfc";
    item4.iconImageName = @"piyush.jpg";
    item4.primaryImageName = @"piyush_big.png";
    item4.ctaText = @"Know More";
    [self.dataMutableArray addObject:item4];
    
    InfeedData *item5 = [[InfeedData alloc] init];
    item5.titleText = @"Jeff Weiner(测试数据)";
    item5.subtitleText = @"CEO at Linkedin";
    item5.descriptionText = @"Honored to represent LinkedIn's Economic Graph capabilities at the White House earlier today and partnering to Upskill America.";
    item5.iconImageName = @"jeff.jpg";
    item5.primaryImageName = @"jeff_big.png";
    item5.ctaText = @"Know More";
    [self.dataMutableArray addObject:item5];
}

@end
