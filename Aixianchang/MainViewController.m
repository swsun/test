//
//  MainViewController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/17.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "XJNavController.h"
#import "Register1ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MainViewController ()
{
    UIButton *registBtn;
    UIButton *loginBtn;
    UIImageView *imgv;
    UIImageView *back;
    
        MPMoviePlayerController *mMoviePlayer;
        NSTimer *timer;
    
    BOOL isFirstLoad;
}
@end

static NSString *cacheToken = @"cacheToken";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:mMoviePlayer];
    mMoviePlayer.controlStyle = MPMovieControlStyleNone;
    mMoviePlayer.scalingMode = MPMovieScalingModeFill;
    
    [mMoviePlayer setFullscreen:YES animated:NO];
    
    [self.view addSubview:mMoviePlayer.view];
    [mMoviePlayer.view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(moviePlayDurationAvailableNotification:) userInfo:nil repeats:YES];
    
    back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_back2"]];
    back.hidden = YES;
    [self.view addSubview:back];
    [back makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    registBtn.alpha = 0;
    [registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setImage:[UIImage imageNamed:@"f2"] forState:UIControlStateNormal];
    [self.view addSubview:registBtn];
    [registBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.bottom.equalTo(self.view).offset(-55);
        make.width.equalTo(@138);
        make.height.equalTo(@34);
    }];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginBtn.alpha = 0;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setImage:[UIImage imageNamed:@"f1"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(-55);
        make.width.equalTo(@138);
        make.height.equalTo(@34);
    }];
    
    imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f3"]];
    imgv.userInteractionEnabled = YES;
    [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suii:)]];
    [self.view addSubview:imgv];
    [imgv makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view.mas_bottom).offset(-27);
            make.width.equalTo(@60);
            make.height.equalTo(@12);
    }];
    
//    UILabel *suibian = [UILabel new];
//    suibian.text = @"随便看看";
//    suibian.font = FONT9;
//    suibian.textColor = [UIColor whiteColor];
//    suibian.textAlignment = NSTextAlignmentCenter;
//    suibian.layer.borderColor = [UIColor whiteColor].CGColor;
//    suibian.layer.borderWidth = 1.0f;
//    suibian.layer.cornerRadius = 6.0f;
//    suibian.userInteractionEnabled = YES;
//    [suibian addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suii:)]];
//    [self.view addSubview:suibian];
//    [suibian makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view.mas_bottom).offset(-27);
//        make.width.equalTo(@60);
//        make.height.equalTo(@12);
//    }];
    
    loginBtn.hidden = YES;
    registBtn.hidden = YES;
    imgv.hidden = YES;
    loginBtn.alpha = 0;
    registBtn.alpha = 0;
    imgv.alpha = 0;
    
    isFirstLoad = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (isFirstLoad){
        [mMoviePlayer play];
        isFirstLoad = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
}

- (void)moviePlayBackDidFinish:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [mMoviePlayer stop];
    [mMoviePlayer.view removeFromSuperview];
    back.hidden = NO;
}

- (void)moviePlayDurationAvailableNotification:(id)sender
{
    NSLog(@"%f",mMoviePlayer.currentPlaybackTime);
    if (mMoviePlayer.currentPlaybackTime >= 0) {
        [timer invalidate];
        
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        registBtn.hidden = NO;
        loginBtn.hidden = NO;
        imgv.hidden = NO;
        
        [UIView animateWithDuration:2.0f animations:^{
            registBtn.alpha = 1;
            loginBtn.alpha = 1;
            imgv.alpha = 1;
        }];
//        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:cacheToken];
//        if (token) {
//            ApplicationDelegate.token = token;
//            
//            ViewController *vc = [[ViewController alloc] init];
//            XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
//            ApplicationDelegate.window.rootViewController = nav;
//        }else {
//            MainViewController *vc = [[MainViewController alloc] init];
//            ApplicationDelegate.window.rootViewController = vc;
//        }
    }
}

- (void)regist:(id)sender
{
    [self moviePlayBackDidFinish:nil];
    
    Register1ViewController *vc = [[Register1ViewController alloc] init];
    XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)login:(id)sender
{
    [self moviePlayBackDidFinish:nil];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)suii:(UITapGestureRecognizer*)tap
{
    [self moviePlayBackDidFinish:nil];
    
    ViewController *vc = [[ViewController alloc] init];
    XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
    ApplicationDelegate.window.rootViewController = nav;
}


@end
