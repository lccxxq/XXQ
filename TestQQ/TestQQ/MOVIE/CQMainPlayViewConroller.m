//
//  CQMainPlayViewConroller.m
//  TestQQ
//
//  Created by LiDongfeng on 16/2/29.
//  Copyright © 2016年 LuChenChen. All rights reserved.
//

#import "CQMainPlayViewConroller.h"
#import "Masonry.h"
#import "CQVideoPlayView.h"

const NSString * play_url=@"http://7xnujb.com2.z0.glb.qiniucdn.com/%E5%A4%8F%E8%87%B3%E6%9C%AA%E8%87%B301/001.mp4";

@interface CQMainPlayViewConroller ()
@property (nonatomic,strong)CQVideoPlayView * playView;

@end

@implementation CQMainPlayViewConroller

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.playView=[[CQVideoPlayView alloc]init];
    
   
    /**
     *  设置下代理
     */
    [self.view addSubview:self.playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(_WIDTH_ * 9/16);
    }];
    self.navigationController.navigationBarHidden=YES;
    
    // 传一个 AVPlayerItem 如果能够播放视频就会调用play方法
//    [self.playView ];

}

@end
