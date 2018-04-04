#import <Realm/Realm.h>
#import "Article_hitlist.h"
#import "ZJFacets.h"
@interface ArticleSearch : RLMObject
@property NSInteger rowcount;

@property NSString *  searchWord;
@property ZJFacets * facets;
@property RLMArray<Article_hitlist*><Article_hitlist>* hitlist;
@end
RLM_ARRAY_TYPE(ArticleSearch)
