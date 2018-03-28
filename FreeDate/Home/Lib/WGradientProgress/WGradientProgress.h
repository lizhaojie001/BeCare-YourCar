#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, WProgressPos)
{
    WProgressPosDown = 0,        
    WProgressPosUp               
};
@interface WGradientProgress : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) WProgressPos position;
+ (WGradientProgress *)sharedInstance;
- (void)showOnParent:(UIView *)parentView;
- (void)showOnParent:(UIView *)parentView position:(WProgressPos)pos;
- (void)hide;
@end
