#import <Foundation/Foundation.h>
typedef NSString * MobClickSocialTypeString;
extern MobClickSocialTypeString const MobClickSocialTypeSina;                
extern MobClickSocialTypeString const MobClickSocialTypeTencent;             
extern MobClickSocialTypeString const MobClickSocialTypeRenren;              
extern MobClickSocialTypeString const MobClickSocialTypeQzone;               
extern MobClickSocialTypeString const MobClickSocialTypeRenren;              
extern MobClickSocialTypeString const MobClickSocialTypeDouban;              
extern MobClickSocialTypeString const MobClickSocialTypeWxsesion;            
extern MobClickSocialTypeString const MobClickSocialTypeWxtimeline;          
extern MobClickSocialTypeString const MobClickSocialTypeHuaban;              
extern MobClickSocialTypeString const MobClickSocialTypeKaixin;              
extern MobClickSocialTypeString const MobClickSocialTypeFacebook;            
extern MobClickSocialTypeString const MobClickSocialTypeTwitter;             
extern MobClickSocialTypeString const MobClickSocialTypeInstagram;           
extern MobClickSocialTypeString const MobClickSocialTypeFlickr;              
extern MobClickSocialTypeString const MobClickSocialTypeQQ;                  
extern MobClickSocialTypeString const MobClickSocialTypeWxfavorite;          
extern MobClickSocialTypeString const MobClickSocialTypeLwsession;           
extern MobClickSocialTypeString const MobClickSocialTypeLwtimeline;          
extern MobClickSocialTypeString const MobClickSocialTypeYxsession;           
extern MobClickSocialTypeString const MobClickSocialTypeYxtimeline;          
@interface MobClickSocialWeibo : NSObject
@property (nonatomic, copy) NSString *platformType;
@property (nonatomic, copy) NSString *weiboId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) NSDictionary *param;
-(id)initWithPlatformType:(MobClickSocialTypeString)platformType weiboId:(NSString *)weiboId usid:(NSString *)usid param:(NSDictionary *)param;
@end
typedef void (^MobClickSocialAnalyticsCompletion)(NSDictionary * response, NSError *error);
@interface MobClickSocialAnalytics : NSObject
+(void)postWeiboCounts:(NSArray *)weibos appKey:(NSString *)appKey topic:(NSString *)topic completion:(MobClickSocialAnalyticsCompletion)completion;
@end
