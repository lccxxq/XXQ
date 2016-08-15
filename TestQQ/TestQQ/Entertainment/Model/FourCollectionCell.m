//
//  FourCollectionCell.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/31.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "FourCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface FourCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *onlinePeople;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FourCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setOnlineData:(OnlineModel *)onlineData{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[onlineData.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    self.name.text=onlineData.nickname;
    self.onlinePeople.text=[NSString stringWithFormat:@"%0.1f万",[onlineData.online doubleValue]/10000];
    self.title.text=onlineData.room_name;
}

- (void)setChanelData:(ChanelData *)data{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[data.room_src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"Img_default.png"]];
    self.name.text=data.nickname;
    self.onlinePeople.text=[NSString stringWithFormat:@"%0.1f万",[data.online doubleValue]/10000];
    self.title.text=data.room_name;
}
@end
