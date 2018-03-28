#import <Realm/Realm.h>
@interface Article_hitlist_data : RLMObject
@property NSInteger  replyCount;
@property NSString * date;
@property  NSString * class_name;
@property NSString * brandRelation;
@property NSNumber <RLMInt> *kind;
@property NSNumber<RLMInt> * authorId;
@property  NSInteger  id;
@property  NSString * author;
@property  NSString * title;
@property  NSNumber<RLMInt> * area;
@property  NSNumber<RLMInt> * province;
@property  (nonatomic ) NSString * AppImg;
@property  NSString * SecondCoverImg;
@property  NSInteger   global_id;
@property  NSString * picUrls;
@property  NSString * seriesRelation;
@property  NSString * ThirdCoverImg;
@property  BOOL IsGraphicArticle;
@property  NSString * url;
@property  NSString * specRelation;
@property  NSNumber <RLMInt> * class1;
@property  NSNumber <RLMInt> * class2;
@property NSString * classUrl;
@property NSInteger rank_score_a;
@property NSInteger rank_score_c;
@property NSInteger rank_score_b;
@property NSString * FirstCoverImg;
@property (readonly) RLMLinkingObjects *owners;
 @end
RLM_ARRAY_TYPE(Article_hitlist_data)
