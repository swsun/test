
#import <MKNetworkKit/MKNetworkEngine.h>

typedef void (^completeBlock)(NSDictionary *responseObject, NSError *error);
typedef void (^imageDataBlock)(NSData *data);

@interface HHNetWorkEngine : MKNetworkEngine

- (MKNetworkOperation*) getDataByURL:(NSString*)url params:(NSDictionary*)params complete:(completeBlock)completeBlock;
- (MKNetworkOperation*) postDataByURL:(NSString*)url params:(NSDictionary*)params complete:(completeBlock)completeBlock;

- (MKNetworkOperation*) uploadImage:(UIImage*)image complete:(completeBlock)completeBlock;

@end
