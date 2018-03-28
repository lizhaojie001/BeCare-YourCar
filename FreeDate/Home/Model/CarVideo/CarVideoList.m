#import "CarVideoList.h"
#import "EditVideos.h"
@implementation CarVideoList
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:EditVideos.class propertyName:@"list"] };
}
+(NSString *)primaryKey{
    return @"cardtype";
}
@end
