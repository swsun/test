//
//  NSArray+ContainsNumber.m
//  Ymatou
//
//  Created by zhangliugang on 14-5-8.
//  Copyright (c) 2014年 zhoupei. All rights reserved.
//

#import "NSArray+ContainsNumber.h"

@implementation NSArray (ContainsNumber)
- (BOOL)containsNumber:(NSNumber *)num
{
    for (id obj in self) {
        if ([obj isKindOfClass:[NSNumber class]] && [obj isEqualToNumber:num]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsString:(NSString *)str
{
    for (id obj in self) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}
@end

@implementation NSMutableArray (RemoveNumber)

- (void)removeNumber:(NSNumber *)num
{
    for (id n in self) {
        if ([n isKindOfClass:[NSNumber class]] && [n isEqualToNumber:num]) {
            [self removeObject:n];
        }
    }
}

- (void)removeString:(NSString *)str
{
    for (id s in self) {
        if ([s isKindOfClass:[NSString class]] && [s isEqualToString:str]) {
            [self removeObject:s];
        }
    }
}

@end