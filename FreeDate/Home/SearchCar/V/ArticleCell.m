#import "ArticleCell.h"
 
@implementation ArticleCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setData:(Article_hitlist_data *)data{
    _data =data;
}
@end
