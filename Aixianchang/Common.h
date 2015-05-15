//
//  Common.h
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+(NSDate*)timeStingToDate:(NSString*)d;
+(NSDate*)timeStingToDate:(NSString*)d formatt:(NSString*)formatt;
+(NSString*)dateToTimeString:(NSDate*)d;
+(NSString*)dateToTimeString:(NSDate*)d formatt:(NSString*)formatt;


//根据颜色和大小创建一张图片
+(UIImage *)imageWithColor:(UIColor*)color;
+(UIImage *)imageWithColor:(UIColor *)color  size:(CGSize) size;
+(UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+(UIImage *)imageWithColor:(UIColor *)color  path:(UIBezierPath*) bezierPath;

+ (UIButton*)navButtonWithTitle:(NSString*)title;
+ (UIButton*)navBackBtn;
+ (UIButton*)navBackBtn2;

+ (BOOL) checkPassword:(NSString*)password;

+(NSString*) makeCalendarOffset:(NSDate*)date;
@end
