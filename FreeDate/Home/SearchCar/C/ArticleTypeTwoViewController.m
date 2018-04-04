#import "ArticleTypeTwoViewController.h"
#import "ArticleCell.h"
#import "ArticleSearch.h"
#import "CarViewController.h"
@interface ArticleTypeTwoViewController()
@property RLMResults   * data;
@end
@implementation ArticleTypeTwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    return;
    [self firstComein];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ArticleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ArticleCell class])];
    MJWeakSelf
    NSArray * images = @[  [UIImage imageNamed:@"car1"] ,[UIImage imageNamed:@"car2"],[UIImage imageNamed:@"car3"],[UIImage imageNamed:@"car4"],[UIImage imageNamed:@"car5"],[UIImage imageNamed:@"car6"]];
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [weakSelf pullUpRefresh];
    }];
    [footer setImages:images  forState:MJRefreshStateRefreshing];
    [footer setImages:images forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
}
-(void)pullUpRefresh{
    MJWeakSelf
    NSString * baseURL = @"https://sou2.api.autohome.com.cn/wrap/v3/article/search";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSInteger  offset = self.data.count;
    [params setValue:@"app" forKey:@"_appid"];
    [params setValue:@(3) forKey:@"class"];
    [params setValue:@0 forKey:@"modify"];
    [params setValue:@(offset) forKey:@"offset"];
    [params setValue:self.title forKey:@"q"];
    [params setValue:@1 forKey:@"s"];
    [params setValue:@40 forKey:@"size"];
    [params setValue:@"app" forKey:@"tm"];
    [params setValue:@"content" forKey:@"ignores"]; 
    [params setValue:@"59f31de98a37231f89fa5c469e96f69fcca90cf4" forKey:@"_sign"];
    [self.manager zj_GET:baseURL withParams:params successComplete:^(id response) {
        if (response !=nil && [response isKindOfClass:[NSDictionary class]]) {
            if ([[response valueForKey:@"returncode"] intValue] == 0) {
                NSDictionary * hitlist = [response valueForKey:@"result"]  ;
                RLMRealm * realm =[RLMRealm defaultRealm];
                NSError * error;
                NSInteger count =[[hitlist valueForKey:@"hitlist"]  count];
                if (  count < 40) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                BOOL is =    [realm transactionWithBlock:^{
                    [ArticleSearch  createOrUpdateInRealm:realm withValue:hitlist];
                } error:&error];
                if (is) {
                    self.data = [Article_hitlist_data objectsWhere:@" class_name == %@",@"试驾评测"];
                    [self.tableView.mj_footer endRefreshing];
                    [self.tableView reloadData];
                    NSLog(@"存入成功");
                }
            }
        }
    } failureComplete:^(id error) {
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    } isShowHUD:YES];
}
-(void)firstComein{
    NSString * baseURL = @"https://sou2.api.autohome.com.cn/wrap/v3/article/search";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@"app" forKey:@"_appid"];
    [params setValue:@(3) forKey:@"class"];
    [params setValue:@0 forKey:@"modify"];
    [params setValue:@0 forKey:@"offset"];
    [params setValue:self.title forKey:@"q"];
    [params setValue:@1 forKey:@"s"];
    [params setValue:@40 forKey:@"size"];
    [params setValue:@"app" forKey:@"tm"];
    [params setValue:@"content" forKey:@"ignores"]; 
    [params setValue:@"59f31de98a37231f89fa5c469e96f69fcca90cf4" forKey:@"_sign"];
    [self.manager zj_GET:baseURL withParams:params successComplete:^(id response) {
        if (response !=nil && [response isKindOfClass:[NSDictionary class]]) {
            if ([[response valueForKey:@"returncode"] intValue] == 0) {
                NSDictionary * hitlist = [response valueForKey:@"result"]  ;
                RLMRealm * realm =[RLMRealm defaultRealm];
                NSError * error;
                if (![[hitlist valueForKey:@"hitlist"]  count]) {
                    return ;
                }
                BOOL is =    [realm transactionWithBlock:^{
                    [ArticleSearch  createOrUpdateInRealm:realm withValue:hitlist];
                } error:&error];
                if (is) {
                    self.data = [Article_hitlist_data objectsWhere:@" class_name == %@",@"试驾评测"];
                    [self.tableView reloadData];
                    NSLog(@"存入成功");
                }
            }
        }
    } failureComplete:^(id error) {
    } isShowHUD:YES];
}
#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
       self.tableView.mj_footer.hidden = self.data.count == 0;
    return   self.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ArticleCell class]) forIndexPath:indexPath];
    cell.data = [self.data objectAtIndex:indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Article_hitlist_data * data = [self.data objectAtIndex:indexPath.section];
    CarViewController * vc = [[CarViewController alloc]initWithNibName:nil bundle:nil];
    vc.wbnet = data.url;
    vc.title = data.title;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
