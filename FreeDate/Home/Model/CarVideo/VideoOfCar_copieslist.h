#import <Realm/Realm.h>
@interface VideoOfCar_copieslist : RLMObject
@property NSInteger quality;
@property NSString *desp;
@property NSString * playurl;
 @property (readonly) RLMLinkingObjects *owners;
@end
RLM_ARRAY_TYPE(VideoOfCar_copieslist)
