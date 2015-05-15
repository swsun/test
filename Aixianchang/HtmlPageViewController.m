//
//  HtmlPageViewController.m
//  ymatou
//
//  Created by 草泥马 on 14-8-29.
//  Copyright (c) 2014年 草泥马. All rights reserved.
//

#import "HtmlPageViewController.h"
//#import "MyUINavigationController.h"
//#import "AddBackTopButtonWebView.h"
//#import "BaseApi.h"

@interface HtmlPageViewController () {
//    BOOL IsFirstTime;
//    UIBarButtonItem *rightBarBtn;
}

@property(strong,nonatomic) CustomWebView * webview;
@end

@implementation HtmlPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        IsFirstTime = YES;
//        rightBarBtn = nil;
        
        _webview = [[CustomWebView alloc] init];
        [self.view addSubview:_webview];
        [_webview makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _webview.parentController = self;
        _webview.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    _webview.urlStr = _url;
    [_webview StartLoadPage];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    MyUINavigationController * v = (MyUINavigationController *)self.navigationController;
//    [v hideStatusView];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//-(void)rightItem
//{
//    if (_shareFlag && rightBarBtn == nil) {
//        UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareMethod)];
//        
//        UIView *_rightBarView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 60, 44)];
//        for(UITapGestureRecognizer * t in _rightBarView.gestureRecognizers)
//        {
//            [_rightBarView removeGestureRecognizer:t];
//        }
//        for(UIView * t in _rightBarView.subviews)
//        {
//            [t removeFromSuperview];
//        }
//        [_rightBarView setUserInteractionEnabled:YES];
//        [_rightBarView addGestureRecognizer:shareTap];
//        rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_rightBarView];
//        [_rightBarView setBackgroundColor:[UIColor clearColor]];
//        UILabel *  rightBarLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        [_rightBarView addSubview:rightBarLabel];
//        [rightBarLabel makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_rightBarView.mas_top).offset(3);
//            make.right.equalTo(_rightBarView.mas_right);
//        }];
//        rightBarLabel.font = IconFontWithSize(24);
//        rightBarLabel.textAlignment = NSTextAlignmentRight;
//        rightBarLabel.text = @"\U0000E63B";
//        rightBarLabel.textColor = UIColorFromRGB(0xb8b8b8);
//        rightBarLabel.backgroundColor = [UIColor clearColor];
//        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectZero];
//        [_rightBarView addSubview:lable];
//        [lable makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(rightBarLabel.centerX);
//            make.top.equalTo(rightBarLabel.mas_bottom).offset(-3);
//        }];
//        [lable setFont:FONT11];
//        lable.text = @"分享";
//        lable.textColor = UIColorFromRGB(0xb8b8b8);
//        [lable setBackgroundColor:[UIColor clearColor]];
//        [[_rightBarView viewWithTag:555] removeFromSuperview];
//        self.navigationItem.rightBarButtonItem = rightBarBtn;
//    }
//}

-(BOOL) PushViewController:(NSString *)url
{
    return YES;
}

@end
