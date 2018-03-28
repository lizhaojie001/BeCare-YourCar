#import "nswyCategaryCell.h"
@implementation nswyCategaryCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:self.contentView.bounds];
        self.label.opaque =NO;
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [[self class] defaultFont];
        [self.contentView addSubview:self.label];
    }
    return self;
}
+ (UIFont *)defaultFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
+ (CGSize)sizeForContentString:(NSString *)s forMaxWidth:(CGFloat)maxWidth{
    CGSize maxSize = CGSizeMake(maxWidth, 0);
  NSStringDrawingOptions opt =  NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary * attributes = @{NSFontAttributeName : [self defaultFont],NSParagraphStyleAttributeName:style};
    CGRect rect = [s boundingRectWithSize:maxSize options:opt attributes:attributes context:nil];
    return rect.size;
}
-(NSString *)text{
    return self.label.text;
}
-(void)setText:(NSString *)text{
    self.label.text = text;
    CGRect newLabelFrame = self.label.frame;
    CGRect newContentFrame = self.contentView.frame;
    CGSize textSize = [[self class] sizeForContentString:text forMaxWidth:_maxWidth];
    newLabelFrame.size = textSize;
    newContentFrame.size = textSize;
    self.label.frame = newLabelFrame;
    self.contentView.frame = newContentFrame;
}
-(CGSize)size{
  return   self.label.frame.size;
}
@end
