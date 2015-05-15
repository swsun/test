//
//  User.m
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)setNilValueForKey:(NSString *)key
{
    
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"userId":@"id"};
}

//+ (NSValueTransformer *)sexJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
//               @"gg": @(UserSexMale),
//               @"mm": @(UserSexFemale)
//               }];
//}

/*
+ (NSValueTransformer *)typeJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                @"1":@(UserTypeNormal),
                @"2":@(UserTypeWriter),
                @"3":@(UserTypeOrgnize)
                }];
}

+ (NSValueTransformer *)statusJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
               @"1":@(UserStatusOpen),
               @"2":@(UserStatusClose)
               }];
}
*/

+ (NSValueTransformer *)pictureJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


+ (NSValueTransformer*)birthdayJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
        return [NSDate dateWithTimeIntervalSince1970:str.longLongValue / 1000];
//        return [[self dateFormatter] dateFromString:str];
    } reverseBlock:^id(NSDate *date) {
        return [[self dateFormatter] stringFromDate:date];
    }];
}
@end



@implementation UserModel (Encode)

- (BOOL)saveToApplicationDocument
{
    NSString *defaultPath = [DocumentationDirectory stringByAppendingString:@"/User"];
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:defaultPath];
    
    return success;
}

+ (UserModel *)readFromApplicationDocument
{
    UserModel *model  = [NSKeyedUnarchiver unarchiveObjectWithFile:[DocumentationDirectory stringByAppendingString:@"/User"]];
    return model;
}

+ (void)clearArchivedUser
{
    
}

@end