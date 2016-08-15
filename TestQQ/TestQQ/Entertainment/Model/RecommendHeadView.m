//
//  RecommendHeadView.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/18.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "RecommendHeadView.h"

@interface RecommendHeadView()

@property (weak, nonatomic) IBOutlet UIImageView *lineView;
@end

@implementation RecommendHeadView

- (instancetype)init{
    self=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHeadView" owner:nil options:nil]firstObject];
    if (self) {
        self.lineView.layer.cornerRadius=5;
        self.lineView.layer.masksToBounds=YES;
        self.title.text=@"新秀推荐";
    }
    return self;
}
@end
