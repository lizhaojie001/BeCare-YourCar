#import <Realm/Realm.h>
@interface Article_light : RLMObject
@property NSString * content;
@property NSString * title;
@property (readonly) RLMLinkingObjects *owners;
@end
RLM_ARRAY_TYPE(Article_light)
