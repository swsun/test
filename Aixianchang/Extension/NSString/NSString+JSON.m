//
//  NSString+JSON.m
//  Ymatou
//
//  Created by zhangliugang on 14-9-19.
//  Copyright (c) 2014年 zhoupei. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
- (id)JSONValue
{
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if(error)
    {
        return nil;
    }
    return returnValue;
}
@end
