#import <Realm/Realm.h>
#import "Article_hitlist_data.h"
#import "Article_light.h"
@interface Article_hitlist : RLMObject
@property NSString *  id;
@property Article_hitlist_data * data;
@property NSInteger score;
@property NSString * type;
@property Article_light * light;
@end
RLM_ARRAY_TYPE(Article_hitlist)
