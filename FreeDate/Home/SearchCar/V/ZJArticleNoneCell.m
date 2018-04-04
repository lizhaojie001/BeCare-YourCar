//
//  ZJArticleNoneCell.m
//  FreeDate
//
//  Created by macbook pro on 2018/4/3.
//  Copyright © 2018年 macbook pro. All rights reserved.
//

#import "ZJArticleNoneCell.h"
@interface ZJArticleNoneCell()
@property (weak, nonatomic) IBOutlet UILabel *replyCOunt;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@end
@implementation ZJArticleNoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(Article_hitlist_data *)data{
//    _data = data;
    [super setData:data];
    _title.text = data.title;
    _replyCOunt.text =  [NSString stringWithFormat:@"%ld",data.replyCount];
    NSAssert1(data.date.length>10, @"日期长度小于10 截取报错 = %@", data.date);
    _date.text = [data.date substringToIndex:10];

}
@end
