#import "UIScreen+hook.h"
#import <objc/runtime.h>
@implementation UIScreen (hook)
+(void)load{
        Method method1 =  class_getInstanceMethod([self class], @selector(snapshotViewAfterScreenUpdates:));
    Method m2 = class_getInstanceMethod([self class], @selector(zj_snapshotViewAfterScreenUpdates:));
        method_exchangeImplementations(method1, m2);
}
-(UIView *)zj_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates{
    ZJlogFunction;
    return  [self zj_snapshotViewAfterScreenUpdates:afterUpdates];
}
@end
