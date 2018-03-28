#import <UIKit/UIKit.h>
@interface nswyCategaryCell : UICollectionViewCell
@property (nonatomic,strong) UILabel * label;
@property (nonatomic,copy) NSString * text;
@property (nonatomic,assign) CGFloat maxWidth;
@property (nonatomic,assign) CGSize size;
+(CGSize)sizeForContentString:(NSString*)s forMaxWidth:(CGFloat)maxWidth;
@end
