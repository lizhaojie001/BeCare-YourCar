#import "M13ProgressView.h"
typedef enum {
    M13ProgressViewStripedBarCornerTypeSquare,
    M13ProgressViewStripedBarCornerTypeRounded,
    M13ProgressViewStripedBarCornerTypeCircle
} M13ProgressViewStripedBarCornerType;
@interface M13ProgressViewStripedBar : M13ProgressView
@property (nonatomic, assign) M13ProgressViewStripedBarCornerType cornerType;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat stripeWidth;
@property (nonatomic, assign) BOOL animateStripes;
@property (nonatomic, assign) BOOL showStripes;
@property (nonatomic, retain) UIColor *stripeColor;
@property (nonatomic, assign) CGFloat borderWidth;
@end
