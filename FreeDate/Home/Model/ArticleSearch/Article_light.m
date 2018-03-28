#import "Article_light.h"
#import "Article_hitlist.h"
@implementation Article_light
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:Article_hitlist.class propertyName:@"light"] };
}
@end
