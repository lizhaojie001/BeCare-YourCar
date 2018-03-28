#import "Hitlist_Data.h"
#import "Hitlist.h"
@implementation Hitlist_Data
+(NSString *)primaryKey{
    return @"id";
}
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"IsGraphicArticle":@(YES)};
}
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:Hitlist.class propertyName:@"data"] };
}
@end
