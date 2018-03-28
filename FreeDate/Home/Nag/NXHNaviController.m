#import "NXHNaviController.h"
#import "UINavigationBar+Awesome.h"
@interface NXHNaviController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@end
@implementation NXHNaviController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate= self;
    CGRect rect = [UIScreen mainScreen].bounds;
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame= CGRectMake(0, 0, rect.size.width, 64);
        NSLog(@"%@",NSStringFromCGRect(gradientLayer.frame));
        gradientLayer.colors = @[ (__bridge id) [UIColor colorWithRed:243/255.0 green:150/255.0 blue:0/255.0 alpha:0.9f] .CGColor,(__bridge id) [UIColor colorWithRed:254/255.0 green:223/255.0 blue:0/255.0 alpha:0.9f].CGColor];
        gradientLayer.locations = @[@0.0, @0.75, @1];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
    [self.navigationBar lt_setBackgroundColor:ZJThemeColor];
}
+ (void)initialize
{
     [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]  setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { 
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left = [[UIBarButtonItem  alloc]initWithCustomView:btn];
        left.width = 60.0;
         viewController.navigationItem.leftBarButtonItem = left;
        viewController.hidesBottomBarWhenPushed = YES;
           }
    [super pushViewController:viewController animated:animated];
}
- (void)popToPre
{     
    [self popViewControllerAnimated:YES];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.viewControllers.count>1;
}
@end
