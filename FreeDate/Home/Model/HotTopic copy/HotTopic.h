#import <Realm/Realm.h>
@interface HotTopic : RLMObject
@property NSString * name;
@property NSString *matchword;
@property NSInteger type;
@property NSInteger from;
@property NSString * uri;
@end
RLM_ARRAY_TYPE(HotTopic)
