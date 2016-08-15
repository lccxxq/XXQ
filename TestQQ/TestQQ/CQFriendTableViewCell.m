//
//  CQFriendTableViewCell.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/27.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQFriendTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation CQFriendTableViewCell
{
    UIImageView * _view0;
    UILabel * _view1;
    UILabel * _view2;
    UIImageView * _view3;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    _view0=[UIImageView new];
    _view0.backgroundColor=[UIColor redColor];
    
    _view1=[UILabel new];
    _view1.textColor=[UIColor lightGrayColor];
    _view1.font=[UIFont systemFontOfSize:16];
    
    _view2=[UILabel new];
    _view2.textColor=[UIColor grayColor];
    _view2.font=[UIFont systemFontOfSize:16];
    
    _view3=[UIImageView new];
    _view3.backgroundColor=[UIColor orangeColor];
    
    [self.contentView addSubview:_view0];
    [self.contentView addSubview:_view1];
    [self.contentView addSubview:_view2];
    [self.contentView addSubview:_view3];
    
    _view0.sd_layout.widthIs(40).heightIs(40).topSpaceToView(self.contentView,10).leftSpaceToView(self.contentView,10);
    
    _view1.sd_layout.topEqualToView(_view0).leftSpaceToView(_view0,10).rightSpaceToView(self.contentView,10).heightRatioToView(_view0,0.4);
    
    _view2.sd_layout.topSpaceToView(_view1,10).leftEqualToView(_view1).rightSpaceToView(self.contentView,10).autoHeightRatio(0);
    
    _view3.sd_layout.topSpaceToView(_view2,10).leftEqualToView(_view2).widthRatioToView(_view2,0.7);
}

- (void)setModel:(CQFriendModel *)model{
    _model=model;
    _view0.image=[UIImage imageNamed:model.iconName];
    _view1.text=model.name;
    _view2.text=model.content;
    
    CGFloat bottomMargin=0;
    UIImage * pic=[UIImage imageNamed:model.picName];
    if (pic.size.width>0) {
        CGFloat scale=pic.size.height/pic.size.width;
        _view3.sd_layout.autoHeightRatio(scale);
        _view3.image=pic;
        bottomMargin=10;
    }else{
        _view3.sd_layout.autoHeightRatio(0);
    }
    
    //高度自适应cell设置步骤
    [self setupAutoHeightWithBottomView:_view3 bottomMargin:bottomMargin];
}

@end
