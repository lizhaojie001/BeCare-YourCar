#import "nswySettingController.h"
#import "LoginViewController.h"
#import <SVProgressHUD.h>
#import "nswyAboutController.h"
#import "CarViewController.h"
@interface nswySettingController ()
@end
@implementation nswySettingController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"설치", nil);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = NSLocalizedString(@"에 관", nil);
            break;
        default:
             cell.textLabel.text = NSLocalizedString(@"출구", nil);
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
__weak typeof(self) weakSelf = self;
    if (indexPath.section) {
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:1.0];
        if([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[LoginViewController class]]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [AVUser logOut];
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Login"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }];
            });
        }else{
            [AVUser logOut];
            [[UIApplication sharedApplication].keyWindow setRootViewController:[[LoginViewController alloc]init]];[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Login"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }else{
        CarViewController * about = [[CarViewController alloc]initWithNibName:nil bundle:nil];
        about.wbnet = NSLocalizedString(@"상", nil);
        [self.navigationController pushViewController:about animated:YES];
    }
}
@end
