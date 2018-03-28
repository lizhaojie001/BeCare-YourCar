#ifndef PathPlanningPanel_GlobalCommon_h
#define PathPlanningPanel_GlobalCommon_h
#define kSystemStatusBarHeight      20
#define kSystemToolbarHeight        44
#define KDeviceAbsoluteHeight       [UIScreen mainScreen] currentMode].size.height
#define kDeviceAbsoluteWidth        [[UIScreen mainScreen] currentMode].size.width
#define kDeviceWindowSize           [[UIScreen mainScreen] bounds].size
#define kDeviceWindowWidth          [[UIScreen mainScreen] bounds].size.width
#define kDeviceWindowHeight         [[UIScreen mainScreen] bounds].size.height
#define kDeviceAppNoStatusSize      [[UIScreen mainScreen] applicationFrame].size
#define kDeviceAppNoStatusWidth     [[UIScreen mainScreen] applicationFrame].size.width
#define kDeviceAppNoStatusHeight    [[UIScreen mainScreen] applicationFrame].size.height
#define Interface_Flag              (int)[UIDevice getDeviceOrientation]  
#define kIsDeviceLandscape          (Interface_Flag == 1)
#define kIsDevicePortrait           (Interface_Flag == 0)
typedef enum {
    DeviceTypePhone = 1 << 0,
    DeviceTypePad = 1 << 1
} DeviceType;
#define CurrentDeviceType() \
(isiPhone ? \
DeviceTypePhone : DeviceTypePad)
#define Device4Inch iPhone5
#define Device35Inch iPhone4
#define DeviceRetinaDisplay ISRETINA
#define DeviceOSVersion IOS_VERSION
#define IsIOS7orAbove IOS_7
#define IsIOS8orAbove  (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))
#define kRGBA(r, g, b, a) (RGBACOLOR(r,g,b,a))
#define kColorPatterImage(imageName) (IMAGECOLOR(imageName,IMAGEPATH_TYPE_1))
#define kImageNamed(x) (IMAGE(x,IMAGEPATH_TYPE_1))
#define kImageContentFileNamed(x)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(x) ofType:@"png"]]
#define WLocalizedString(myString) NSLocalizedString(myString, nil)
#endif
