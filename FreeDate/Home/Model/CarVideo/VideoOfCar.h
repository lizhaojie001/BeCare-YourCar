#import <Realm/Realm.h>
#import "VideoOfCar_copieslist.h"
@interface VideoOfCar : RLMObject
@property  NSInteger  status;
@property NSString * sessionid;
@property NSString *vtag;
@property NSString*img;
@property NSString * mid;
@property NSInteger   mt;
@property RLMArray<VideoOfCar_copieslist*><VideoOfCar_copieslist> *copieslist;
@end
RLM_ARRAY_TYPE(VideoOfCar)
