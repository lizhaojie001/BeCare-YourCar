#import "nswyMVViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD.h>
#import "VideoOfCar.h"
#import "VideoComment.h"
#import "VideoCommentCell.h"
#define commentsAPI(commentid,offset,lastid)  [NSString stringWithFormat:@"https://223.99.255.22/reply_v7.9.0/news/videocomments-pm1-vi%ld-o0-s%ld-lastid%ld.json",commentid,offset,lastid]
@interface nswyMVViewController ()<UIWebViewDelegate,ZFPlayerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)AFHTTPSessionManager * videoManager;
@property (nonatomic,strong)ZFPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic,strong)UITableView * commmentsView;
@property (nonatomic,strong) RLMArray<VideoCommentList*><VideoCommentList> * commentResults;
@property (nonatomic,strong) UIActivityIndicatorView  * indicatorView;
@property (nonatomic,strong) UIView * noComments;
@property (nonatomic,strong) NSURLSessionTask * commentTask;
@property (nonatomic,strong) NSURLSessionTask * playerTask;
@end
@implementation nswyMVViewController
#pragma mark-Getter
-(UITableView *)commmentsView{
    if (!_commmentsView) {
        _commmentsView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped] ;
        _commmentsView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0 );
        _commmentsView.tableFooterView = [UIView new];
        _commmentsView.showsVerticalScrollIndicator =NO;
        //        _commmentsView.estimatedRowHeight = 200.0;
        _commmentsView.rowHeight = UITableViewAutomaticDimension;
        _commmentsView.dataSource = self;
        _commmentsView.delegate = self;
        //        _commmentsView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_commmentsView];
        [_commmentsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).mas_offset(-20);
            make.top.equalTo(self.fatherView.mas_bottom).mas_offset(10);
            make.left.equalTo(self.view).mas_offset(20);
            make.bottom.equalTo(self.view).mas_offset(-5);
        }];
        self.noComments = [[UIView alloc]initWithFrame:CGRectZero];
        self.noComments.hidden = YES;
        [_commmentsView addSubview:self.noComments];
        [self.noComments mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@200);
            make.width.equalTo(_commmentsView);
            make.center.equalTo(_commmentsView);
        }];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = [UIImage imageNamed:@"noComments"];
        [self.noComments addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@90);
            make.height.equalTo(@83);
            make.center.equalTo(self.noComments);
        }];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = ZJThemeColor;
        label.text = @"暂无评论(*^__^*)，快来抢沙发吧!";
        label.font= [UIFont fontWithName:@"Helvetica Light" size:14.0];
        [self.noComments addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).mas_offset(5);
            make.width.equalTo(self.noComments);
            make.height.equalTo(@15);
            make.centerX.equalTo(imageView);
        }];
        self.indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_commmentsView addSubview:self.indicatorView];
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.center.equalTo(_commmentsView);
        }];
        [_commmentsView registerNib:[UINib nibWithNibName:NSStringFromClass([VideoCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VideoCommentCell class])];
    }
    return _commmentsView;
}
-(UIView *)fatherView{
    if (!_fatherView) {
        _fatherView = [[UIView alloc]init];
        MJWeakSelf
        [self.view addSubview:_fatherView];
        CGFloat  s = 1.0*9/16*ZJScreenW;
        [_fatherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(ZJScreenW));
            make.height.equalTo(@(s));
            make.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view);
        }];
    }
    return _fatherView;
}
- (ZFPlayerModel *)playerModel {
    MJWeakSelf
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = self.title;
        //        _playerModel.videoURL         = [NSURL URLWithString: [self.videoInfo valueForKey:@"playurl"]];
        //        _playerModel.placeholderImageURLString =[self.videoInfo valueForKey:@"img"];
        _playerModel.fatherView       = weakSelf.fatherView;
    }
    return _playerModel;
}
- (ZFPlayerView *)playerView {
    if (!_playerView) {
        MJWeakSelf
        _playerView = [[ZFPlayerView alloc] init];
        //        [_playerView playerControlView:nil playerModel:weakSelf.playerModel];
        _playerView.delegate = self;
        _playerView.hasDownload    = YES;
        _playerView.hasPreviewView = YES;
    }
    return _playerView;
}
-(AFHTTPSessionManager *)videoManager{
    if (!_videoManager) {
        NSURLSessionConfiguration *  defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultSessionConfiguration.timeoutIntervalForRequest =15.0;
        _videoManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:defaultSessionConfiguration];
        _videoManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_videoManager.requestSerializer setValue:@"newsnc.app.autohome.com.cn" forHTTPHeaderField:@"Host"];
        _videoManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _videoManager.securityPolicy.allowInvalidCertificates = YES;
        _videoManager.securityPolicy.validatesDomainName = NO;
    }
    return _videoManager;
}
#pragma mark- 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        self.playerView.playerPushedOrPresented = NO;
    }
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        self.playerView.playerPushedOrPresented = YES;
    }else{

        [self.playerView pause];

    }
    [self.playerTask cancel];
    [self.navigationController setNavigationBarHidden:NO];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    [self.commentTask cancel];
    [self.playerView removeFromSuperview];
    [self.fatherView removeFromSuperview];
    [self.commmentsView removeFromSuperview];
    self.commmentsView  = nil;
    self.fatherView = nil;
    self.playerView= nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.car.title;
    self.view.backgroundColor =self.commmentsView.backgroundColor;
    [self setcommentsVIew];
    [self firstComein];
    [self getMVplayURL];
}
-(void)setcommentsVIew{

    NSArray * images = @[  [UIImage imageNamed:@"car1"] ,[UIImage imageNamed:@"car2"],[UIImage imageNamed:@"car3"],[UIImage imageNamed:@"car4"],[UIImage imageNamed:@"car5"],[UIImage imageNamed:@"car6"]];
    MJWeakSelf
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [weakSelf pullUpRefresh];
    }];
    [footer setImages:images  forState:MJRefreshStateRefreshing];
    [footer setImages:images forState:MJRefreshStateIdle];
    self.commmentsView.mj_footer = footer;
}


