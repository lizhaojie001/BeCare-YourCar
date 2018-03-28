#import <AFNetworking/AFNetworking.h>
@interface AFHTTPSessionManager (Method)
-(NSURLSessionTask* )zj_GET:(NSString *)URL withParams:(NSDictionary*)params successComplete:(successComplete)success failureComplete:(failureComplete)failure isShowHUD:(BOOL)isShow;
@end
