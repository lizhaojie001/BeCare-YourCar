#import "Article_hitlist.h"
#import "ArticleSearch.h"

@implementation Article_hitlist
+(NSString *)primaryKey{
    return @"id";
}
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:ArticleSearch.class propertyName:@"hitlist"] };
}
@end
