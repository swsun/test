//
//  CustomWebView.m
//  ymatou
//
//  Created by 草泥马 on 14-8-29.
//  Copyright (c) 2014年 草泥马. All rights reserved.
//

#import "CustomWebView.h"
#import "HtmlPageViewController.h"
//#import "LoginController.h"
//#import "ChatListController.h"
//#import "ChatViewController.h"
//#import "PayOrderViewController.h"
//#import "MyUINavigationController.h"
//#import "CustomURLCache.h"

//#import "BaseApi.h"

@interface CustomWebView () {
    NSURLRequest *_urlRequest;
    BOOL updateLoginOk;
}
@property(assign,nonatomic) BOOL reloading;
@property(strong,nonatomic) UIImageView * loadingImv;
@property(strong,nonatomic) UIActivityIndicatorView * indictorView;
@end

@implementation CustomWebView
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        updateLoginOk = YES;
        
//        _delegate = delegate;
        _webView = [[UIWebView alloc] init];
//        [self cancle_bounds:_webView];
        [_webView setBackgroundColor:UIColorFromRGB(0xF7F7F7)];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(7.0))
            _webView.tintColor = UIColorFromRGB(0xF7F7F7);
        _webView.delegate = self;
        _webView.scrollView.delegate = self;
        [self addSubview:_webView];
        [_webView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
//        if (_refreshHeaderView == nil) {
//            _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0- _webView.scrollView.bounds.size.height, _webView.scrollView.frame.size.width, _webView.scrollView.bounds.size.height)];
//            _refreshHeaderView.delegate = self;
//            [_webView.scrollView addSubview:_refreshHeaderView];
//        }
//        [_refreshHeaderView refreshLastUpdatedDate];
        _loadingImv = [[UIImageView alloc] initWithFrame:_webView.frame];
        _loadingImv.contentMode = UIViewContentModeScaleAspectFit;
        [_loadingImv setImage:[UIImage imageNamed:@"k-laoding"]];
        [_webView addSubview:_loadingImv];
        _indictorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 220, 30,30)];
        _indictorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        _indictorView.color = [UIColor redColor];
        [_webView addSubview:_indictorView];
//        [_indictorView startAnimating];
    }
    return self;
}
//-(void) setUrlStr:(NSString *)urlStr
//{
//    self.urlStr = urlStr;
//}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _webView.frame = frame;
}
//
//- (void)updateLoginState {
//    NSMutableString *completeUrl = [NSMutableString stringWithFormat:@"%@%@",ApplicationDelegate.sysInfoModel.WapLinkHost, interface_updateLogin];
//    if (ApplicationDelegate.hasLogined) {
//        NSRange temStr = [completeUrl rangeOfString:@"?"]; //判断字符串是否包含
//        if (temStr.location != NSNotFound) {
//            [completeUrl appendFormat:@"&UserId=%@&AccessToken=%@&User-Agent=%@", ApplicationDelegate.loginModel.UserId, ApplicationDelegate.loginModel.AccessToken, ChannelName];
//        } else {
//            [completeUrl appendFormat:@"?UserId=%@&AccessToken=%@&User-Agent=%@", ApplicationDelegate.loginModel.UserId, ApplicationDelegate.loginModel.AccessToken, ChannelName];
//        }
//    } else {
//        {
//            NSRange temStr = [completeUrl rangeOfString:@"?"]; //判断字符串是否包含
//            if (temStr.location != NSNotFound) {
//                [completeUrl appendFormat:@"&UserId=%@&AccessToken=%@", @"nil", @"nil"];
//            } else {
//                [completeUrl appendFormat:@"?UserId=%@&AccessToken=%@", @"nil", @"nil"];
//            }
//        }
//    }
//    
//    updateLoginOk = NO;
//    NSURLRequest *updateRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:completeUrl]];
//    [NSURLConnection sendAsynchronousRequest:updateRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error) {
//        updateLoginOk = YES;
//    }];
//}

-(void) StartLoadPage
{
    NSMutableString *completeUrl = [NSMutableString stringWithString:_urlStr];
//    [completeUrl insertString:HOSTADDRESS atIndex:0];
//    if (ApplicationDelegate.hasLogined) {
//        NSRange temStr = [completeUrl rangeOfString:@"?"]; //判断字符串是否包含
//        if (temStr.location != NSNotFound) {
//            [completeUrl appendFormat:@"&UserId=%@&AccessToken=%@&User-Agent=%@", ApplicationDelegate.loginModel.UserId, ApplicationDelegate.loginModel.AccessToken, ChannelName];
//        } else {
//            [completeUrl appendFormat:@"?UserId=%@&AccessToken=%@&User-Agent=%@", ApplicationDelegate.loginModel.UserId, ApplicationDelegate.loginModel.AccessToken, ChannelName];
//        }
//    } else {
//        {
//            NSRange temStr = [completeUrl rangeOfString:@"?"]; //判断字符串是否包含
//            if (temStr.location != NSNotFound) {
//                [completeUrl appendFormat:@"&UserId=%@&AccessToken=%@", @"nil", @"nil"];
//            } else {
//                [completeUrl appendFormat:@"?UserId=%@&AccessToken=%@", @"nil", @"nil"];
//            }
//        }
//    }
//    
    NSLog(@"=============>>>web url%@",completeUrl);
//    _urlRequest = nil;
    _urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:completeUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [_webView loadRequest:_urlRequest];
    [_indictorView startAnimating];
}

- (void)dealloc {
    
}

#pragma mark - webview
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [self hideLoading];
//    [_indictorView startAnimating];

    NSLog(@"webView url:%@", request.URL.absoluteString);
    
    return YES;
//    if (_webView.tag == 1 || _webView.tag == 2 || _webView.tag == 3 || _webView.tag == 4) {
//        
//    } else {
//        if ([request.URL.absoluteString hasPrefix:_urlStr] || [_urlStr hasPrefix:request.URL.absoluteString]) {
//            return YES;
//        }
//    }
//    
//    if (!updateLoginOk) {
//        return NO;
//    }
//    
//    
//    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [_loadingImv setImage:[UIImage imageNamed:@"k-laoding"]];
    _reloading = YES;
    
//    [self hideLoading];
}

-(void)hideLoading
{
    [UIView animateWithDuration:0.2f animations:^{
        _loadingImv.alpha = 0;
    } completion:^(BOOL finished) {
        _loadingImv.hidden = YES;
    }];
//    [_indictorView stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _reloading = NO;
    
//    [self hideLoading];
    [_indictorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    _reloading = NO;
    
    _loadingImv.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [_loadingImv setImage:[UIImage imageNamed:@"k-404"]];
        _loadingImv.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    [_indictorView stopAnimating];
    for(UITapGestureRecognizer * t in _loadingImv.gestureRecognizers)
    {
        [_loadingImv removeGestureRecognizer:t];
    }
    UITapGestureRecognizer * tt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StartLoadPage)];
    [_loadingImv setUserInteractionEnabled:YES];
    [_loadingImv addGestureRecognizer:tt];
    
//    [[CustomURLCache sharedCustomURLCache] removeAllCachedResponses];
}

#pragma mark UIScrollViewDelegate Methods

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
-(void) cancle_bounds:(UIWebView *) view
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version<5)
    {
        for (id subview in view.subviews)
            if ([[subview class] isSubclassOfClass: [UIScrollView class]])
                ((UIScrollView *)subview).bounces = NO;
    }
    else
    {
        
        view.scrollView.bounces=NO;
    }
}

#pragma mark - SocialShareView Delegate method

@end
