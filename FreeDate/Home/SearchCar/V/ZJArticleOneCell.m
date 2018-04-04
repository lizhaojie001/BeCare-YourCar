//
//  ZJArticleOneCell.m
//  FreeDate
//
//  Created by macbook pro on 2018/4/3.
//  Copyright © 2018年 macbook pro. All rights reserved.
//

#import "ZJArticleOneCell.h"
@interface ZJArticleOneCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *AppImg;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *date;
@end
@implementation ZJArticleOneCell

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
    self.title.text = data.title;
    self.replyCount.text = [NSString stringWithFormat:@"%ld",data.replyCount];
    NSAssert1(data.date.length>10, @"日期长度小于10 截取报错 = %@", data.date);
    self.date.text = [data.date substringToIndex:10];
    NSString * url;
   if (![data.AppImg hasPrefix:@"https"]) {
       url = [@"https:" stringByAppendingString:data.AppImg];
    }
    else{
        url = data.AppImg;
    }
    [_AppImg setImageWithURLString:url placeholderImageName:@"carPlaceholder"];
    
}

@end
