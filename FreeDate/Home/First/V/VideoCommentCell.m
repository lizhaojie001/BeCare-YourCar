#import "VideoCommentCell.h"
@interface VideoCommentCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *carownerlevelsimg;
@end
@implementation VideoCommentCell
- (void)awakeFromNib {
    [super awakeFromNib];

#if DEBUG
 [self testAmbiguity];
    NSLog(@"所有约束 : %@",    [self zj_allConstains]);
#endif
}



//-(void)setFrame:(CGRect)frame{
//    CGFloat X = 5;
//    CGFloat Y = frame.origin.y+5;
//    CGFloat width = frame.size.width -2*X;
//    CGFloat height = frame.size.height - 6;
//    frame = CGRectMake(X, Y,  width, height );
//    [super setFrame:frame];
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setList:(VideoCommentList *)list{
    _list = list;
    _name.text = list.name;
    _time.text = list.time;
    _content.text =list.content;
    [_carownerlevelsimg sd_setImageWithURL:[NSURL URLWithString:list.carownerlevelsimg] placeholderImage:[UIImage imageNamed:@"avator"]];


}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"图片内容大小 : %@",NSStringFromCGSize(self.carownerlevelsimg.intrinsicContentSize));
   NSLog(@"作者name大小 : %@",NSStringFromCGSize(self.name.intrinsicContentSize));
}


@end
