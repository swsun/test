//
//  Common.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "Common.h"

@implementation Common

+(NSDate*)timeStingToDate:(NSString*)d
{
    return [self timeStingToDate:d formatt:@"yyyy-MM-dd HH:mm:ss"];
}
+(NSDate *)timeStingToDate:(NSString *)d formatt:(NSString *)formatt
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatt];
    return [dateFormatter dateFromString:d];
}
+(NSString *)dateToTimeString:(NSDate *)d
{
    return [self dateToTimeString:d formatt:@"yyyy-MM-dd HH:mm:ss"];
}
+(NSString *)dateToTimeString:(NSDate *)d formatt:(NSString *)formatt
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatt];
    return [dateFormatter stringFromDate:d];
}

+(UIImage *)imageWithColor:(UIColor*)color
{
    return [self imageWithColor:color size:CGSizeMake(10, 10)];
}

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize) size
{
    return [self imageWithColor:color path:[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)]];
}

+(UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    return [self imageWithColor:color path:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, cornerRadius * 3, cornerRadius * 3) cornerRadius:cornerRadius]];
}

+ (UIImage *)imageWithColor:(UIColor *)color path:(UIBezierPath *)bezierPath
{
    UIGraphicsBeginImageContext(bezierPath.bounds.size);
    [color setFill];
    [bezierPath fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIButton*)navButtonWithTitle:(NSString*)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    button.titleLabel.font = FONT16;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    return button;
}

+ (UIButton*)navBackBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button setBackgroundImage:[Common imageWithColor:[UIColor clearColor] size:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateNormal];
    [button setBackgroundImage:[Common imageWithColor:[UIColor clearColor] size:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateHighlighted];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitle:@"Back" forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 5)];
    button.titleLabel.font = FONT16;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    return button;
}

+ (UIButton*)navBackBtn2
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button setBackgroundImage:[Common imageWithColor:[UIColor clearColor] size:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateNormal];
    [button setBackgroundImage:[Common imageWithColor:[UIColor clearColor] size:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateHighlighted];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitle:@"Back" forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"left_arrow_gray"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"left_arrow_gray"] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 5)];
    button.titleLabel.font = FONT16;
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    return button;
}

+ (BOOL)checkPassword:(NSString *)password
{
    NSString *regex = @"^(?![^a-zA-Z]+$)(?!\\D+$).{8,}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:password];
}

+(NSString*) makeCalendarOffset:(NSDate*)date
{
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *currentComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currentDate];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSString *str = @"";
    if (currentComponents.year > dateComponents.year) {
        NSInteger offset = currentComponents.year - dateComponents.year;
        if (offset == 1)
            str = @"去年";
        else
            str = @"很久之前";
    }else if (currentComponents.month > dateComponents.month) {
        str = [NSString stringWithFormat:@"%d个月前",currentComponents.month - dateComponents.month];
    }else if (currentComponents.day > dateComponents.day) {
        NSInteger offset = currentComponents.day - dateComponents.day;
        if (offset == 1) {
            str = @"昨天";
        }else {
            str = [NSString stringWithFormat:@"%d天前",offset];
        }
    }else if (currentComponents.hour > dateComponents.hour) {
        str = [NSString stringWithFormat:@"%d小时前",currentComponents.hour - dateComponents.hour];
    }else {
        NSInteger offset = currentComponents.minute - dateComponents.minute;
        if (offset >= 10) {
            str = [NSString stringWithFormat:@"%d分钟前",offset];
        }else
            str = @"刚刚";
    }
    return str;
}

@end
