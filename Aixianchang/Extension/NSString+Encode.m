//
//  NSString+Encode.m
//  Aixianchang
//
//  Created by zhangliugang on 15/2/11.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end
