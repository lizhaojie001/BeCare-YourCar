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

+(NSArray<NSString *> *)ignoredProperties{
    return @[@"type"];
}
//+ (NSDictionary *)linkingObjectsProperties
//{
//    return @{ @"owners": [RLMPropertyDescriptor descriptorWithClass:Article_hitlist.class propertyName:@"data"] };
//}
//-(NSString *)AppImg{
//    return [NSString stringWithFormat:@"https:%@",_AppImg];
//}

-(UIImageViewNumType)type{

    if ([self.AppImg isEqualToString:@"https:"]|| !self.AppImg.length) {
        return UIImageViewNumNone;
    }else if (self.FirstCoverImg.length){
        return UIImageViewNumThree;
    }else{
        return UIImageViewNumOne;
    }

}
@end

