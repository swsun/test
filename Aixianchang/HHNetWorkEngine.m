
#import "HHNetWorkEngine.h"

@implementation HHNetWorkEngine

- (MKNetworkOperation*) getDataByURL:(NSString*)path params:(NSDictionary*)params complete:(completeBlock)completeBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];

    MKNetworkOperation *op = [self operationWithPath:path params:parameters httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"request url >>>> %@",completedOperation.readonlyRequest.URL.absoluteString);
        if (!completedOperation.isCachedResponse)
            completeBlock(completedOperation.responseJSON, nil);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        completeBlock(nil, error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation*) postDataByURL:(NSString*)path params:(NSDictionary*)params complete:(completeBlock)completeBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];

//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(8.0)) {
//        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        [storage removeCookiesSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
//    }else {
//        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (NSHTTPCookie *cookie in storage.cookies) {
//            [storage deleteCookie:cookie];
//        }
    
//    }
    
    MKNetworkOperation *op = [self operationWithPath:path params:parameters httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"request url >>>> %@\nresponse :%@",completedOperation.readonlyRequest.URL.absoluteString,completedOperation.responseString);
        if (!completedOperation.isCachedResponse)
            completeBlock(completedOperation.responseJSON, nil);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        completeBlock(nil, error);
    }];
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *)uploadImage:(UIImage *)image complete:(completeBlock)completeBlock
{
    MKNetworkOperation *op = [self operationWithPath:UploadImage params:nil httpMethod:@"POST"];
//    [op addParams:@{@"fileName":@"avatar.jpg",@"type":@"jpg"}];
    [op addData:UIImageJPEGRepresentation(image, 1) forKey:@"file" mimeType:@"application/octet-stream" fileName:@"jpg"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completeBlock(completedOperation.responseJSON, nil);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        completeBlock(nil, error);
    }];
    [self enqueueOperation:op];
    return op;
}
@end
