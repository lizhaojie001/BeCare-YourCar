#import <Realm/Realm.h>
#import "Hitlist.h"
@interface SearchResult : RLMObject
@property NSNumber<RLMInt> * rowcount;
@property NSNumber<RLMInt> *right_box_num;
@property NSString *matchword;
@property NSNumber<RLMInt> *type64;
@property NSString *matchwordid;
@property NSString *searchinfo;
@property NSString *hidden_reason;
@property NSString *_restype;
@property NSNumber<RLMInt> *type;
@property NSString *recommend;
@property NSNumber<RLMInt> *time;
@property NSString *_version;
@property NSNumber<RLMInt> *qType;
@property NSNumber<RLMInt> *left_box_num;
@property NSString *q;
@property NSString *box_version;
@property RLMArray <Hitlist *><Hitlist> *  hitlist;
@end
RLM_ARRAY_TYPE(SearchResult)
