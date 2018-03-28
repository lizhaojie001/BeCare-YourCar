//
//  ZJArtilteSort.h
//  FreeDate
//
//  Created by macbook pro on 2018/3/25.
//Copyright © 2018年 macbook pro. All rights reserved.
//

#import <Realm/Realm.h>

@interface ZJArtilteSort : RLMObject
@property NSInteger num;
@property NSString * name;
@property NSString * type;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ZJArtilteSort *><ZJArtilteSort>
RLM_ARRAY_TYPE(ZJArtilteSort)
