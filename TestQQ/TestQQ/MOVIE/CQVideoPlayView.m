//
//  CQVideoPlayView.m
//  TestQQ
//
//  Created by LiDongfeng on 16/2/29.
//  Copyright © 2016年 LuChenChen. All rights reserved.
//

#import "CQVideoPlayView.h"

@interface CQVideoPlayView()

@property (nonatomic,strong)AVPlayerLayer * playerLayer;
@end

@implementation CQVideoPlayView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

        // 封面
        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://7xnujb.com2.z0.glb.qiniucdn.com/%E5%A4%8F%E8%87%B3%E6%9C%AA%E8%87%B301/xzwz_cover.jpg?_=1024"] placeholderImage:[UIImage imageNamed:@"bg_media_default"]];
            imageView;
        });
        self.toolBarView=({
            CQVideoToolBar * toolBar=[[CQVideoToolBar alloc]init];
            //        toolBar.delegate=self;
            [self addSubview:toolBar];
            [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self);
                make.height.mas_equalTo(50);
            }];
            toolBar;
        });
        self.player=[[AVPlayer alloc]init];
        self.playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
        [self.imageView.layer addSublayer:self.playerLayer];
     }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.toolBarView.hidden =! self.toolBarView.hidden;
}
/**
 *  layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame=self.bounds;
}
@end
