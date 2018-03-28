#import "ArticleTypeOneViewController.h"
#import "ArticleSearch.h"
#import "ArticleCell.h"
#import "CarViewController.h"
@interface ArticleTypeOneViewController ()
@property RLMResults   * data;

@property (nonatomic,strong)UITableView * headTableView;

@property (nonatomic,copy) NSMutableArray <NSString *  > * titleArr;

@property (nonatomic,assign) BOOL isOpen;

//@property

@end

@implementation ArticleTypeOneViewController
static CGFloat Hight = 40.f;

-(BOOL)isOpen{

    return self.headTableView.mj_h != Hight;
}

-(NSMutableArray<NSString *> *)titleArr{

    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObject:@"全部"];
        for (int i =0 ; i<4 ; i++) {
            [_titleArr addObject:@"新闻中心"];
        }

    }
    return _titleArr;

}
-(UITableView *)headTableView{

    if (!_headTableView) {
        _headTableView  =  [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _headTableView.rowHeight = Hight;
        _headTableView.dataSource= self;
        _headTableView.delegate = self;
        _headTableView.scrollEnabled = NO;
        _headTableView.sectionFooterHeight = 0.5;
        _headTableView.sectionHeaderHeight = 0.0;
        _headTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
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


    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.headTableView.mas_top).mas_offset(Hight);
        make.bottom.left.right.equalTo(self.view);


    }];
    self.headTableView.tableFooterView = [UIView new];
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


-(void)pullUpRefresh{
    MJWeakSelf
    NSString * baseURL = @"https://sou2.api.autohome.com.cn/wrap/v3/article/search";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    NSInteger  offset = self.data.count;
    [params setValue:@"app" forKey:@"_appid"];
    [params setValue:@(1) forKey:@"class"];
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
                    self.data = [Article_hitlist_data objectsWhere:@" class_name == %@",@"新闻中心"];
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
    [params setValue:@"" forKey:@"class"];
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
                    self.data = [Article_hitlist_data objectsWhere:@" class_name == %@",@"新闻中心"];
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

    if ([tableView isEqual:self.headTableView]) {
        return self.titleArr.count;
    }
  return   self.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:self.headTableView]) {
        UITableViewCell * cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"headCell"];

        cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.section];
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
    cell.data = [self.data objectAtIndex:indexPath.section];
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

            return;
        }
 //重新约束header
        if (self.titleArr.count>1) {
            [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([tableView rowHeight]*self.titleArr.count));
            }];
      
                [tableView layoutIfNeeded];
            tableView.scrollEnabled = YES;
                NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
                [tableView selectRowAtIndexPath:index animated:NO scrollPosition:(UITableViewScrollPositionTop)];

            //[tableView reloadData];
        }


        return;
    }

    Article_hitlist_data * data = [self.data objectAtIndex:indexPath.section];
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

@end
