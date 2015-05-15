//
//  XJNavController.m
//  Shopping
//
//  Created by YangJian on 13-4-10.
//  Copyright (c) 2013年 YangJian. All rights reserved.
//

#import "XJNavController.h"
#import "ViewController.h"
#import "DetailController.h"
#import "PersonalViewController.h"
#import "ProfileViewController.h"

@interface XJNavController ()

@end

@implementation XJNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(7.0))
        {
            self.navigationBar.barTintColor = UIColorFromRGB(0x686868);
            self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        }
        else
        {
//            [self.navigationBar setBackgroundImage:[Common imageWithColor:UIColorFromRGB(0x686868) size:CGSizeMake(SCREEN_WIDTH, 44)] forBarMetrics:UIBarMetricsDefault];
             [self.navigationBar setBackgroundImage:[Common imageWithColor:[UIColor redColor] size:CGSizeMake(SCREEN_WIDTH, 44)] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor], UITextAttributeFont: FONT18, UITextAttributeTextShadowOffset: @0};//iOS6设置导航栏字体没有阴影
        }
        self.navigationBar.translucent = NO;
        self.navigationBar.shadowImage = [UIImage new];
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
        
        self.delegate = self;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    UIImage *no_nav = [Common imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 64)];
    UIImage *nav = [Common imageWithColor:UIColorFromRGB(0x686868) size:CGSizeMake(320, 44)];
    
    if ([viewController isKindOfClass:[ViewController class]] ||
        [viewController isKindOfClass:[DetailController class]] ||
        [viewController isKindOfClass:[PersonalViewController class]] ||
        [viewController isKindOfClass:[ProfileViewController class]]) {
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(7.0))
            [self.navigationBar setBackgroundImage:no_nav forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        else
            self.navigationBar.backgroundColor = [UIColor clearColor];
//        [self.navigationBar setBarTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
        [self.navigationBar setTranslucent:YES];
        [self.navigationBar.layer setMasksToBounds:YES]; //去掉多余的一条白线
    } else {//回到其他页面恢复
//        [self.navigationBar setBackgroundImage:nav forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(7.0))
            [self.navigationBar setBarTintColor:UIColorFromRGB(0x686868)];
        else
            self.navigationBar.backgroundColor = UIColorFromRGB(0x686868);
        [self.navigationBar.layer setMasksToBounds:NO];
        [self.navigationBar setTranslucent:NO];
        
    }

    if (viewController == navigationController.viewControllers.firstObject)
        return;
    
    UIButton *back;
    if ([viewController isKindOfClass:[DetailController class]]) {
        back = [Common navBackBtn2];
    }else
        back = [Common navBackBtn];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
}

- (void)back:(id)sender
{
    [self popViewControllerAnimated:YES];
}
@end
