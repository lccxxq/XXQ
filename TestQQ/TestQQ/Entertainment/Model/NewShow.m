//
//  NewShow.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/24.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "NewShow.h"

@implementation NewShow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self=[[[NSBundle mainBundle]loadNibNamed:@"NewShow" owner:nil options:nil]firstObject];
    if (self) {
        self.headImage.layer.cornerRadius=self.headImage.frame.size.width/2;
        self.headImage.layer.masksToBounds=YES;
    }
    return self;
}
@end
