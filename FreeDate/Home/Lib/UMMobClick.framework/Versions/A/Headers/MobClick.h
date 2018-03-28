#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
typedef void(^CallbackBlock)();
typedef enum {
    REALTIME = 0,       
    BATCH = 1,          
    SEND_INTERVAL = 6,  
    SMART_POLICY = 8,
} ReportPolicy;
typedef NS_ENUM (NSUInteger, eScenarioType)
{
    E_UM_NORMAL = 0,    
    E_UM_GAME = 1,      
};
#define UMConfigInstance [UMAnalyticsConfig sharedInstance]
@interface UMAnalyticsConfig : NSObject
@property(nonatomic, copy) NSString *appKey;
@property(nonatomic, copy) NSString *secret;
@property(nonatomic, copy) NSString *channelId;
@property(nonatomic) BOOL  bCrashReportEnabled;
@property(nonatomic) ReportPolicy   ePolicy;
@property(nonatomic) eScenarioType  eSType;
+ (instancetype)sharedInstance;
@end
@class CLLocation;
@interface MobClick : NSObject <UIAlertViewDelegate>
#pragma mark basics
+ (void) startWithConfigure:(UMAnalyticsConfig *)configure;
+ (void)setAppVersion:(NSString *)appVersion;
+ (void)setCrashReportEnabled:(BOOL)value;
+ (void)setLogEnabled:(BOOL)value;
+ (void)setEncryptEnabled:(BOOL)value;
+ (void)setLogSendInterval:(double)second;
#pragma mark event logs
+ (void)logPageView:(NSString *)pageName seconds:(int)seconds;
+ (void)beginLogPageView:(NSString *)pageName;
+ (void)endLogPageView:(NSString *)pageName;
+ (void)event:(NSArray *)keyPath value:(int)value label:(NSString *)label;
+ (void)event:(NSString *)eventId; 
+ (void)event:(NSString *)eventId label:(NSString *)label; 
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(int)number;
+ (void)beginEvent:(NSString *)eventId;
+ (void)endEvent:(NSString *)eventId;
+ (void)beginEvent:(NSString *)eventId label:(NSString *)label;
+ (void)endEvent:(NSString *)eventId label:(NSString *)label;
+ (void)beginEvent:(NSString *)eventId primarykey :(NSString *)keyName attributes:(NSDictionary *)attributes;
+ (void)endEvent:(NSString *)eventId primarykey:(NSString *)keyName;
+ (void)event:(NSString *)eventId durations:(int)millisecond;
+ (void)event:(NSString *)eventId label:(NSString *)label durations:(int)millisecond;
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes durations:(int)millisecond;
#pragma mark - user methods
+ (void)profileSignInWithPUID:(NSString *)puid;
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider;
+ (void)profileSignOff;
+ (void)setLatitude:(double)latitude longitude:(double)longitude;
+ (void)setLocation:(CLLocation *)location;
+ (BOOL)isJailbroken;
+ (BOOL)isPirated;
#pragma mark DEPRECATED
+ (void)startSession:(NSNotification *)notification;
+ (void)setCrashCBBlock:(CallbackBlock)cbBlock;
@end
