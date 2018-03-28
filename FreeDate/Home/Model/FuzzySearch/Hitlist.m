#import "Hitlist.h"
#import "SearchResult.h"
@implementation Hitlist
+(NSString *)primaryKey{
    return @"id";
}
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:SearchResult.class propertyName:@"hitlist"] };
}
@end
