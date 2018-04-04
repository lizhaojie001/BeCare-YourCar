#import "UINavigationBar+Awesome.h"
#import "SwithViewController.h"
#import "nswyFollowViewController.h"
#import "nswyFollowCell.h"
#import "PYSearch.h"
#import "PYTempViewController.h"
#import "PellTableViewSelect.h"
#import <CoreText/CoreText.h>
#import "nswyCategaryController.h"
#import <MJRefresh/MJRefresh.h>
#import "SearchResult.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>
#import "nswySettingController.h"
#import "CarVideoCell.h"
#import <AFNetworking.h>
#import "EditVideos.h"
#import "nswyMVViewController.h"
#import "TransitionObject.h"
#import "ZBFallenBricksAnimator.h"
#import "YYFPSLabel.h"
#define video(a,b) [NSString stringWithFormat:@"https://61.240.128.76/news_v8.8.5/news/editvideos-pm1-sid%d-lid0-s%d-crv0.json",a,b]
@interface nswyFollowViewController ()<PYSearchViewControllerDelegate,UISearchBarDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UISearchBar * serachBar;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,assign) int n ;
@property (nonatomic,strong) UITableView * leftTableView;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer * gesture;
@property (strong,nonatomic ) UIView * V;
@property (nonatomic,assign) BOOL isRight;
@property (nonatomic,strong)RLMResults *results;
@property(nonatomic,strong)AFHTTPSessionManager * videoManager;
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,strong)AFHTTPSessionManager * KeywordManager;
@property (nonatomic,strong) NSArray * keyArr;
@property (nonatomic,strong) YYFPSLabel * fpsLabel;
@end
@implementation nswyFollowViewController
#pragma mark- lazy
-(AFHTTPSessionManager *)KeywordManager{
    if (!_KeywordManager) {
        NSURLSessionConfiguration *  defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultSessionConfiguration.timeoutIntervalForRequest = 5.0;
        _KeywordManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:defaultSessionConfiguration];
         _KeywordManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];

        _KeywordManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _KeywordManager.securityPolicy.allowInvalidCertificates = YES;
        _KeywordManager.securityPolicy.validatesDomainName = NO;
    }
    return _KeywordManager;
}
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        NSURLSessionConfiguration *  defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultSessionConfiguration.timeoutIntervalForRequest = 5.0;
        _manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:defaultSessionConfiguration];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _manager.securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy.validatesDomainName = NO;
    }
    return _manager;
}
-(AFHTTPSessionManager *)videoManager{
    if (!_videoManager) {
        NSURLSessionConfiguration *  defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultSessionConfiguration.timeoutIntervalForRequest =15.0;
        _videoManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:defaultSessionConfiguration];
        _videoManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_videoManager.requestSerializer setValue:@"news.app.autohome.com.cn" forHTTPHeaderField:@"Host"];
