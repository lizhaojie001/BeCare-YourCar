#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <AFNetworking.h>
typedef void(^successComplete)(id);
typedef void(^failureComplete)(id);
@interface NetworkTool : NSObject
single_interface(NetworkTool)
-(void)GET:(NSString *)URL withParams:(NSDictionary*)params successComplete:(successComplete)success failureComplete:(failureComplete)failure isShowHUD:(BOOL)isShow;
-(AFHTTPSessionManager*)factoryMethodWithHeader:(NSDictionary*)header;
@end
