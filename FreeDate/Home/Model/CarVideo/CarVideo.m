#import "EditVideos.h"
#import "CarVideoList.h"
@implementation CarVideo
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"ident":@0};
}
+(NSString *)primaryKey{
    return @"id";
}
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:CarVideoList.class propertyName:@"data"] };
}
@end