-(void)getMVplayURL{
    MJWeakSelf
    NSMutableDictionary * doc = [NSMutableDictionary dictionary];
    [doc setValue:@1 forKey:@"pm"];
    [doc setValue:@"wifi" forKey:@"network"];
    [doc setValue:self.car.videoid forKey:@"mids"];
    [doc setValue:@1 forKey:@"mt"];
    [doc setValue:@"mp4" forKey:@"ft"];
    [doc setValue:@(ZJScreenW) forKey:@"dw"];
    [doc setValue:@(ZJScreenH) forKey:@"dh"];
    [doc setValue:@"iPhone 11.3 autohome 8.9.0 iPhone" forKey:@"ua"];
    [doc setValue:@(YES) forKey:@"getall"];
    //    [SVProgressHUD show];
    NSString *url =@"https://223.99.255.22/news_v8.8.5/newspf/npgetvideoaudiosource.ashx";
    self.playerTask =    [self.videoManager zj_GET:url withParams:doc successComplete:^(id response) {
        NSLog(@"%@",response);
        //        [SVProgressHUD dismiss];
        if (response !=nil &&[response isKindOfClass:[NSDictionary class]]) {
            NSDictionary * info = [[response valueForKey:@"result"] firstObject];
            if ([[response valueForKey:@"returncode"]intValue] == 0) {
                NSDictionary  * dic     = [[info valueForKey:@"copieslist"] firstObject];
                NSString *url = [dic valueForKey:@"playurl"];
                NSString *image = [info valueForKey:@"img"];
                NSAssert(url.length, @"播放视频的URL为空 url ==%@",url);
                NSAssert1(image.length, @" iamge = %@", image);
                NSDictionary * abc = @{@"playurl": url,@"img":image};
                //                weakSelf.videoInfo = dic;
                
                [weakSelf.videoInfo setValuesForKeysWithDictionary:abc] ;
                weakSelf.playerModel.videoURL = [NSURL URLWithString:url];
                weakSelf.playerModel.placeholderImageURLString = image;
                [weakSelf.playerView playerControlView:nil playerModel:weakSelf.playerModel];
                [self.playerView autoPlayTheVideo];
                //                [weakSelf.playerView resetToPlayNewVideo:weakSelf.playerModel];

            }else{
            }
        }
    } failureComplete:^(id error) {
        //        [SVProgressHUD showErrorWithStatus:@"暂无视频地址"];
    } isShowHUD:YES];
}

