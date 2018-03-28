#import "VideoOfCar_copieslist.h"
#import "VideoOfCar.h"
@implementation VideoOfCar_copieslist
+(NSString *)primaryKey{
    return @"playurl";
}
+ (NSDictionary *)linkingObjectsProperties
{
    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:VideoOfCar.class propertyName:@"copieslist"] };
}
@end
