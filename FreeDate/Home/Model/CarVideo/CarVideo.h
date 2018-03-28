#import <Realm/Realm.h>
@interface CarVideo : RLMObject
@property NSInteger id;
@property NSString *title;
@property NSInteger mediatype;
@property NSString *medianame;
@property NSString *thirdsource;
@property NSString *content;
@property NSString *time;
@property NSString *imgurl;
@property NSString *replycount;
@property NSString *lasttime;
@property NSString *session_id;
@property NSNumber<RLMInt> *iscurplay;
@property NSString *likecount;
@property NSString *videoid;
@property NSString *playtime;
@property NSString *playcount;
@property NSString *authname;
@property NSInteger ident;
@property NSString *headimg;
@property NSString *tabname;
@end
RLM_ARRAY_TYPE(CarVideo)
