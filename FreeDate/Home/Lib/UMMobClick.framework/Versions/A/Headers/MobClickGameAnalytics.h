@interface MobClickGameAnalytics : NSObject
#pragma mark - account function
+ (void)profileSignInWithPUID:(NSString *)puid;
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider;
+ (void)profileSignOff;
#pragma mark GameLevel methods
+ (void)setUserLevelId:(int)level;
+ (void)startLevel:(NSString *)level;
+ (void)finishLevel:(NSString *)level;
+ (void)failLevel:(NSString *)level;
#pragma mark -
#pragma mark Pay methods
+ (void)exchange:(NSString *)orderId currencyAmount:(double)currencyAmount currencyType:(NSString *)currencyType virtualCurrencyAmount:(double)virtualAmount paychannel:(int)channel;
+ (void)pay:(double)cash source:(int)source coin:(double)coin;
+ (void)pay:(double)cash source:(int)source item:(NSString *)item amount:(int)amount price:(double)price;
#pragma mark -
#pragma mark Buy methods
+ (void)buy:(NSString *)item amount:(int)amount price:(double)price;
#pragma mark -
#pragma mark Use methods
+ (void)use:(NSString *)item amount:(int)amount price:(double)price;
#pragma mark -
#pragma mark Bonus methods
+ (void)bonus:(double)coin source:(int)source;
+ (void)bonus:(NSString *)item amount:(int)amount price:(double)price source:(int)source;
#pragma mark DEPRECATED
+ (void)setUserLevel:(NSString *)level;
+ (void)setUserID:(NSString *)userId sex:(int)sex age:(int)age platform:(NSString *)platform;
@end
