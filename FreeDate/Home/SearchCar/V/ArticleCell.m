#import "ArticleCell.h"
@interface ArticleCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *AppImg;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *date;
@end
@implementation ArticleCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setData:(Article_hitlist_data *)data{
    _data =data;
    self.title.text = data.title;
    self.replyCount.text = [NSString stringWithFormat:@"%ld",data.replyCount];
    self.date.text = [data.date substringToIndex:10];
    NSString * url;
    if (!data.AppImg.length ) {
        if (!data.FirstCoverImg.length) {
            url = [@"https:" stringByAppendingString:data.picUrls];
        }else{
          url = [@"https:" stringByAppendingString:data.FirstCoverImg];
        }
    }else{
        url = [@"" stringByAppendingString:data.AppImg];
    }
    NSLog(@" %@ 图片的URL: %@",data.title,url);
    [self.AppImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"carPlaceholder"] options:(SDWebImageProgressiveDownload)];
}

//-(void)setFrame:(CGRect)frame{
//
//    CGRect Frame = frame;
//    Frame.origin.y = frame.origin.y - 34;
//
//    [super setFrame:Frame];
//}
@end
