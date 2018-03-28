#import <UIKit/UIKit.h>
typedef enum {
    M13ProgressViewActionNone,
    M13ProgressViewActionSuccess,
    M13ProgressViewActionFailure
} M13ProgressViewAction;
@interface M13ProgressView : UIView
@property (nonatomic, retain) UIColor *primaryColor;
@property (nonatomic, retain) UIColor *secondaryColor;
@property (nonatomic, assign) BOOL indeterminate;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, readonly) CGFloat progress;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)performAction:(M13ProgressViewAction)action animated:(BOOL)animated;
@end
