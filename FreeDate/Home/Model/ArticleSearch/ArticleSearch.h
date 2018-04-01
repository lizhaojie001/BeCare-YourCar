#import <Realm/Realm.h>
#import "Article_hitlist.h"
#import "ZJFacets.h"
@interface ArticleSearch : RLMObject
@property NSInteger rowcount;
@property RLMArray<Article_hitlist*><Article_hitlist> * hitlist;
@property NSString *  searchWord;
@property ZJFacets * facets;
 
@end
RLM_ARRAY_TYPE(ArticleSearch)
