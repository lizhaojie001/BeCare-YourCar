#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LEEAlertHelper.h"
@interface LEEAlert : NSObject
+ (LEEAlertConfig *)alert;
+ (LEEAlertConfig *)actionsheet;
+ (LEEAlertWindow *)getAlertWindow;
+ (void)configMainWindow:(UIWindow *)window;
+ (void)closeWithCompletionBlock:(void (^)())completionBlock;
@end
@interface LEEAlertConfigModel : NSObject
@property (nonatomic , copy , readonly ) LEEConfigToString LeeTitle;
@property (nonatomic , copy , readonly ) LEEConfigToString LeeContent;
@property (nonatomic , copy , readonly ) LEEConfigToView LeeCustomView;
@property (nonatomic , copy , readonly ) LEEConfigToEdgeInsets LeeHeaderInsets;
@property (nonatomic , copy , readonly ) LEEConfigToEdgeInsets LeeItemInsets;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeMaxWidth;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeMaxHeight;
@property (nonatomic , copy , readonly ) LEEConfigToFloatBlock LeeConfigMaxWidth;
@property (nonatomic , copy , readonly ) LEEConfigToFloatBlock LeeConfigMaxHeight;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeCornerRadius;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeShadowOpacity;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeOpenAnimationDuration;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeCloseAnimationDuration;
@property (nonatomic , copy , readonly ) LEEConfigToColor LeeHeaderColor;
@property (nonatomic , copy , readonly ) LEEConfigToColor LeeBackGroundColor;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeBackgroundStyleTranslucent;
@property (nonatomic , copy , readonly ) LEEConfigToBlurEffectStyle LeeBackgroundStyleBlur;
@property (nonatomic , copy , readonly ) LEEConfigToBool LeeClickHeaderClose;
@property (nonatomic , copy , readonly ) LEEConfigToBool LeeClickBackgroundClose;
@property (nonatomic , copy , readonly ) LEEConfigToBool LeeQueue;
@property (nonatomic , copy , readonly ) LEEConfigToInteger LeePriority;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeWindowLevel;
@property (nonatomic , copy , readonly ) LEEConfigToBool LeeShouldAutorotate;
@property (nonatomic , copy , readonly ) LEEConfigToInterfaceOrientationMask LeeSupportedInterfaceOrientations;
@property (nonatomic , copy , readonly ) LEEConfigToAnimationStyle LeeOpenAnimationStyle;
@property (nonatomic , copy , readonly ) LEEConfigToAnimationStyle LeeCloseAnimationStyle;
@property (nonatomic , copy , readonly ) LEEConfig LeeShow;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeActionSheetCancelActionSpaceWidth;
@property (nonatomic , copy , readonly ) LEEConfigToColor LeeActionSheetCancelActionSpaceColor;
@property (nonatomic , copy , readonly ) LEEConfigToFloat LeeActionSheetBottomMargin;
@end
@interface LEEItem : NSObject
@property (nonatomic , assign ) LEEItemType type;
@property (nonatomic , assign ) UIEdgeInsets insets;
@property (nonatomic , copy ) void (^block)(id view);
- (void)update;
@end
@interface LEEAction : NSObject
@property (nonatomic , assign ) LEEActionType type;
@property (nonatomic , strong ) NSString *title;
@property (nonatomic , strong ) NSString *highlight;
@property (nonatomic , strong ) NSAttributedString *attributedTitle;
@property (nonatomic , strong ) NSAttributedString *attributedHighlight;
@property (nonatomic , strong ) UIFont *font;
@property (nonatomic , strong ) UIColor *titleColor;
@property (nonatomic , strong ) UIColor *highlightColor;
@property (nonatomic , strong ) UIColor *backgroundColor;
@property (nonatomic , strong ) UIColor *backgroundHighlightColor;
@property (nonatomic , strong ) UIImage *image;
@property (nonatomic , strong ) UIImage *highlightImage;
@property (nonatomic , assign ) UIEdgeInsets insets;
@property (nonatomic , assign ) UIEdgeInsets imageEdgeInsets;
@property (nonatomic , assign ) UIEdgeInsets titleEdgeInsets;
@property (nonatomic , assign ) CGFloat cornerRadius;
@property (nonatomic , assign ) CGFloat height;
@property (nonatomic , assign ) CGFloat borderWidth;
@property (nonatomic , strong ) UIColor *borderColor;
@property (nonatomic , assign ) LEEActionBorderPosition borderPosition;
@property (nonatomic , assign ) BOOL isClickNotClose;
@property (nonatomic , copy ) void (^clickBlock)();
- (void)update;
@end
@interface LEECustomView : NSObject
@property (nonatomic , strong ) UIView *view;
@property (nonatomic , assign ) LEECustomViewPositionType positionType;
@property (nonatomic , assign ) BOOL isAutoWidth;
@end
@interface LEEAlertConfig : NSObject
@property (nonatomic , strong ) LEEAlertConfigModel *config;
@property (nonatomic , assign ) LEEAlertType type;
@end
@interface LEEAlertWindow : UIWindow @end
@interface LEEBaseViewController : UIViewController @end
@interface LEEAlertViewController : LEEBaseViewController @end
@interface LEEActionSheetViewController : LEEBaseViewController @end
