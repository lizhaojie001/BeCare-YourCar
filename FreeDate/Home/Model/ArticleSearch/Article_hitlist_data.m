#import "Article_hitlist_data.h"
#import "Article_hitlist.h"
@implementation Article_hitlist_data
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"IsGraphicArticle":@0,@"replyCount":@0};
}
+(NSString *)primaryKey{
    return @"id";
}
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:Article_hitlist.class propertyName:@"data"] };
}
-(NSString *)AppImg{
    return [NSString stringWithFormat:@"https:%@",_AppImg];
}
@end
