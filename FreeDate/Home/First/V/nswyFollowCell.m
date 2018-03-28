#import "nswyFollowCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "nswyMVViewController.h"
@interface nswyFollowCell()
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property (weak, nonatomic) IBOutlet UILabel *detialLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@end
@implementation nswyFollowCell
-(void)setCar:(Car *)car{
    _car =car;
    _titleLabel.text = car.seriesname;
    _detialLabel.text = car.price;
    [_carImageView sd_setImageWithURL:[NSURL URLWithString:car.img] placeholderImage:[UIImage imageNamed:@"占位图片"]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
