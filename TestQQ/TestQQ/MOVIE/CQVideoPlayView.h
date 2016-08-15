  //
//  CQVideoPlayView.h
//  TestQQ
//
//  Created by LiDongfeng on 16/2/29.
//  Copyright © 2016年 LuChenChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CQVideoToolBar.h"


@protocol CQVideoPlayDelagate <NSObject>

@optional
/**
 *  <是否全屏播放视频>
 */
- (void)cqViedoToolBarView:(CQVideoToolBar *)cqVideoToolBar shouldFullScreen:(BOOL)isFull;

@end


/**
 *  <播放器的view>
 */
@interface CQVideoPlayView : UIView
/**
 *  <封面图片> *
 */
@property (nonatomic,strong)UIImageView * imageView;
/**
 *  < player >
 */
@property (nonatomic,strong)AVPlayer * player;
/**
 *  <playerItem>
 */
@property (nonatomic,strong,readonly)AVPlayerItem * playerItem;
/**
 *  <底部工具条>
 */
@property (nonatomic,strong)CQVideoToolBar * toolBarView;
/**
 *  <delegate>
 */
@property (nonatomic,weak) id<CQVideoPlayDelagate>delegate;
/**
 *  <播放器播放状态>
 */
@property (nonatomic,assign,getter=ispalying,readonly)BOOL playing;
/**
 *   <切换一个播放的 item>
 */
- (void)replaceAVPlayerItem:(AVPlayerItem *)playerItem;

@end
