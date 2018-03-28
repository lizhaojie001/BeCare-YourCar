//
//  UIView+Layout.h
//  FreeDate
//
//  Created by macbook pro on 2018/3/23.
//  Copyright © 2018年 macbook pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)
//监测视图及子视图layout布局是否合理

-(void)testAmbiguity;

/**
 所有约束

 @return 
 */
-(NSArray *)zj_allConstains;

@end
