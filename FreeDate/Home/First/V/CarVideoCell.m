#import "CarVideoCell.h"
@interface CarVideoCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *authname;
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (weak, nonatomic) IBOutlet UILabel *playtime;
@end
@implementation CarVideoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = ZJThemeColor.CGColor;
    self.layer.borderWidth = 2.0;
}
-(void)setFrame:(CGRect)frame{
    CGFloat X = 5;
    CGFloat Y = frame.origin.y+5;
    CGFloat width = ZJScreenW -2*X;
    CGFloat height = frame.size.height - 6;
    frame = CGRectMake(X, Y,  width, height );
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setCarvideo:(CarVideo *)carvideo{
    _carvideo = carvideo;
    if (carvideo.playtime.length) {
        self.playtime.hidden =NO;
        self.playtime.text = carvideo.playtime;
    }else{
        self.playtime.hidden = YES;
    }
    if (carvideo.playcount.length) {
        self.playcount.text = carvideo.playcount;
    }
    self.title.text = carvideo.title;
    if (!carvideo.authname.length) {
        self.authname.text = @"匿名老司机";
    }else{
        self.authname.text = carvideo.authname;
    }
    [self.headimg sd_setImageWithURL:[NSURL URLWithString:carvideo.headimg] placeholderImage:[UIImage imageNamed:@"carer"]];
    [self.imgurl sd_setImageWithURL:[NSURL URLWithString:carvideo.imgurl] placeholderImage:[UIImage imageNamed:@"carPlaceholder"] options:SDWebImageProgressiveDownload];
}
@end
