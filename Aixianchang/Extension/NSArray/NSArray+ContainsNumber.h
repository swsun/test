//
//  NSArray+ContainsNumber.h
//  Ymatou
//
//  Created by zhangliugang on 14-5-8.
//  Copyright (c) 2014年 zhoupei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ContainsNumber)
- (BOOL) containsNumber:(NSNumber*)num;
- (BOOL) containsString:(NSString*)str;
@end

@interface NSMutableArray (RemoveNumber)
- (void) removeNumber:(NSNumber*)num;
- (void) removeString:(NSString*)str;
@end
