//
//  MBProgressHUD+Extension.m
//  Ymatou
//
//  Created by zhangliugang on 14/12/12.
//  Copyright (c) 2014年 zhoupei. All rights reserved.
//

#import "MBProgressHUD+Extension.h"


#if __has_feature(objc_arc)
#define MB_AUTORELEASE(exp) exp
#define MB_RELEASE(exp) exp
#define MB_RETAIN(exp) exp
#else
#define MB_AUTORELEASE(exp) [exp autorelease]
#define MB_RELEASE(exp) [exp release]
#define MB_RETAIN(exp) [exp retain]
#endif


@implementation MBProgressHUD (Extension)

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view labelText:(NSString*)text animated:(BOOL)animated
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    [view addSubview:hud];
    [hud show:animated];
    return MB_AUTORELEASE(hud);
}

+ (MBProgressHUD *)showHUDTextAddedTo:(UIView*)view text:(NSString*)text continueTime:(NSTimeInterval)time
{
    return [self showHUDTextAddedTo:view text:text offset:CGPointZero continueTime:time];
}

+ (MBProgressHUD *)showHUDDetailTextAddedTo:(UIView*)view text:(NSString*)text continueTime:(NSTimeInterval)time
{
    return [self showHUDDetailTextAddedTo:view text:text offset:CGPointZero continueTime:time];
}

+ (MBProgressHUD *)showHUDTextAddedTo:(UIView*)view text:(NSString*)text offset:(CGPoint)hudOffset continueTime:(NSTimeInterval)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    if (!CGPointEqualToPoint(hudOffset, CGPointZero)) {
        CGPoint center = hud.center;
        center.x += hudOffset.x;
        center.y += hudOffset.y;
        hud.center = center;
    }
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:time];
    return MB_AUTORELEASE(hud);
}
+ (MBProgressHUD *)showHUDDetailTextAddedTo:(UIView*)view text:(NSString*)text offset:(CGPoint)hudOffset continueTime:(NSTimeInterval)time
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    if (!CGPointEqualToPoint(hudOffset, CGPointZero)) {
        CGPoint center = hud.center;
        center.x += hudOffset.x;
        center.y += hudOffset.y;
        hud.center = center;
    }
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:time];
    return MB_AUTORELEASE(hud);
}

@end
