//
//  CustomURLCache.m
//  Ymatou
//
//  Created by Evan on 7/30/14.
//  Copyright (c) 2014 zhoupei. All rights reserved.
//

#import "CustomURLCache.h"
#import "Reachability.h"
//#import "str2md5.h"
#import "NSString+MD5.h"

@interface CustomURLCache()

@property (nonatomic, assign) NSInteger cacheTime;
@property (nonatomic, copy) NSString *diskPath;
@property (nonatomic, retain) NSMutableDictionary *responseDictionary;
//@property (nonatomic, retain) NSCachedURLResponse *cachedResponse;

- (NSString *)cacheFolder;
- (NSString *)cacheFilePath:(NSString *)file;
- (NSString *)cacheRequestFileName:(NSString *)requestUrl;
- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl;
- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request;
- (void)deleteCacheFolder;

@end

@implementation CustomURLCache

+ (CustomURLCache *)sharedCustomURLCache
{
    static CustomURLCache *_sharedAPIKit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAPIKit = [[CustomURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
                                                          diskCapacity:20 * 1024 * 1024
                                                              diskPath:nil
                                                             cacheTime:2 * 60 * 60];
    });
    return _sharedAPIKit;
}

- (void) initialize {
    [[CustomURLCache sharedCustomURLCache] removeAllCachedResponses];
    [CustomURLCache setSharedURLCache:[CustomURLCache sharedCustomURLCache]];
}

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime {
    if (self = [self initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
        self.cacheTime = cacheTime;
        if (path)
            self.diskPath = path;
        else
            self.diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        self.responseDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    NSRange range = [request.URL.absoluteString rangeOfString:ApplicationDelegate.sysInfoModel.WapLinkHost];
    if (range.location == NSNotFound ) {
        return nil;
    }
    if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame) {
        return [super cachedResponseForRequest:request];
    }
    
    return [self dataFromRequest:request];
}

- (void)removeAllCachedResponses {
    [super removeAllCachedResponses];
    
    [self deleteCacheFolder];
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
    [super removeCachedResponseForRequest:request];
    
    NSString *url = request.URL.absoluteString;
    NSString *fileName = [self cacheRequestFileName:url];
    NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
    NSString *filePath = [self cacheFilePath:fileName];
    NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    [fileManager removeItemAtPath:otherInfoPath error:nil];
}

-(BOOL)networkAvailable
{
    if ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) {
        return YES;
    }
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) {
        return YES;
    }
    return NO;
}

#pragma mark - custom url cache

- (NSString *)cacheFolder {
    return @"URLCACHE";
}

- (void)deleteCacheFolder {
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}

- (NSString *)cacheFilePath:(NSString *)file {
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        
    } else {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSString stringWithFormat:@"%@/%@", path, file];
}

- (NSString *)cacheRequestFileName:(NSString *)requestUrl {
    return [requestUrl md5];
}

- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl {
    return [[NSString stringWithFormat:@"%@-otherInfo", requestUrl] md5];
}

- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request {
//    if (![request.URL.absoluteString hasPrefix:ApplicationDelegate.sysInfoModel.WapLinkHost]) {
//        return nil;
//    }
//    
    NSString *url = request.URL.absoluteString;
    NSString *fileName = [self cacheRequestFileName:url];
    NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
    NSString *filePath = [self cacheFilePath:fileName];
    NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
    NSDate *date = [NSDate date];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL expire = false;
        NSDictionary *otherInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
        
        if (self.cacheTime > 0) {
            NSInteger createTime = [[otherInfo objectForKey:@"time"] intValue];
            if (createTime + self.cacheTime < [date timeIntervalSince1970]) {
                expire = true;
            }
        }
        
        if (expire == false) {
            NSLog(@"data from cache ...");
            
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL
                                                                MIMEType:[otherInfo objectForKey:@"MIMEType"]
                                                   expectedContentLength:data.length
                                                        textEncodingName:[otherInfo objectForKey:@"textEncodingName"]];
            NSCachedURLResponse *cachedUrl = [[[NSCachedURLResponse alloc] initWithResponse:response data:data] autorelease];
            [response release];
            return cachedUrl;
        } else {
            NSLog(@"cache expire ... ");
            
            [fileManager removeItemAtPath:filePath error:nil];
            [fileManager removeItemAtPath:otherInfoPath error:nil];
        }
    }
    if (![self networkAvailable]) {
        return nil;
    }
    //    __block NSCachedURLResponse *cachedResponse = nil;
    //sendSynchronousRequest请求也要经过NSURLCache
    id boolExsite = [self.responseDictionary objectForKey:url];
    NSLog(@"url = %@", url);
    if (boolExsite == nil) {
        [self.responseDictionary setValue:[NSNumber numberWithBool:TRUE] forKey:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error) {
            if (response && data) {
                
                [self.responseDictionary removeObjectForKey:url];
                
                if (error) {
                    NSLog(@"error : %@", error);
                    NSLog(@"not cached: %@", request.URL.absoluteString);
                    //                    _cachedResponse = nil;
                }
                
                NSLog(@"cache url --- %@ ",url);
                
                BOOL cacheFlag = YES;
                NSRange rangeUpdateLoginStatus = [request.URL.absoluteString rangeOfString:interface_updateLogin]; //判断字符串是否包含
                if (rangeUpdateLoginStatus.location != NSNotFound) {
                    cacheFlag = NO;
                }
                
                if (cacheFlag == YES) {
                    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",
                                          response.MIMEType, @"MIMEType",
                                          response.textEncodingName, @"textEncodingName", nil];
                    [dict writeToFile:otherInfoPath atomically:YES];
                    [data writeToFile:filePath atomically:YES];
                }
                //save to cache
                
                //                _cachedResponse = [[[NSCachedURLResponse alloc] initWithResponse:response data:data] autorelease];
            }
        }];
        
        //        return _cachedResponse;
        //NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    }
    return nil;
}

@end
