#import "M13ProgressView.h"
@implementation M13ProgressView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    _progress = progress;
}
- (void)performAction:(M13ProgressViewAction)action animated:(BOOL)animated
{
}
@end
