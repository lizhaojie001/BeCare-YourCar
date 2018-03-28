#import "ArticleSearch.h"
@implementation ArticleSearch
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"searchWord":@"文章所搜结果"};
}
+(NSString *)primaryKey{
    return @"searchWord";
}
@end
