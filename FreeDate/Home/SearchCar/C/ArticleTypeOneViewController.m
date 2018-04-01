#import "ArticleTypeOneViewController.h"
#import "ArticleSearch.h"
#import "ArticleCell.h"
#import "CarViewController.h"
@interface ArticleTypeOneViewController ()

@property (nonatomic,strong)UITableView * headTableView;

@property  RLMResults <Article_hitlist *>  * hitlist;
@property      ZJArtilteSort *  sort;
@property ArticleSearch * searchResults;

@property (nonatomic,assign) BOOL isOpen;

//@property

@end

@implementation ArticleTypeOneViewController
static CGFloat Hight = 40.f;
static    NSString  * const  key = @"searchWord";
-(BOOL)isOpen{

    return self.headTableView.mj_h != Hight;
}

-(UITableView *)headTableView{

    if (!_headTableView) {
        _headTableView  =  [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _headTableView.backgroundColor = self.tableView.backgroundColor;
        _headTableView.rowHeight = Hight;
        _headTableView.dataSource= self;
        _headTableView.delegate = self;
        _headTableView.scrollEnabled = NO;
        _headTableView.sectionFooterHeight = 0.5;
        _headTableView.sectionHeaderHeight = 0.0;
        _headTableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _headTableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_headTableView];
        [_headTableView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.view).mas_offset(44);
            make.width.equalTo(self.view);
            make.height.equalTo(@(Hight));

        }];
        [_headTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"headCell"];
    }
    return _headTableView;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取分类
  


    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.headTableView.mas_top).mas_offset(Hight);
        make.bottom.left.right.equalTo(self.view);


    }];
    self.headTableView.tableFooterView = [UIView new];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ArticleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ArticleCell class])];
    MJWeakSelf
 NSArray * images = @[  [UIImage imageNamed:@"car1"] ,[UIImage imageNamed:@"car2"],[UIImage imageNamed:@"car3"],[UIImage imageNamed:@"car4"],[UIImage imageNamed:@"car5"],[UIImage imageNamed:@"car6"]];
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [weakSelf pullUpRefreshWith:nil andOffset:40];
    }];
    [footer setImages:images  forState:MJRefreshStateRefreshing];
    [footer setImages:images forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;

//添加下拉刷新
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf firstComeinWith:nil];
    }];
    [header setImages:images forState:MJRefreshStateRefreshing];
    [header setImages:images forState:MJRefreshStateIdle];
    self.tableView.mj_header = header;
    [header beginRefreshing];
    //添加监控

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchVC) name:zNSNotificationSwithView object:nil];

}

-(void)switchVC{

    if (self.isOpen) {
        [self.headTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@([self.headTableView rowHeight]));
        }];
        [self.headTableView layoutIfNeeded];

        NSIndexPath *indexpath = [self.headTableView indexPathForSelectedRow];
        [self.headTableView selectRowAtIndexPath:indexpath animated:NO scrollPosition:(UITableViewScrollPositionTop)];

    }
}


