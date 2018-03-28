#import <Realm/Realm.h>
#import "CarVideoList.h"
@interface EditVideos : RLMObject
@property BOOL isloadmore;
@property NSString*  pageid;
@property  RLMArray<CarVideoList*><CarVideoList>* list;
@end
RLM_ARRAY_TYPE(EditVideos)
