#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <AVUser.h>
@interface ZJUser : NSObject
@property (nonatomic,strong) AVUser * user;
@property (nonatomic,strong) NSString *  avatar_large;
@property (nonatomic,strong) NSString *  screen_name;
single_interface(ZJUser)
@end
