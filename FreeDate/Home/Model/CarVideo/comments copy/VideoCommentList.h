#import <Realm/Realm.h>
@interface VideoCommentList : RLMObject
@property NSInteger id;
@property NSInteger floor;
@property  NSInteger nameid;
@property NSString *name;
@property NSString * namepic;
@property NSString * time;
@property NSString * content;
@property BOOL isadd;
@property NSInteger sourcenameid;
@property NSString * sourcename;
@property NSString *sourcecontent;
@property NSInteger issocialize;
@property NSInteger iscarowner;
@property NSString * carname;
@property NSInteger imageid;
@property NSString *smallimageurl;
@property NSString *bigimageurl;
@property NSInteger upcount;
@property NSInteger sourceupcount;
@property NSInteger isbusinessauth;
@property NSInteger isanchor;
@property NSInteger sourceisanchor;
@property NSString * blogurl;
@property BOOL showchat;
@property NSInteger chatcount;
@property NSString * radioid;
@property NSString *isbigv;
@property NSInteger  carownerlevels;
@property NSString *carownerlevelsimg;
@end
RLM_ARRAY_TYPE(VideoCommentList)
