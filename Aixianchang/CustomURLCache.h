//
//  CustomURLCache.h
//  Ymatou
//
//  Created by Evan on 7/30/14.
//  Copyright (c) 2014 zhoupei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomURLCache : NSURLCache

//- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime;

+ (CustomURLCache *)sharedCustomURLCache;

- (void) initialize;

@end
