//
//  VideoController.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/14.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "VideoController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"
#import "MainViewController.h"
#import "XJNavController.h"

@interface VideoController ()
{
    MPMoviePlayerController *mMoviePlayer;
    NSTimer *timer;
}
@end

static NSString *cacheToken = @"cacheToken";

@implementation VideoController

- (void)viewDidLoad
{
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mMoviePlayer play];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)moviePlayBackDidFinish:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:cacheToken];
    if (token) {
        ApplicationDelegate.token = token;
        
        ViewController *vc = [[ViewController alloc] init];
        XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
        ApplicationDelegate.window.rootViewController = nav;
    }else {
        MainViewController *vc = [[MainViewController alloc] init];
        ApplicationDelegate.window.rootViewController = vc;
    }
}

- (void)moviePlayDurationAvailableNotification:(id)sender
{
    NSLog(@"%f",mMoviePlayer.currentPlaybackTime);
    if (mMoviePlayer.currentPlaybackTime >= 10) {
        [timer invalidate];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:cacheToken];
        if (token) {
            ApplicationDelegate.token = token;
            
            ViewController *vc = [[ViewController alloc] init];
            XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
            ApplicationDelegate.window.rootViewController = nav;
        }else {
            MainViewController *vc = [[MainViewController alloc] init];
            ApplicationDelegate.window.rootViewController = vc;
        }
    }
}

@end
