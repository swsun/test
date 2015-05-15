//
//  AppDelegate.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/25.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "AppDelegate.h"
#import "XJNavController.h"
#import "GuideViewController.h"
#import "PersonalViewController.h"
#import "HomeViewController.h"
#import "DiscoveryViewController.h"
#import "LoginViewController.h"
#import "LikeViewController.h"
#import "MessageViewController.h"
#import "VideoController.h"

#import "UserModel.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "MainViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

static NSString *cacheToken = @"cacheToken";

@implementation AppDelegate

- (HHNetWorkEngine *)defaultEngine
{
    static HHNetWorkEngine *engine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[HHNetWorkEngine alloc] initWithHostName:HOSTADDRESS];
    });
    return engine;
}

- (void)setToken:(NSString *)token
{
    NSLog(@"token:%@",token);
    _token = token;
    [[NSUserDefaults standardUserDefaults] setValue:_token forKey:cacheToken];
    
    if (!token) {
        return;
    }
    
    NSDictionary *param = @{@"token":token};
    [ApplicationDelegate.defaultEngine postDataByURL:GetUserInfo params:param complete:^(NSDictionary *responseObject, NSError *error) {
        if (error) {
            return ;
        }
        if ([responseObject[RESPONSE_CODE] intValue] == 0) {
            UserModel *user = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:responseObject[RESPONSE_RESULT] error:nil];
            self.loginUser = user;
        }
    }];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WXApi registerApp:WeixinAppID];
    [UMSocialData setAppKey:UMAppKey];
    [UMSocialWechatHandler setWXAppId:WeixinAppID appSecret:WeixinAppSecre url:@"http://www.baidu.com"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    BOOL v = [[NSUserDefaults standardUserDefaults] boolForKey:VERSION];
//    if (!v) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:VERSION];
//        
//        self.window.rootViewController = [[VideoController alloc] init];
//        [self.window makeKeyAndVisible];
//        return YES;
//    }
    
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:cacheToken];
    if (token) {
        self.token = token;
        
        ViewController *vc = [[ViewController alloc] init];
        XJNavController *nav = [[XJNavController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }else {
        MainViewController *vc = [[MainViewController alloc] init];
        self.window.rootViewController = vc;
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    return [WXApi handleOpenURL:url delegate:self];
    return [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    return [WXApi handleOpenURL:url delegate:self];
    return [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - Init
- (void)initGuideViewController
{
    GuideViewController *ctrl = [[GuideViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = ctrl;
    [self.window makeKeyAndVisible];
}

- (void)initRootViewController
{
    self.rootController = [[UITabBarController alloc] init];
    self.rootController.tabBar.translucent = NO;
    self.rootController.delegate = self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName :UIColorFromRGB(0x868686),NSFontAttributeName:[UIFont systemFontOfSize:10]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName :UIColorFromRGB(0xcc3333),NSFontAttributeName:[UIFont systemFontOfSize:10]}
                                             forState:UIControlStateSelected];
//    [[UITabBar appearance] setBackgroundImage:[common imageWithColor:[UIColor colorWithHexString:@"f8f8f8"] size:CGRectMake(0, 0, 320, 48)]];
    [[self.rootController tabBar] setSelectionIndicatorImage:[UIImage new]];
    
    HomeViewController *ctrl1 = [[HomeViewController alloc] init];
    ctrl1.title = @"首页";
    XJNavController *nav1 = [[XJNavController alloc] initWithRootViewController:ctrl1];
    DiscoveryViewController *ctrl2 = [[DiscoveryViewController alloc] init];
    ctrl2.title = @"发现";
    XJNavController *nav2 = [[XJNavController alloc] initWithRootViewController:ctrl2];
    LikeViewController *ctrl3 = [[LikeViewController alloc] init];
    ctrl3.title = @"喜欢";
    XJNavController *nav3 = [[XJNavController alloc] initWithRootViewController:ctrl3];
    MessageViewController *ctrl4 = [[MessageViewController alloc] init];
    ctrl4.title = @"消息";
    XJNavController *nav4 = [[XJNavController alloc] initWithRootViewController:ctrl4];
    PersonalViewController *ctrl5 = [[PersonalViewController alloc] init];
    ctrl5.title = @"我";
    XJNavController *nav5 = [[XJNavController alloc] initWithRootViewController:ctrl5];
    
    
    [nav1.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"home2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav2.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"discovery"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"discovery2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav3.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"like2-H"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"like2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav4.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"message2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [nav5.tabBarItem setFinishedSelectedImage:[[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"me2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.rootController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.rootController;
    [self.window makeKeyAndVisible];
}

- (void)iLike:(UITapGestureRecognizer*)tap
{
    
}

#pragma mark UITabbarController
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    if (viewController == tabBarController.viewControllers.lastObject) {
//        if (!self.loginUser) {
//            LoginViewController *loginVc = [[LoginViewController alloc] init];
//            XJNavController *nav = [[XJNavController alloc] initWithRootViewController:loginVc];
//            [tabBarController presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;
}

#pragma mark WXApiDelegate
- (void)onReq:(BaseReq *)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    
}

@end
