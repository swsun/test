//
//  AssistViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/23.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "AssistViewController.h"
#import "HtmlPageViewController.h"
#import <StoreKit/StoreKit.h>

#import "SingleCell.h"

#import "UMSocial.h"

@interface AssistViewController () <UITableViewDelegate, UITableViewDataSource, UMSocialUIDelegate, SKStoreProductViewControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *tableTitles;
@end

static NSString *reuseIdentifier = @"reuse";

@implementation AssistViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        _tableTitles = @[@"帮助",@"用户反馈",@"检查新版本",@"给爱现场评分",@"邀请小伙伴"];
        _tableTitles = @[@"帮助",@"给爱现场评分",@"邀请小伙伴"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"帮助";
    self.view.backgroundColor = BackgroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = BackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.tableFooterView = [UIView new];
//    _tableView.tableHeaderView = self.tableHeaderView;
    [_tableView registerClass:[SingleCell class] forCellReuseIdentifier:reuseIdentifier];
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _tableTitles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"personal_icon%ld.png",indexPath.row+1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            HtmlPageViewController *webPage = [[HtmlPageViewController alloc] init];
            webPage.url = @"http://live.linking5.com/Html/events/apphelp.html";
            [self.navigationController pushViewController:webPage animated:YES];
        }
            break;
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=967912197"]];
        }
            break;
        case 2:
        {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"http://live.linking5.com/Html/events/img/ai_logo.jpg"] options:SDWebImageDownloaderHighPriority |SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://live.linking5.com/Html/events/appdownload.html";
                [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
                [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://live.linking5.com/Html/events/appdownload.html";
                [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
                [UMSocialSnsService presentSnsIconSheetView:self
                                                     appKey:UMAppKey
                                                  shareText:@"爱现场"
                                                 shareImage:image
                                            shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession]
                                                   delegate:self];
            }];
            
        }
            break;
        default:
            break;
    }
}
@end
