#import "nswyCategaryController.h"
#import "nswyCategaryCollection.h"
@interface nswyCategaryController ()
@property (nonatomic ) BOOL   flag;
@property (nonatomic,strong) NSMutableIndexSet * IndexSet;
@property (nonatomic ) NSUInteger section;
@end
@implementation nswyCategaryController
static NSString * reuseIdentifier  = @"reuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
#pragma mrak-tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"物种分类";
        cell.detailTextLabel.text = @"cell";
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20   ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        nswyCategaryCollection * categary = [[nswyCategaryCollection alloc]initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:categary animated:YES];
}
- (void)titleBtn:(UIButton*)button{
    button.selected = YES;
    ZJLog(@"self.flag= ==%d",self.flag);
    self.flag = !self.flag;
    ZJlogFunction;
    self.section = button.tag;
    NSIndexSet * sections = [[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:self.IndexSet withRowAnimation:UITableViewRowAnimationFade];
}
- (NSMutableIndexSet *)IndexSet {
	if(_IndexSet == nil) {
		_IndexSet = [[NSMutableIndexSet alloc] init];
        for (int i = 0; i < 6; i ++) {
            [_IndexSet addIndex:i];
        }
	}
	return _IndexSet;
}
@end
