//
//  ViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/17.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "ViewController.h"
#import "DetailController.h"
#import "PersonalViewController.h"
#import "LoginViewController.h"
#import "XJNavController.h"
#import "HtmlPageViewController.h"
#import "MainScroll.h"
#import "MainCell.h"
#import "FilterView.h"

#import "NewsModel.h"
#import "BannerModel.h"

#import "UINavigationBar+CustomHeight.h"

#define DefaultPageSize 20

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, FilterViewDelegate, MainScrollDelegate>
{
    NewsCategory currentCategory;
    NSUInteger currentPage;
    
    NSMutableArray *banners;
    NSMutableArray *news;
}
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) FilterView *filterView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MainScroll *scroll;
@end

static NSString *reuseIndetifier = @"reuse";

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        news = [NSMutableArray array];
        banners = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
//    UIView *r = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50,44);
    [rightBtn setImage:[UIImage imageNamed:@"main_icon1"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [r addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_icon1"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50,44);
    [leftBtn setImage:[UIImage imageNamed:@"main_icon2"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(showFilterView:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    [_topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [_topView addSubview:img];
    [img makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView);
        make.centerY.equalTo(_topView).offset(10);
    }];
    
    
    _filterView = [[FilterView alloc] initWithFrame:CGRectMake(0, 20, 320, 80)];
    _filterView.delegate = self;
    [self.view insertSubview:_filterView belowSubview:_topView];
    [_filterView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView);
        make.right.equalTo(_topView);
        make.height.equalTo(@80);
        make.bottom.equalTo(_topView.mas_bottom);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view insertSubview:_tableView belowSubview:_filterView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(46);
        make.bottom.equalTo(self.view);
    }];

    [self setRefresh];
    [self.tableView registerClass:[MainCell class] forCellReuseIdentifier:reuseIndetifier];

    self.scroll = [[MainScroll alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    self.scroll.delegate = self;

    self.tableView.tableFooterView = [UIView new];
    
    [self getBanner];
    [self getNews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)setRefresh
{
    __unsafe_unretained id weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        [weakSelf getNewNews];
        [weakSelf getBanner];
    }];
    [self.tableView addFooterWithCallback:^{
        [weakSelf getAppendNews];
    }];
}

- (void)getNews
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *param = @{@"page":@(currentPage),
                            @"size":@(DefaultPageSize),
                            @"category":@(currentCategory)};
    [ApplicationDelegate.defaultEngine getDataByURL:GetNews params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"ERROR" continueTime:1.0f];
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            [news removeAllObjects];
            
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
                NewsModel *model = [MTLJSONAdapter modelOfClass:[NewsModel class] fromJSONDictionary:dict error:nil];
                [news addObject:model];
            }
            [self.tableView reloadData];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];
}

- (void)getAppendNews
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *param = @{@"page":@(++currentPage),
                            @"size":@(DefaultPageSize),
                            @"category":@(currentCategory)};
    [ApplicationDelegate.defaultEngine getDataByURL:GetNews params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView footerEndRefreshing];
        
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"ERROR" continueTime:1.0f];
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            if (![responseObject[RESPONSE_RESULT] count]) {
                [MBProgressHUD showHUDDetailTextAddedTo:self.view text:@"没有更多啦!" continueTime:1.0f];
                --currentPage;
                return ;
            }
            
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
                NewsModel *model = [MTLJSONAdapter modelOfClass:[NewsModel class] fromJSONDictionary:dict error:nil];
                [news addObject:model];
            }
            [self.tableView reloadData];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];

}

- (void)getNewNews
{
    if (!news.count) {
        [self getNews];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *param = @{@"id":[news.firstObject newsId]};
    [ApplicationDelegate.defaultEngine getDataByURL:GetLastNews params:param complete:^(NSDictionary *responseObject, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView headerEndRefreshing];
        
        if (error) {
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:error.description continueTime:1.0f];
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
                NewsModel *model = [MTLJSONAdapter modelOfClass:[NewsModel class] fromJSONDictionary:dict error:nil];
//                [news addObject:model];
                [news insertObject:model atIndex:0];
            }
            [self.tableView reloadData];
        }else
            [MBProgressHUD showHUDDetailTextAddedTo:self.view text:responseObject[RESPONSE_MSG] continueTime:1.0f];
    }];

}

- (void) getBanner
{
    [ApplicationDelegate.defaultEngine getDataByURL:GetBanner params:@{} complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) return ;
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            [banners removeAllObjects];
            for (NSDictionary *dict in responseObject[RESPONSE_RESULT]) {
//                BannerModel *model = [[BannerModel alloc] initWithDictionary:dict error:nil];
                BannerModel *model = [MTLJSONAdapter modelOfClass:[BannerModel class] fromJSONDictionary:dict error:nil];
                [banners addObject:model];
            }
            
            if (banners.count) {
                self.scroll.models = banners;
                self.tableView.tableHeaderView = self.scroll;
            }else {
                self.tableView.tableHeaderView = nil;
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtonClicked:(id)sender
{
    if (!ApplicationDelegate.token) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    PersonalViewController *vc = [[PersonalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showFilterView:(id)sender
{
    if (!_filterView.tag)
        [UIView animateWithDuration:0.2 animations:^{
           [_filterView updateConstraints:^(MASConstraintMaker *make) {
               make.bottom.equalTo(_topView.mas_bottom).offset(80);
           }];
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            _filterView.tag = 1;
        }];
    else
        [self hideFilterView];
}

- (void)hideFilterView
{
    [UIView animateWithDuration:0.2 animations:^{
        [_filterView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_topView.mas_bottom);
        }];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        _filterView.tag = 0;
    }];
}

- (void)filterView:(FilterView *)filterView didSelectCategory:(NewsCategory)category
{
    [self hideFilterView];
    if (category == currentCategory) {
        return;
    }else {
        currentCategory = category;
        currentPage = 0;
        [self getNews];
    }
//    [self getNews:category page:0];
}

#pragma mark - mainscrolldelegate
- (void)mainScrollDidSelectAtIndex:(NSInteger)index
{
    BannerModel *model = banners[index];
    if (model.type == BannerTypeWeb) {
        HtmlPageViewController *webPage = [[HtmlPageViewController alloc] init];
        webPage.url = [NSString stringWithFormat:@"http://%@",model.contentUrl];
        [self.navigationController pushViewController:webPage animated:YES];
    }else if (model.type == BannerTypeNews) {
        NSInteger newsid = model.newsId.integerValue;
        DetailController *vc = [[DetailController alloc] init];
        vc.nnewsid = newsid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - tableVeiw delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return news.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndetifier forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"index:%ld",indexPath.row];
//    cell.model = nil;
    cell.model = news[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailController *vc = [[DetailController alloc] init];
    vc.model = news[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
