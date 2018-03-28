#import "nswyAboutController.h"
@interface nswyAboutController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
@implementation nswyAboutController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"에 관", nil);
    self.textView.text = NSLocalizedString(@"상세히", nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
