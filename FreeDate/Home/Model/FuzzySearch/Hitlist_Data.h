#import <Realm/Realm.h>
@interface Hitlist_Data : RLMObject
@property NSNumber<RLMInt> * replyCount;
@property NSString * SecondCoverImg;
@property NSNumber<RLMInt>  * global_id;
@property NSString * picUrls;
@property NSString * seriesRelation;
@property NSString * class_name;
@property NSString * date;
@property NSString * ThirdCoverImg;
@property BOOL IsGraphicArticle;
@property NSNumber<RLMInt>  * kind;
@property NSString * url;
@property NSNumber<RLMInt>  * authorId;
@property NSNumber<RLMInt> * id;
@property NSString * author;
@property NSString * title;
@property NSNumber<RLMInt>  * area;
@property NSString * specRelation;
@property NSNumber<RLMInt>  * class1;
@property NSNumber<RLMInt>  * class2;
@property NSString * classUrl;
@property NSNumber<RLMInt>  * province;
@property NSString * AppImg;
@property NSString * FirstCoverImg;
@property (readonly) RLMLinkingObjects *owners;
@end
RLM_ARRAY_TYPE(Hitlist_Data)