//        [_videoManager.requestSerializer setValue:@"Paw/2.3.1 (Macintosh; OS X/10.13.3) GCDHTTPRequest" forHTTPHeaderField:@"User-Agent"];
        _videoManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _videoManager.securityPolicy.allowInvalidCertificates = YES;
        _videoManager.securityPolicy.validatesDomainName = NO;
    }
    return _videoManager;
}
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.tableHeaderView = [UIView new];
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.clipsToBounds = YES;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsVerticalScrollIndicator = NO;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftCell"];
    }
    return _leftTableView;
}
#pragma mark- life
-(void)viewWillDisappear:(BOOL)animated{
    if (self.isRight) {
        [self moveToLeft];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.tableView.mj_header isRefreshing]?nil: [self.tableView.mj_header beginRefreshing];
    });
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return  _dataArr;
}
#pragma mark- events
-(void)clickItem:(UIBarButtonItem*)item{
    ZJLog(@"跳转");
    NSArray *hotSeaches = @[@"宝马", @"奔驰", @"尼桑", @"大众", @"长安", @"哈佛H6", @"路虎", @"北京现代", @"海马", @"广汽传祺", @"楼兰", @"朗逸", @"金杯", @"五菱宏光"];
    if (self.keyArr.count) {
        hotSeaches = self.keyArr;
    }
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索您想找的车子" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        SwithViewController * py =      [[SwithViewController alloc] init];
        py.title = searchText;
        [searchViewController.navigationController pushViewController:py animated:NO];
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; 
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleColorfulTag; 
    searchViewController.delegate = self;
    [self.navigationController pushViewController:searchViewController animated:YES];
}
-(void)jumpToSetting:(UIButton*)btn{
    [self moveToLeft];
    nswySettingController * set = [[nswySettingController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:set animated:YES];
}
#pragma mark- 加载数据
-(void)firstComein{
    [SVProgressHUD show];
    MJWeakSelf

    NSString * url = @"https://61.240.128.76/news_v8.8.5/news/editvideos-pm1-sid0-lid0-s50-crv0.json";
    [self.videoManager zj_GET:url withParams:nil successComplete:^(id responseObject) {
        if(responseObject != nil&&[responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSDictionary *info = [dic valueForKey:@"result"];
            NSError * error;
            RLMRealm *realm = [RLMRealm defaultRealm];
            BOOL is =      [realm transactionWithBlock:^{
                [EditVideos  createOrUpdateInRealm:realm withValue:info];
            } error:&error];
            if (is) {
                self.results = [CarVideo allObjects];
            }
        }
        if(self.results.count){
            self.n=1;
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failureComplete:^(id error) {
        NSLog(@"%@",error);
        [SVProgressHUD  showErrorWithStatus:NSLocalizedString(@"데이터", nil)];
        [weakSelf.tableView.mj_header endRefreshing];
    } isShowHUD:YES];
    [self.KeywordManager zj_GET:@"https://sou.api.autohome.com.cn/webapi/apprec/GetRecommendAdv?_appid=app&pv=IOS&uid=3da6addb5b9bdb6f5244c7588525bb8ce73c891e&scid=1&city=110100" withParams:nil successComplete:^(id response) {
        if (response != nil && [response isKindOfClass:[NSDictionary class]]) {
            if ([[response valueForKey:@"returncode"] intValue] == 0) {
                NSArray * list = [[response valueForKey:@"result"]  valueForKey:@"list"];
                NSMutableArray * arr = [NSMutableArray array];
                for (NSDictionary * info in list) {
                    NSString * name = [info valueForKey:@"name"];
                    [arr addObject:name];
                }
                if (arr.count) {
                    self.keyArr = arr;
                    NSLog(@"关键词 %@",arr);
                }
            }
        }
    } failureComplete:^(id error) {
    } isShowHUD:NO];
}
-(void)pullUpRefresh{
    MJWeakSelf
    NSLog(@"%@",video(self.n, 20));
    if (self.n ==1) {
 self.n = (int)self.results.count/50+1;
    }
    [self.videoManager zj_GET:video(self.n, 50) withParams:nil successComplete:^(id responseObject) {
        NSUInteger  c = 0;
        if(responseObject != nil&&[responseObject isKindOfClass:[NSDictionary class]]){
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSDictionary *info = [dic valueForKey:@"result"];
            NSError * error;
            c = [[info valueForKey:@"list"] count];
            RLMRealm *realm = [RLMRealm defaultRealm];
            BOOL is =      [realm transactionWithBlock:^{
                [EditVideos  createOrUpdateInRealm:realm withValue:info];
            } error:&error];
            if (is) {
                self.results = [CarVideo allObjects];
            }
        }
        if(self.results.count){
            [weakSelf.tableView reloadData];
        }
        [self.tableView.mj_footer endRefreshing];
        if (c < 50 ) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            self.n++;
        }
    } failureComplete:^(id error) {
        NSLog(@"%@",error);
        [SVProgressHUD  showErrorWithStatus:NSLocalizedString(@"데이터", nil)];
        [self.tableView.mj_footer endRefreshing];
    } isShowHUD:YES];
}
-(void)pullDownRefresh{
    [self firstComein];
}
#pragma mark-  ssss
static NSString * followCell = @"followCell";
- (void)setUpSearchBar{
    UISearchBar * searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = @"搜索你要关注的内容或专家";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.serachBar = searchBar;
    self.serachBar.delegate = self;
    [self.view addSubview:self.serachBar];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return NO;
}
-(void)test{
    

}
-(void)test1{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"cont.app.autohome.com.cn" forHTTPHeaderField:@"Host"];
manager.requestSerializer= [AFHTTPRequestSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@".*html.*", nil];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy.validatesDomainName = NO;
    [manager zj_GET:@"http://61.240.128.76/cont_v8.8.5/content/news/newscontent-pm1-n898899-t0-rct1-ish1-ver.json" withParams:nil successComplete:^(id response) {
        NSLog(@"返回的response : %@",response);
    } failureComplete:^(NSError * error ) {
        NSLog(@" backerror : %@",error.description);

    } isShowHUD:YES];


}

- (void)viewDidLoad {
    [super viewDidLoad];












    _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];

    [_fpsLabel sizeToFit];
    // _fpsLabel.alpha = 0;
    _fpsLabel.textColor = [UIColor grayColor];
    _fpsLabel.backgroundColor = [UIColor redColor];
     [[UIApplication sharedApplication].keyWindow addSubview:_fpsLabel];
  [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_fpsLabel];


    self.tableView.translatesAutoresizingMaskIntoConstraints = NO; ;
    self.navigationController.delegate =self;
    self.title = NSLocalizedString(@"스포츠카 정보", nil);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight=200.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CarVideoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:followCell];
    [self firstComein];
    MJWeakSelf
    NSArray * images = @[  [UIImage imageNamed:@"car1"] ,[UIImage imageNamed:@"car2"],[UIImage imageNamed:@"car3"],[UIImage imageNamed:@"car4"],[UIImage imageNamed:@"car5"],[UIImage imageNamed:@"car6"]];
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_footer resetNoMoreData];
        [weakSelf pullDownRefresh];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setImages:images  forState:MJRefreshStateRefreshing];
    [header setImages:images forState:MJRefreshStateIdle];
    self.tableView.mj_header = header;
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [weakSelf pullUpRefresh];
    }];
    [footer setImages:images  forState:MJRefreshStateRefreshing];
    [footer setImages:images forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"sou"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:UIBarButtonItemStylePlain target:self action:@selector(clickItem:)];
    UIButton * left = [[UIButton alloc]initWithFrame:CGRectZero];
    [left sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://tvax1.sinaimg.cn/crop.0.0.996.996.180/c448ca11ly8fnrohhh38bj20ro0roq3y.jpg"]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avator"] ];
    [left addTarget:self action:@selector(clickheader:) forControlEvents:UIControlEventTouchUpInside];
    [left.layer setBorderColor:[UIColor whiteColor].CGColor];
    [left.layer setBorderWidth:2.0];
    [left.layer setCornerRadius:20];
    [left.layer setMasksToBounds:YES];
    [self registerEffectForView:left depth:10];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
    }];
    self.navigationItem.leftBarButtonItem = item;
    [self setupLeft];
    UISwipeGestureRecognizer * gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.tableView addGestureRecognizer:gesture];
    self.n=1;
}
-(void)setupLeft{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor = ZJThemeColor;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(keyWindow.mas_left);
        make.top.mas_equalTo(keyWindow);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(keyWindow);
    }];
    UIView * avatorView = [[UIView alloc]initWithFrame:CGRectZero];
    [view addSubview:avatorView];
    [avatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(view.mas_width);
        make.top.left.mas_equalTo(view);
    }];
    UIButton * left = [[UIButton alloc]initWithFrame:CGRectZero];
    [left sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://tvax1.sinaimg.cn/crop.0.0.996.996.180/c448ca11ly8fnrohhh38bj20ro0roq3y.jpg"]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avator"] ];
    [left addTarget:self action:@selector(jumpToSetting:) forControlEvents:UIControlEventTouchUpInside ];
    [left.layer setBorderColor:[UIColor whiteColor].CGColor];
    [left.layer setBorderWidth:2.0];
    [left.layer setCornerRadius:20];
    [left.layer setMasksToBounds:YES];
    [avatorView addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.center.mas_equalTo(avatorView);
    }];
    [view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.mas_equalTo(view) ;
        make.height.mas_equalTo(view).mas_offset(-100);
    }];
    self.V = view;
    self.isRight = NO;
    NSLog(@"---------------------\n%@",view);
}
-(void)viewDidLayoutSubviews{
}
-(void)panGesture:(UISwipeGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded &&gesture.direction ==UISwipeGestureRecognizerDirectionRight ) {
        [self moveToRight];
    }else if(gesture.state == UIGestureRecognizerStateEnded && gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        [self moveToLeft];
    }
}
-(void)clickheader:(UIButton*)item{
    self.isRight?[self moveToLeft]:[self moveToRight];
}
-(void)addFoucs:(UIBarButtonItem * )item{
    ZJlogFunction;
    nswyCategaryController * categary = [[nswyCategaryController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:categary animated:YES];
}
-(void)moveToRight{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.mj_x = 100;
    }];
    [self.V mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(keyWindow.mas_left).mas_offset(100);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [keyWindow layoutIfNeeded];
    }];
    self.isRight = YES;
}
-(void)moveToLeft{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.mj_x = 0;
    }];
    [self.V mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(keyWindow.mas_left);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [keyWindow layoutIfNeeded];
    }];
    self.isRight = NO;
}
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = self.results.count ==0;
    if ([tableView isEqual:self.leftTableView]) {
        return 2;
    }
    return  self.results.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
  cell.textLabel.text = @"精彩视频";
                break;
            default:
                  cell.textLabel.text = @"敬请期待";
                break;
        }
        return cell;
    }
    CarVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:followCell forIndexPath:indexPath];
    cell.carvideo =  [self.results objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);

   
    if ([tableView isEqual:self.leftTableView]  ) {
        switch (indexPath.row) {
            case 0:
                [self.tableView.mj_header beginRefreshing];
                [self moveToLeft];
                break;
            default:
                break;
        }
        return;
    }
    if (self.isRight) {
        [self moveToLeft];
        return;
    }
    CarVideo * car = [self.results objectAtIndex:indexPath.row];
     nswyMVViewController * mv =[[nswyMVViewController alloc]init];
    mv.car = car;
    [self.navigationController pushViewController:mv animated:YES];

}
#pragma mark - Private Method
- (void)registerEffectForView:(UIView *)aView depth:(CGFloat)depth;
{
    UIInterpolatingMotionEffect *effectX;
    UIInterpolatingMotionEffect *effectY;

    effectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    effectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];

    effectX.maximumRelativeValue = @(-depth);
    effectX.minimumRelativeValue = @(depth);
    effectY.maximumRelativeValue = @(-depth);
    effectY.minimumRelativeValue = @(depth);

    [aView addMotionEffect:effectX];
    [aView addMotionEffect:effectY];
}
#pragma mark - PYSearchViewControllerDelegate 搜索框
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    NSLog(@"%@",seachBar.text);
    if (searchText.length) { 
        NSLog(@"searchText : %@",searchText);
        [self.manager.requestSerializer setValue:@"1|3da6addb5b9bdb6f5244c7588525bb8ce73c891e|autohomebrush|1520861481|C6ECD88794DA6C8F803F3D9D005D1E16" forHTTPHeaderField:@"apisign"];
        [self.manager.requestSerializer setValue:@"mobilenc.app.autohome.com.cn" forHTTPHeaderField:@"Host"];
        [self.manager.requestSerializer setValue:@"iPhone 11.3 autohome 8.9.0 iPhone" forHTTPHeaderField:@"User-Agent"];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setValue:@"2" forKey:@"a"];
        [dic setValue:@"1" forKey:@"pm"];
        [dic setValue:@"8.9.0" forKey:@"v"];
        [dic setValue:searchText forKey:@"k"];
        [dic setValue:@"5" forKey:@"t"];
        [dic setValue:@"3da6addb5b9bdb6f5244c7588525bb8ce73c891e" forKey:@"deviceid"];
        [self.manager GET:@"https://223.99.255.22/sou_v7.7.5/sou/suggestwords.ashx" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if ([[responseObject valueForKey:@"returncode"] intValue] == 0 ) {
                    NSDictionary * result = [responseObject valueForKey:@"result"];
                    NSArray*    M = [result valueForKey:@"wordlist"];
                    for (NSDictionary * info in M) {
                        if ([info valueForKey:@"name"]) {
                            [searchSuggestionsM addObject:[info valueForKey:@"name"]];
                        }
                    }
                }
                searchViewController.searchSuggestions = searchSuggestionsM;
            }
            NSLog(@"suceess %@",[NSString stringWithFormat:@"%@",responseObject]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error %@",error);
        }];
    }
}
#pragma mark -PellTableViewSelect 关注
- (void)selectFocus:(UIButton *)sender{
    ZJLog(@"%i",sender.selected);
    sender.selected =!sender.selected;
    NSArray * arr =@[@"全部关注",@"关注的服务",@"关注的物种",@"关注的商品",@"关注的知识",@"关注的资讯"];
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(sender.frame.origin.x,sender.frame.origin.y , 150,150) selectData:arr images:nil action:^(NSInteger index) {
        NSLog(@"选择%ld",index);
        if (sender.selected) {
            sender.selected = NO;
        }
        [sender setTitle:arr[index] forState:UIControlStateNormal];
    } animated:YES];
}
#pragma mark 文字转图片
#define CONTENT_MAX_WIDTH   300.0f
+(UIImage *)imageFromText:(NSArray*) arrContent withFont: (CGFloat)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGRect stringSize = [sContent boundingRectWithSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.size.height]];
        fHeight += stringSize.size.height;
    }
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
    CGContextSetRGBFillColor (ctx, 0.1, 0.2, 0.3, 1); 
    CGContextSetRGBStrokeColor (ctx, 0, 0, 0, 1);
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , [numHeight floatValue]);
        [sContent drawInRect:rect withAttributes:@{NSFontAttributeName: font }];
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
UIImage * GetImage( NSString * str) {
    CGSize Size = CGSizeMake(60, 60);
    UIGraphicsBeginImageContextWithOptions(Size,NO,0.0);
    double width; CGContextRef context; CGPoint textPosition; CFAttributedStringRef attrString;
    const char * N = [str UTF8String];
    CFStringRef string = CFStringCreateWithCString(kCFAllocatorDefault, N, kCFStringEncodingUTF8 );
    width =60;
    context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, Size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    textPosition = CGPointMake(0.0, 15.0);
    CFStringRef fontName =CFSTR("HanWangWCL10");
    CTFontRef  font =
    CTFontCreateWithName(fontName, 30, NULL);
    CGFloat number = 3.0;
    CFNumberRef strokeWidth = CFNumberCreate(kCFAllocatorDefault, kCFNumberFloatType, &number  );
    CGColorSpaceRef space =   CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.5,0.5,1.0,1};
    CGColorRef color = CGColorCreate(space, components);
    CGFloat superScriptnumber = 1;
    CFNumberRef superScript = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &superScriptnumber  );
    CGFloat UnderlineStylenumber =kCTUnderlineStyleNone|kCTUnderlinePatternSolid ;
    CFNumberRef UnderlineStyle = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &UnderlineStylenumber  );
    CGColorSpaceRef Underlinespace =   CGColorSpaceCreateDeviceRGB();
    CGFloat Underlinecomponents[] = {0.0,0.5,0.5,1};
    CGColorRef Underlinecolor = CGColorCreate(Underlinespace, Underlinecomponents);
    CFBooleanRef t = kCFBooleanFalse;
    CFStringRef keys[] = { kCTFontAttributeName,kCTStrokeWidthAttributeName ,kCTStrokeColorAttributeName,kCTSuperscriptAttributeName,kCTUnderlineColorAttributeName,kCTUnderlineStyleAttributeName,kCTVerticalFormsAttributeName };
    CFTypeRef values[] = { font ,strokeWidth,color,superScript,Underlinecolor, UnderlineStyle  ,t};
    CFDictionaryRef attributes =
    CFDictionaryCreate(kCFAllocatorDefault,(const void**)&keys,
                       (const void**)&values,sizeof(keys)/sizeof(keys[0]) ,
                       &kCFTypeDictionaryKeyCallBacks,
                       &kCFTypeDictionaryValueCallBacks);
    attrString =   CFAttributedStringCreate(kCFAllocatorDefault, string, attributes);
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString(attrString);
    CFIndex start = 0;
    CFIndex count = CTTypesetterSuggestLineBreak(typesetter, start, width);
    CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(start, count));
    float flush = 0.5; 
    double penOffset = CTLineGetPenOffsetForFlush(line, flush, width);
    CGContextSetTextPosition(context, textPosition.x + penOffset, textPosition.y);
    CTLineDraw(line, context);
    CGColorRelease(color);
    CGColorRelease(Underlinecolor);
    CGColorSpaceRelease(Underlinespace);
    CGColorSpaceRelease(space);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    if ([scrollView isEqual:self.tableView] && self.isRight ) {
        [self moveToLeft];
    }
}
#pragma mark- UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    TransitionObject*  animator = [[TransitionObject alloc]init];
    if(operation == UINavigationControllerOperationPush&&[toVC isKindOfClass: [nswyMVViewController class]])
    return  animator;
    return nil;
}
#pragma mark-释放内存
-(void)dealloc{
    [self.V removeFromSuperview];
    self.V = nil;
}
@end
