//
//  HomeViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/28.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "HomeViewController.h"
#import "CityListController.h"
#import "ActivityModel.h"
#import "SuggestActivityView.h"
#import "UMSocial.h"

@interface HomeViewController () <UMSocialUIDelegate, CityLsitDelegate>
@property (strong, nonatomic) UILabel *currentCity;
@property (strong, nonatomic) SuggestActivityView *actView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
    UIView *tv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    tv.center = CGPointMake(SCREEN_WIDTH / 2, 22);
    tv.backgroundColor = [UIColor clearColor];
    tv.userInteractionEnabled = YES;
    [tv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCity:)]];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_title"]];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    titleImage.frame = CGRectMake(0, 12, 55, 20);
    [tv addSubview:titleImage];
    [titleImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tv);
        make.centerY.equalTo(tv);
        make.height.equalTo(@20);
        make.width.equalTo(@54);
    }];
    
    _currentCity = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 40, 44)];
    _currentCity.backgroundColor = [UIColor clearColor];
    _currentCity.textColor = [UIColor whiteColor];
    _currentCity.font = [UIFont boldSystemFontOfSize:14];
    _currentCity.text = @"上海";
    _currentCity.textAlignment = NSTextAlignmentLeft;
    [tv addSubview:_currentCity];
    [_currentCity makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImage.mas_right).offset(3);
        make.centerY.equalTo(titleImage);
    }];
    
    self.navigationItem.titleView = tv;
    
    UIImageView *right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"three_point"]];
    right.contentMode = UIViewContentModeScaleAspectFit;
    right.frame = CGRectMake(0, 0, 47*0.6, 6);
    right.userInteractionEnabled = YES;
    [right addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(share:)]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    [self.view addSubview:back];
    [back makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(40, 30, 100, 30));
    }];
    
    _actView = [[SuggestActivityView alloc] init];
    [back addSubview:_actView];
    [_actView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(back).insets(UIEdgeInsetsMake(0, 0.5, 0, 6));
    }];
    [self reloadActView:[[ActivityModel alloc] init]];
    
    UIImageView *close = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close"]];
    [self.view addSubview:close];
    
    UIImageView *like = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like"]];
    [self.view addSubview:like];

    
    [close makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back.mas_left).offset(30);
        make.top.equalTo(back.mas_bottom).offset(20);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];

    [like makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(back.mas_right).offset(-30);
        make.top.equalTo(back.mas_bottom).offset(20);
        make.width.equalTo(close);
        make.height.equalTo(close);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectCity:(id)sender {
    CityListController *vc = [[CityListController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reloadActView:(ActivityModel*)model
{
    model.title = @"草泥马\"悲观主义三部曲\"";
    model.addr = @"上海市灵石路495";
    model.startDate = @"2014年1月1日";
    model.summary = @"sdfaddsgwlfnweofiweudfiwef到什么破期间我怕额级人物";
    model.loveNum = @123;
    model.forwardNum = @3333;
    _actView.model = model;
}

- (void)share:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@""
                                      shareText:@""
                                     shareImage:[UIImage imageNamed:@""]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToTencent]
                                       delegate:self];
}

#pragma mark - CityListDelegate
- (void)didSelectCity:(NSString *)city
{
    _currentCity.text = city;
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
