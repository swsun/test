//
//  AppDelegate.h
//  Aixianchang
//
//  Created by zhangliugang on 14/12/25.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "HHNetWorkEngine.h"

#import "UserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *rootController;

@property (copy, nonatomic) UserModel *loginUser;
@property (copy, nonatomic) NSString *token;

@property (strong, nonatomic, readonly) HHNetWorkEngine *defaultEngine;

@end

