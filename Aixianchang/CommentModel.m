//
//  CommentModel.m
//  Aixianchang
//
//  Created by zhangliugang on 15/1/22.
//  Copyright (c) 2015年 Caonima. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"commentId":@"id"};
}

+ (NSValueTransformer*)pictureJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer*)isshareJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer*)createDateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
        return [[self dateFormatter] dateFromString:str];
    } reverseBlock:^id(NSDate *date) {
        return [[self dateFormatter] stringFromDate:date];
    }];
}

- (void)setNilValueForKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
