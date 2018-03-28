#import "NetworkTool.h"
#import "NXHNaviController.h"
@interface NetworkTool()
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@end
@implementation NetworkTool
single_implementation(NetworkTool);
-(AFHTTPSessionManager*)factoryMethodWithHeader:(NSDictionary *)header{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    for (NSString * key in header) {
        NSString * value = [header valueForKey:key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    return  manager;
}
-(instancetype)init{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
         [_manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [_manager.requestSerializer setValue:@"3F8JFfdWWg3px3oOu3v9Cdsg-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
        [_manager.requestSerializer setValue:@"XWl16DLkeC0tdTVQnYUvGIFI" forHTTPHeaderField:@"X-LC-Key"];
    }
    return  self;
}
-(void)GET:(NSString *)URL withParams:(NSDictionary *)params successComplete:(successComplete)success failureComplete:(failureComplete)failure isShowHUD:(BOOL)isShow{
    WGradientProgress * progress;
    if (isShow) {
     progress  = [WGradientProgress sharedInstance];
        NXHNaviController * navi =    (NXHNaviController*) [UIApplication sharedApplication].keyWindow.rootViewController;
        [progress showOnParent:navi.navigationBar position:WProgressPosDown];
        [progress setProgress:0.3];
    }
    [self.manager GET:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        [progress setProgress:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isShow?[progress hide]:nil;
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [progress setProgress:0.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    isShow?[progress hide]:nil;
        });
    }];
}
@end
