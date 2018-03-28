#import "PellTableViewSelect.h"
#define  LeftView 10.0f
#define  TopToView 10.0f
@interface  PellTableViewSelect()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSArray *selectData;
@property (nonatomic,copy) void(^action)(NSInteger index);
@property (nonatomic,copy) NSArray * imagesData;
@end
PellTableViewSelect * backgroundView;
UITableView * tableView;
CGRect Frame;
@implementation PellTableViewSelect
{
    CGRect Frame;
}
- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       images:(NSArray *)images
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate
{
    Frame = frame;
    if (backgroundView != nil) {
        [PellTableViewSelect hiden];
    }
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    backgroundView = [[PellTableViewSelect alloc] initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.imagesData = images ;
    backgroundView.selectData = selectData;
    backgroundView.backgroundColor = [UIColor colorWithHue:0
                                                saturation:0
                                                brightness:0 alpha:0.1];
    [win addSubview:backgroundView];
    CGFloat W=  [UIScreen mainScreen].bounds.size.width;
     tableView = [[UITableView alloc] initWithFrame:CGRectMake(W/2,64.0 -  20.0 * selectData.count,frame.size.width,40 * selectData.count) style:0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = backgroundView;
    tableView.delegate = backgroundView;
    tableView.layer.cornerRadius = 10.0f;
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform =CGAffineTransformMakeScale(1, 0.0001);
    tableView.rowHeight = 40;
    [win addSubview:tableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
    if (animate == YES) {
        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            backgroundView.alpha = 0.5;
            CGAffineTransform t = CGAffineTransformMakeScale(1.0, 1.0);
            tableView.transform =t;
        }];
    }
}
+ (void)tapBackgroundClick
{
    [PellTableViewSelect hiden];
}
+ (void)hiden
{
    if (backgroundView != nil) {
        [UIView animateWithDuration:0.1 animations:^{
              backgroundView.alpha = 0;
           CGAffineTransform t=  CGAffineTransformMakeScale(1,0.0001);
            tableView.transform =   t;
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            tableView = nil;
            backgroundView = nil;
        }];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"PellTableViewSelectIdentifier";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:Identifier];
    }
    cell.imageView.image = [UIImage imageNamed:self.imagesData[indexPath.row]];
    cell.textLabel.text = _selectData[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.action) {
        self.action(indexPath.row);
    }
    [PellTableViewSelect hiden];
}
#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] set];
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat x =   [UIScreen mainScreen].bounds.size.width/2.0;
    CGFloat y = 64;
    CGContextMoveToPoint(context,
                         x-10, y);
    CGContextAddLineToPoint(context,
                             x , y-10);
    CGContextAddLineToPoint(context,
                            x+10, y);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];  
    [[UIColor whiteColor] setStroke]; 
    CGContextDrawPath(context,
                      kCGPathFillStroke);
}
@end
