#import "AFHTTPSessionManager+Method.h"
@implementation AFHTTPSessionManager (Method)
-(NSURLSessionTask *)zj_GET:(NSString *)URL withParams:(NSDictionary *)params successComplete:(successComplete)success failureComplete:(failureComplete)failure isShowHUD:(BOOL)isShow{
    WGradientProgress * progress;
    if (isShow) {
        progress  = [WGradientProgress sharedInstance];
        NXHNaviController * navi =    (NXHNaviController*) [UIApplication sharedApplication].keyWindow.rootViewController;
        if (![navi isKindOfClass:[NXHNaviController class]]) {
        }else{
            [progress showOnParent:navi.navigationBar position:WProgressPosDown];
            [progress setProgress:0.3];
        }
    }
NSURLSessionTask *task =    [self GET:URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

    return task;
}
@end
