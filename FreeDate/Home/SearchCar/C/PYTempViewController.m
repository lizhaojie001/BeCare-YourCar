#import "PYTempViewController.h"
#import "PYSearchConst.h"
#import "SearchResult.h"
@interface PYTempViewController ()<PYSearchViewControllerDelegate>
@property (nonatomic) AFHTTPSessionManager * manager;
@property (nonatomic,strong) RLMResults * arrData;
@end
@implementation PYTempViewController
#pragma mark-lazy
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
      _manager = [AFHTTPSessionManager manager];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy.validatesDomainName = NO;
        [ _manager.requestSerializer setValue:@"iPhone 11.3 autohome 8.9.0 iPhone" forHTTPHeaderField:@"User-Agent"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@0 forKey:@"-is_show_app"];
    [params setValue:@"app" forKey:@"_appid"];
    [params setValue:@"content" forKey:@"ignores"];
    [params setValue:@"39.983337" forKey:@"lat"];
    [params setValue:@"116.378433" forKey:@"lgt"];
    [params setValue:@(0) forKey:@"modify"];
    [params setValue:@(0)  forKey:@"offset"];
    [params setValue:@"h5" forKey:@"pf"];
    [params setValue:@"H6" forKey:@"q"];
    [params setValue:@1 forKey:@"s"];
    [params setValue:@(20) forKey:@"size"];
    [params setValue:@"app" forKey:@"tm"];
    [params setValue:@"3da6addb5b9bdb6f5244c7588525bb8ce73c891e" forKey:@"uid"];
    [params setValue:@"4c38f3030e40bf92646a63e6acbf3dc44250ad84" forKey:@"_sign"];
    NSLog(@"%@",self.manager);
    [ self.manager zj_GET:searchAPI withParams:params successComplete:^(id responseObject ) {
        if (responseObject !=nil && [responseObject isKindOfClass:[NSDictionary class]]) {
            if ([[responseObject valueForKey:@"returncode"] intValue] == 0) {
                RLMRealm * realm = [RLMRealm defaultRealm];
                NSLog(@"数据库 %@",realm);
                NSDictionary * dic = [responseObject valueForKey:@"result"];
                NSError *error;
            BOOL yes =    [realm transactionWithBlock:^{
                [SearchResult createOrUpdateInRealm:realm withValue:dic];
                } error:&error];
                if (yes) {
                    self.arrData = [Hitlist objectsWhere:@"type == %@",@"article"];
                    NSLog(@"%@",self.arrData);
                }
            }
        }
    } failureComplete:^(id error) {
    } isShowHUD:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
