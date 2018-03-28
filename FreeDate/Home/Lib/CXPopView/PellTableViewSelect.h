#import <UIKit/UIKit.h>
@interface PellTableViewSelect : UIView
+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       images:(NSArray *)images
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate;
+ (void)hiden;
@end
