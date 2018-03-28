//
//  UIView+Layout.m
//  FreeDate
//
//  Created by macbook pro on 2018/3/23.
//  Copyright © 2018年 macbook pro. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)
-(void)testAmbiguity{
    NSLog(@"<%@:0x%0x>: %@",[self.class description],(int)self,self.hasAmbiguousLayout?@"Ambiguous":@"UnAmbiguous");
    NSAssert(!self.hasAmbiguousLayout, @"%@ - 视图布局条件不足",self);
    for (UIView * v in self.subviews) {
        [v testAmbiguity];
    }
}
-(NSArray *)zj_allConstains{
    NSMutableArray * array = [NSMutableArray array];
    [array addObjectsFromArray:self.constraints];
    for (UIView * v  in self.subviews) {
        [array addObjectsFromArray:[v zj_allConstains]];
    }
    return array;
}
@end
