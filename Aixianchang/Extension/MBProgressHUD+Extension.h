//
//  MBProgressHUD+Extension.h
//  Ymatou
//
//  Created by zhangliugang on 14/12/12.
//  Copyright (c) 2014年 zhoupei. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view labelText:(NSString*)text animated:(BOOL)animated;
+ (MBProgressHUD *)showHUDDetailTextAddedTo:(UIView*)view text:(NSString*)text continueTime:(NSTimeInterval)time;
+ (MBProgressHUD *)showHUDTextAddedTo:(UIView*)view text:(NSString*)text continueTime:(NSTimeInterval)time;
+ (MBProgressHUD *)showHUDTextAddedTo:(UIView*)view text:(NSString*)text offset:(CGPoint)hudOffset continueTime:(NSTimeInterval)time;
+ (MBProgressHUD *)showHUDDetailTextAddedTo:(UIView*)view text:(NSString*)text offset:(CGPoint)hudOffset continueTime:(NSTimeInterval)time;

@end
