#import "UIViewController+BarStyle.h"
#import <objc/runtime.h>
@implementation UIViewController (BarStyle)
+(void)load{
}
-(UIStatusBarStyle)zj_preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
