#import "VideoComment.h"
@implementation VideoComment
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"isloadmore":@NO};
}
+(NSString *)primaryKey{
    return @"pageid";
}
@end
