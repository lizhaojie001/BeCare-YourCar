#import <Realm/Realm.h>
#import "CarVideo.h"
@interface CarVideoList : RLMObject
@property NSInteger cardtype;
@property NSString * scheme;
@property CarVideo* data;
 @property (readonly) RLMLinkingObjects *owners;
@end
RLM_ARRAY_TYPE(CarVideoList)
