//
//  CQVideoToolBar.h
//  TestQQ
//
//  Created by LiDongfeng on 16/3/1.
//  Copyright © 2016年 LuChenChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CQVideoToolBar;

@protocol CQVideoToolBarDelegate <NSObject>

@optional
/**
 *  <点击了底部工具条上的播放/暂停按钮>
 *
 *  @param cqVideoToolBar
 *  @param isplay
 */
- (void)cqVideoToolBarView:(CQVideoToolBar*)cqVideoToolBar didPalyVideo:(BOOL)isplay;
/**
 *  <是否全屏播放视频>
 *
 *  @param cqVideoToolBar
 *  @param isFull
 */
- (void)cqVideoToolBarView:(CQVideoToolBar *)cqVideoToolBar shouldFullScreen:(BOOL)isFull;
/**
 *  <开始拖到滑块>
 *
 *  @param cqVideoToolBar
 *  @param slider
 */
- (void)cqVideoToolBarView:(CQVideoToolBar *)cqVideoToolBar didDragSlider:(UISlider*)slider;
/**
 *  <松开滑块继续播放>
 *
 *  @param cqVideoToolBar
 *  @param slider
 */
- (void)cqVideoToolBarView:(CQVideoToolBar *)cqVideoToolBar didReplayVideo:(UISlider*)slider;
/**
 *  <改变滑块的当前值>
 *
 *  @param cqVideoToolBar
 *  @param slider
 */
- (void)cqVideoToolBarView:(CQVideoToolBar *)cqVideoToolBar didChangeValue:(UISlider*)slider;

@end

@interface CQVideoToolBar : UIView
/**
 *  < 控制条背景图片 >
 */
@property (nonatomic,strong) UIView * bottomView;
/**
 *  <播放的按钮>
 */
@property (nonatomic,strong) UIButton *playBtn;
/**
 *  < 滑块 >
 */
@property (nonatomic,strong) UISlider *playerSlider;
/**
 *  < 全屏或半屏的按钮 >
 */
@property (nonatomic,strong) UIButton *fullBtn;
/**
 *  < timeLabel >
 */
@property (nonatomic,strong) UILabel *timeLabel;
/**
 *  <delegate>
 */
@property (nonatomic,weak) id<CQVideoToolBarDelegate>delegate;
@end
