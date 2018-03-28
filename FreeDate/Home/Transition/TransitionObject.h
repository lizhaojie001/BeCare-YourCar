#import <Foundation/Foundation.h>
@interface TransitionObject : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isPrisenting;
@property (nonatomic) CGRect frame;
@end