#pragma mark- 数据源
-(void)firstComein{
    MJWeakSelf

    [self.indicatorView startAnimating];
    NSLog(@"%@",commentsAPI(self.car.id, 40, 0));
    self.commentTask =   [self.videoManager zj_GET:commentsAPI(self.car.id, 40,0) withParams:nil successComplete:^(id response) {
        [weakSelf.indicatorView stopAnimating];
        if (response != nil&&[response isKindOfClass:[NSDictionary class]]) {
            if ([[[response valueForKey:@"result"] valueForKey:@"list"] count]) {
                self.noComments.hidden =YES;
                NSDictionary * dic = [response valueForKey:@"result"];
                RLMRealm * realm = [RLMRealm defaultRealm];
                NSError * error;
                BOOL is =     [realm transactionWithBlock:^{
                    [VideoComment createOrUpdateInRealm:realm withValue:dic];
                } error:&error];
                if(is){
                    RLMResults *comments = [VideoComment objectsWhere:@" pageid == %@", [dic valueForKey:@"pageid"]];
                    VideoComment * comment = comments.firstObject;
                    weakSelf.commentResults = comment.list;
                    [weakSelf.commmentsView reloadData];
                    if ([[[response valueForKey:@"result"] valueForKey:@"totalcount"] intValue] <40) {
                        weakSelf.commmentsView.mj_footer.hidden = YES;
                    }
                    NSLog(@"打印该视频 评论 %ld --%%@",self.commentResults.count,comments);
                }
            }else{
                weakSelf.noComments.hidden =NO;
            }
        }
    } failureComplete:^(id error) {
        [weakSelf.indicatorView stopAnimating];
        weakSelf.noComments.hidden =NO;
    } isShowHUD:YES];
}
-(void)pullUpRefresh{
    MJWeakSelf
    NSInteger  lastid = [self.commentResults.lastObject  id];
    self.commentTask =    [self.videoManager zj_GET:commentsAPI(self.car.id, 40, lastid) withParams:nil successComplete:^(id response) {
        if (response != nil&&[response isKindOfClass:[NSDictionary class]]) {
            NSInteger count =         [[[response valueForKey:@"result"] valueForKey:@"list"] count];
            NSLog(@"加载更多的评论数- --- %ld",count);
            if (count) {
                NSDictionary * dic = [response valueForKey:@"result"];
                RLMRealm * realm = [RLMRealm defaultRealm];
                NSError * error;
                BOOL is =     [realm transactionWithBlock:^{
                    [VideoComment createOrUpdateInRealm:realm withValue:dic];
                } error:&error];
                if(is){
                    RLMResults *comments = [VideoComment objectsWhere:@" pageid == %@", [dic valueForKey:@"pageid"]];
                    VideoComment * comment = comments.firstObject;
                    [realm beginWriteTransaction];
                    [weakSelf.commentResults addObjects: comment.list];
                    [realm commitWriteTransaction];
                    [weakSelf.commmentsView reloadData];
                    if (self.commentResults.count < 40  ) {
                        [weakSelf.commmentsView.mj_footer endRefreshingWithNoMoreData];
                        weakSelf.commmentsView.mj_footer.hidden = YES;
                    }else{
                        [weakSelf.commmentsView.mj_footer endRefreshing];
                        weakSelf.commmentsView.mj_footer.hidden =NO;
                    }
                    NSLog(@"打印该视频 评论 %ld --%%@",self.commentResults.count,comments);
                }
            }else{
                [weakSelf.commmentsView.mj_footer endRefreshingWithNoMoreData];
                weakSelf.commmentsView.mj_footer.hidden = YES;
            }
        }
    } failureComplete:^(id error) {
        [weakSelf.commmentsView.mj_footer endRefreshingWithNoMoreData];
        weakSelf.commmentsView.mj_footer.hidden = YES;
    } isShowHUD:YES];
}
- (BOOL)shouldAutorotate {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"적재", nil)];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismissWithDelay:0.5];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismissWithDelay:0.5];
}
#pragma mark- 视频播放代理
- (void)zf_playerBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)zf_playerDownload:(NSString *)url{
    NSLog(@"%@",url);
}
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    [self.commmentsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fatherView.mas_bottom).mas_offset(10);
    }];
    [self.view layoutIfNeeded];
    ZJlogFunction
}
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen{
    [self.commmentsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fatherView.mas_bottom).mas_offset(10);
    }];
    [self.view layoutIfNeeded];
    ZJlogFunction
}
#pragma mark- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.commmentsView.mj_footer.hidden = self.commentResults.count == 0;
    return self.commentResults.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoCommentCell class]) forIndexPath:indexPath];
    cell.backgroundColor = tableView.backgroundColor;
    cell.list = [self.commentResults objectAtIndex:indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
    label.layer.cornerRadius = 5.0f;
    label.layer.masksToBounds = YES;
    label.font =[UIFont fontWithName:@"Helvetica Light" size:16.0];
    label.text = @" !!最新评论";
    label.textColor = ZJThemeColor;
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (scrollView.contentOffset.y == 0) {
        self.commmentsView.tableHeaderView.hidden = NO;
    }else{
        self.commmentsView.tableHeaderView.hidden = YES;
    }
}

-(void)dealloc{
    ZJlogFunction
}
@end
