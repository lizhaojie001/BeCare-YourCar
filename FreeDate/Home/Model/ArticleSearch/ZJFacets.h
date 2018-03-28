//
//  ZJFacets.h
//  FreeDate
//
//  Created by macbook pro on 2018/3/25.
//Copyright © 2018年 macbook pro. All rights reserved.
//

#import <Realm/Realm.h>
#import "ZJArtilteSort.h"
@interface ZJFacets : RLMObject
@property NSString * name;
@property RLMArray <ZJArtilteSort *> <ZJArtilteSort> *  sortlist;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZJFacets *><ZJFacets>
RLM_ARRAY_TYPE(ZJFacets)