-(void)pullUpRefreshWith:(NSString *)class andOffset:(NSInteger )offset{
    MJWeakSelf
    NSString * baseURL = @"https://sou2.api.autohome.com.cn/wrap/v3/article/search";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    class = self.sort.type;
    offset = self.hitlist.count;
    [params setValue:@"app" forKey:@"_appid"];
    [params setValue:class forKey:@"class"];
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
                NSDictionary * dic = [NSMutableDictionary dictionary];
                [dic setValuesForKeysWithDictionary:hitlist];

                [dic setValue:self.title forKey:key];


                [realm transactionWithBlock:^{
                    [ArticleSearch createOrUpdateInRealm:realm withValue:dic];
                } error:&error];

                if (error) {
                    NSLog(@"更新失败%@",error);
                }

                ArticleSearch * article =[ArticleSearch objectForPrimaryKey:weakSelf.title ];
                weakSelf.hitlist = [article.hitlist objectsWhere:@"data.class_name = %@",weakSelf.sort.name];

                if (  weakSelf.hitlist.count == weakSelf.sort.num) {
                    [self.tableView reloadData];
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    return ;
                }
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];


            }
        }
    } failureComplete:^(id error) {
 [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    } isShowHUD:YES];
}
-(void)firstComeinWith:(NSString *)class{
    MJWeakSelf
    class = self.sort.type;
    NSString * baseURL = @"https://sou2.api.autohome.com.cn/wrap/v3/article/search";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:@"app" forKey:@"_appid"];
    [params setValue:class forKey:@"class"];
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
                NSDictionary * dic = [NSMutableDictionary dictionary];
                [dic setValuesForKeysWithDictionary:hitlist];

                [dic setValue:self.title forKey:key];


                [realm transactionWithBlock:^{
                    [ArticleSearch createOrUpdateInRealm:realm withValue:dic];
                } error:&error];

   ArticleSearch * Article =[ArticleSearch objectForPrimaryKey:weakSelf.title ];
                weakSelf.sort = Article.facets.sortlist.firstObject;
   weakSelf.hitlist = [Article.hitlist objectsWhere:@"data.class_name = %@",weakSelf.sort.name];

                if ([weakSelf.tableView.mj_header isRefreshing]) {
                    [weakSelf.tableView.mj_header endRefreshing];
                }
                [weakSelf.tableView reloadData];



            }
        }
    } failureComplete:^(id error) {
    } isShowHUD:YES];
}
#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    self.tableView.mj_footer.hidden = self.data.count == 0;
    self.tableView.mj_footer.hidden = self.hitlist.count ==0;
    if ([tableView isEqual:self.headTableView]) {
        return self.searchResults.facets.sortlist.count;
    }
  return   self.hitlist.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.headTableView]) {
        UITableViewCell * cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headCell"];
        ZJArtilteSort * sort = [self.searchResults.facets.sortlist objectAtIndex:indexPath.section];
        cell.textLabel.text =sort.name;
        cell.textLabel.textColor =ZJThemeColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"苹方-简 极细体" size:13.0f];

        if (cell.isSelected) {
            cell.detailTextLabel.text = @"↓";
            cell.detailTextLabel.textColor = ZJThemeColor;
        }else{
            cell.detailTextLabel.text = nil;
        }

        return cell;
    }

    ArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ArticleCell class]) forIndexPath:indexPath];
    cell.data = [[self.hitlist objectAtIndex:indexPath.section] data];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.headTableView]) {
        if (self.isOpen) {

            tableView.scrollEnabled = NO;
            [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([tableView rowHeight]));
            }];

                [tableView layoutIfNeeded];

      [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionTop)];

//刷新列表
        //被选中的分类
            self.sort = [self.searchResults.facets.sortlist objectAtIndex:indexPath.section] ;
            [self.tableView.mj_header beginRefreshing];
            return;
        }
 //重新约束header
        if (self.searchResults.facets.sortlist.count>1) {
            [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([tableView rowHeight]*self.searchResults.facets.sortlist.count));
            }];
      
                [tableView layoutIfNeeded];
            tableView.scrollEnabled = YES;
                NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
//                [tableView selectRowAtIndexPath:index animated:NO scrollPosition:(UITableViewScrollPositionTop)];
            [tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
            //[tableView reloadData];
        }

        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString * class ;
        if ([cell.textLabel.text isEqualToString:@"全部"]) {
            class= @"";
        }else{
            class = cell.textLabel.text;
        }

      //  [self pullUpRefreshWith:nil andOffset:0];
//发送请求,刷新界面

        return;
    }

    Article_hitlist_data * data = [[self.searchResults.hitlist objectAtIndex:indexPath.section] data];
    CarViewController * vc = [[CarViewController alloc]initWithNibName:nil bundle:nil];
    vc.wbnet = data.url;
    vc.title = data.title;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.headTableView]) {
        return Hight;
    }
    return 80.0f;

}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableView]) {
        return 8.0;
    }
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.5;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.headTableView]) {
        return;
    }
    [self closeHead];
}


-(void)closeHead{
    if(self.isOpen){

        self.headTableView.scrollEnabled = NO;
        [self.headTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@([self.headTableView rowHeight]));
        }];

        [self.headTableView layoutIfNeeded];
        NSIndexPath * indexPath = [self.headTableView  indexPathForSelectedRow];

        [self.headTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionTop)];
    }
}
@end
