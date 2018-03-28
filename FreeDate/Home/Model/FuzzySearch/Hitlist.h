#import <Realm/Realm.h>
#import "Hitlist_Data.h"
@interface Hitlist : RLMObject
@property NSString * id;
@property NSString * type;
@property Hitlist_Data * data;
@property (readonly) RLMLinkingObjects *owners;
@end
RLM_ARRAY_TYPE(Hitlist)
