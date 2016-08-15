//
//  ZYMenuController.h
//  ZYMenuController
//
//  Created by Lixing.wang on 14-10-13.
//  Copyright (c) 2014年 Lixing.wang. All rights reserved.
//

//设置左边的view随着移动距离改变的方法
typedef void(^changeLeftView)(CGFloat x);
//设置右边的view随着移动距离改变的方法
typedef void(^changeRightView)(CGFloat x);
//设置中间的view随着移动距离改变的方法
typedef void(^changeRootView)(CGFloat x);

typedef NS_ENUM(NSUInteger, ZYTransitionStyle) {
    ZYTransitionStyleNormal         = 0,//平移
    ZYTransitionStyleZoomSidebar    = 1,//缩小侧边栏
    ZYTransitionStyleZoomRoot       = 2,//缩小主页面
    ZYTransitionStyleQQ             = 3,//缩小主页面，放大侧边栏，像QQ一样
};



@interface ZYMenuController : UIViewController

/**
 *  创建一个ZYMenuController
 *
 *  @param rootViewController  中间的页面
 *  @param leftViewController  左边的页面
 *  @param rightViewController 右边的页面
 *
 *  @return ZYMenuController对象
 */
- (instancetype)initWithRootViewController:(UIViewController* )rootViewController leftViewController:(UIViewController* )leftViewController rightViewController:(UIViewController* )rightViewController;

//中间的页面
@property (nonatomic, assign, readonly) UIViewController* rootViewController;
//左边的页面
@property (nonatomic, assign, readonly) UIViewController* leftViewController;
//右边的页面
@property (nonatomic, assign, readonly) UIViewController* rightViewController;

//向左滑动的最大距离，默认220
@property (nonatomic) CGFloat maxLeftOffset;
//向右滑动的最大距离，默认220
@property (nonatomic) CGFloat maxRightOffset;

//是否允许滑动
@property (nonatomic) BOOL panEnabel;

//动画方式
@property (nonatomic) ZYTransitionStyle transitionStyle;

//动画时间，默认0.3f
@property (nonatomic) NSTimeInterval duration;

//设置左边的view随着移动距离改变的方法
@property (nonatomic, copy) changeLeftView changeLeftView;

//设置右边的view随着移动距离改变的方法
@property (nonatomic, copy) changeRightView changeRightView;
//设置中间的view随着移动距离改变的方法
@property (nonatomic, copy) changeRootView changeRootView;

/**
 *  显示中间的页面
 *
 *  @param animated 是否使用动画
 */
- (void)showRootViewController:(BOOL)animated;

/**
 *  显示左边的页面
 *
 *  @param animated 是否使用动画
 */
- (void)showLeftViewController:(BOOL)animated;

/**
 *  显示右边的页面
 *
 *  @param animated 是否使用动画
 */
- (void)showRightViewController:(BOOL)animated;

@end

@interface UIViewController (ZYMenuController)

@property (nonatomic, readonly) ZYMenuController* menuController;

@end
