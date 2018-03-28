#import "ZJUser.h"
@implementation ZJUser
single_implementation(ZJUser)
-(AVUser *)user{
    return  [AVUser currentUser ];
}
@end
