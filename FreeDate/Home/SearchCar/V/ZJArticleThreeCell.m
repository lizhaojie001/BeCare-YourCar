//
//  ZJArticleThreeCell.m
//  FreeDate
//
//  Created by macbook pro on 2018/4/3.
//  Copyright © 2018年 macbook pro. All rights reserved.
//

#import "ZJArticleThreeCell.h"
@interface ZJArticleThreeCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *FirstImage;
@property (weak, nonatomic) IBOutlet UIImageView *SecoundImage;
@property (weak, nonatomic) IBOutlet UIImageView *ThridImage;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end
@implementation ZJArticleThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(Article_hitlist_data *)data{
    [super setData:data];
    _title.text = data.title;
    _replyCount.text =  [NSString stringWithFormat:@"%ld",data.replyCount];
      NSAssert1(data.date.length>10, @"日期长度小于10 截取报错 = %@", data.date);
    _Date.text = [data.date substringToIndex:10];
    [_FirstImage setImageWithURLString:[@"https:" stringByAppendingString: data.FirstCoverImg] placeholderImageName:@"carPlaceholder"];
    [_SecoundImage setImageWithURLString:[ @"https:" stringByAppendingString: data.SecondCoverImg] placeholderImageName:@"carPlaceholder"];
        [_ThridImage setImageWithURLString:  [@"https:" stringByAppendingString: data.ThirdCoverImg] placeholderImageName:@"carPlaceholder"];

    
}
@end
