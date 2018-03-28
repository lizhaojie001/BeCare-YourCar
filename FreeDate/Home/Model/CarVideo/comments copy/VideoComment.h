#import <Realm/Realm.h>
#import "VideoCommentList.h"
@interface VideoComment : RLMObject
@property BOOL isloadmore;
@property  NSString *pageid;
@property NSString *idlist;
@property NSInteger totalcount;
@property RLMArray<VideoCommentList*><VideoCommentList>* list;
@end
RLM_ARRAY_TYPE(VideoComment)
