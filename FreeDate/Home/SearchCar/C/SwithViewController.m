#import "SwithViewController.h"
#import "UIView+ZJExtension.h"
#import "ArticleTypeOneViewController.h"
#import "ArticleTypeTwoViewController.h"
#import "ArticleTypeThreeViewController.h"
#import "ArticleTypeFourViewController.h"
@interface SwithViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIView * bottomView;
@property (nonatomic,weak) UIButton * selectedButton;
@property (nonatomic,strong) NSArray * DataArr;
@property (weak, nonatomic) UIScrollView *contentView;
@property (weak,nonatomic)UIView * titlesView;
@end
@implementation SwithViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    [self setupScrollView];
    [self setTitleView];
}
- (void)setTitleView{
    NSArray * titles = @[@"文章",@"试驾测评",@"汽车文化",@"用车养车"];
    CGFloat SW =self.view.bounds.size.width;
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SW, 44)];
    v.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    CGFloat y = 0;
    CGFloat W = SW/titles.count*1.0;
    CGFloat H = v.frame.size.height;
    for (int i =0;  i< titles.count; i ++) {
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(i*W, y, W, H)];
        [button1 setTitle:titles[i] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:button1];
        if (!i) {
            button1.selected =YES;
            self.selectedButton = button1;
        }
    }
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor redColor];
    bottomView.height= 2;
    bottomView.width = self.selectedButton.width;
    bottomView.centerX= self.selectedButton.centerX;
    bottomView.y = CGRectGetMaxY(self.selectedButton.frame)-2;
    [v addSubview:bottomView];
    [self.view addSubview:v];
    [self switchController:0];
    self.bottomView = bottomView;
    self.titlesView =v;
}
-(void)click:(UIButton*)button{
    self.selectedButton.selected = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.centerX = button.centerX;
    }];
    button.selected = YES;
    self.selectedButton = button;
    int index = (int)[self.titlesView.subviews indexOfObject:button];
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, self.contentView.contentOffset.y) animated:YES];
}
-(void)setupScrollView{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView.delegate = self;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
-(void)setupChildViewControllers{
    ArticleTypeOneViewController * supply = [[ArticleTypeOneViewController alloc]init];
    supply.type = 1;
    supply.title = self.title;
    ArticleTypeTwoViewController * buy = [[ArticleTypeTwoViewController alloc]init];
    buy.type =60;
    buy.title = self.title;
    ArticleTypeThreeViewController * miai = [[ArticleTypeThreeViewController alloc]init];
    miai.type =3;
    miai.title = self.title;
    ArticleTypeFourViewController * publish = [[ArticleTypeFourViewController alloc]init];
    publish.type = 102;
    publish.title =self.title;
    [self addChildViewController:supply];
    [self addChildViewController:buy];
    [self addChildViewController:miai];
    [self addChildViewController:publish];
}
- (void)switchController:(int)index
{
    UIViewController *vc = self.childViewControllers[index];
    vc.view.y = 0;
    vc.view.width = self.contentView.width;
    vc.view.height = self.contentView.height-44;
    vc.view.x = vc.view.width * index;
    [self.contentView addSubview:vc.view];

    if (index) {
  [[NSNotificationCenter defaultCenter] postNotificationName:zNSNotificationSwithView object:nil];
    }


}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self click:self.titlesView.subviews[index]];
    [self switchController:index];
}
- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView
{
    [self switchController:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
}
@end
