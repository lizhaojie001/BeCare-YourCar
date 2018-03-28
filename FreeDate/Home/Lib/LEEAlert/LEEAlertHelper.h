#ifndef LEEAlertHelper_h
#define LEEAlertHelper_h
FOUNDATION_EXPORT double LEEAlertVersionNumber;
FOUNDATION_EXPORT const unsigned char LEEAlertVersionString[];
@class LEEAlert , LEEAlertConfig , LEEAlertConfigModel , LEEAlertWindow , LEEAction , LEEItem , LEECustomView;
typedef NS_ENUM(NSInteger, LEEScreenOrientationType) {
    LEEScreenOrientationTypeHorizontal,
    LEEScreenOrientationTypeVertical
};
typedef NS_ENUM(NSInteger, LEEAlertType) {
    LEEAlertTypeAlert,
    LEEAlertTypeActionSheet
};
typedef NS_ENUM(NSInteger, LEEActionType) {
    LEEActionTypeDefault,
    LEEActionTypeCancel,
    LEEActionTypeDestructive
};
typedef NS_OPTIONS(NSInteger, LEEActionBorderPosition) {
    LEEActionBorderPositionTop      = 1 << 0,
    LEEActionBorderPositionBottom   = 1 << 1,
    LEEActionBorderPositionLeft     = 1 << 2,
    LEEActionBorderPositionRight    = 1 << 3
};
typedef NS_ENUM(NSInteger, LEEItemType) {
    LEEItemTypeTitle,
    LEEItemTypeContent,
    LEEItemTypeTextField,
    LEEItemTypeCustomView,
};
typedef NS_ENUM(NSInteger, LEECustomViewPositionType) {
    LEECustomViewPositionTypeCenter,
    LEECustomViewPositionTypeLeft,
    LEECustomViewPositionTypeRight
};
typedef NS_OPTIONS(NSInteger, LEEAnimationStyle) {
    LEEAnimationStyleOrientationNone    = 1 << 0,
    LEEAnimationStyleOrientationTop     = 1 << 1,
    LEEAnimationStyleOrientationBottom  = 1 << 2,
    LEEAnimationStyleOrientationLeft    = 1 << 3,
    LEEAnimationStyleOrientationRight   = 1 << 4,
    LEEAnimationStyleFade               = 1 << 12,
    LEEAnimationStyleZoomEnlarge        = 1 << 24,
    LEEAnimationStyleZoomShrink         = 2 << 24,
};
typedef LEEAlertConfigModel *(^LEEConfig)();
typedef LEEAlertConfigModel *(^LEEConfigToBool)(BOOL is);
typedef LEEAlertConfigModel *(^LEEConfigToInteger)(NSInteger number);
typedef LEEAlertConfigModel *(^LEEConfigToFloat)(CGFloat number);
typedef LEEAlertConfigModel *(^LEEConfigToString)(NSString *str);
typedef LEEAlertConfigModel *(^LEEConfigToView)(UIView *view);
typedef LEEAlertConfigModel *(^LEEConfigToColor)(UIColor *color);
typedef LEEAlertConfigModel *(^LEEConfigToEdgeInsets)(UIEdgeInsets insets);
typedef LEEAlertConfigModel *(^LEEConfigToAnimationStyle)(LEEAnimationStyle style);
typedef LEEAlertConfigModel *(^LEEConfigToBlurEffectStyle)(UIBlurEffectStyle style);
typedef LEEAlertConfigModel *(^LEEConfigToInterfaceOrientationMask)(UIInterfaceOrientationMask);
typedef LEEAlertConfigModel *(^LEEConfigToFloatBlock)(CGFloat(^)(LEEScreenOrientationType type));
typedef LEEAlertConfigModel *(^LEEConfigToAction)(void(^)(LEEAction *action));
typedef LEEAlertConfigModel *(^LEEConfigToCustomView)(void(^)(LEECustomView *custom));
typedef LEEAlertConfigModel *(^LEEConfigToStringAndBlock)(NSString *str , void (^)());
typedef LEEAlertConfigModel *(^LEEConfigToConfigLabel)(void(^)(UILabel *label));
typedef LEEAlertConfigModel *(^LEEConfigToConfigTextField)(void(^)(UITextField *textField));
typedef LEEAlertConfigModel *(^LEEConfigToItem)(void(^)(LEEItem *item));
typedef LEEAlertConfigModel *(^LEEConfigToBlockAndBlock)(void(^)(void (^animatingBlock)() , void (^animatedBlock)()));
#endif 
