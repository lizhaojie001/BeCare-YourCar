#import <UIKit/UIKit.h>
#import "CarVideo.h"
@interface CarVideoCell : UITableViewCell
@property (nonatomic,strong) CarVideo * carvideo;
@property (weak, nonatomic) IBOutlet UIImageView *imgurl;
@end
