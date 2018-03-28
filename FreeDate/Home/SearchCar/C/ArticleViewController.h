#import <UIKit/UIKit.h>
@interface ArticleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) NSInteger  type;
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property (nonatomic,strong) UITableView * tableView;
@end
