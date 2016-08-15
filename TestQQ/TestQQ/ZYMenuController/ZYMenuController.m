//
//  ZYMenuController.m
//  ZYMenuController
//
//  Created by Lixing.wang on 14-10-13.
//  Copyright (c) 2014年 Lixing.wang. All rights reserved.
//

#import "ZYMenuController.h"

typedef NS_ENUM(NSUInteger, ZYMenuControllerState) {
    ZYMenuControllerStateNormal     = 0,//显示中间页面
    ZYMenuControllerStateLeft       = 1,//显示左边页面
    ZYMenuControllerStateRight      = 2,//显示右边页面
};

@interface ZYMenuController () <UIGestureRecognizerDelegate> {
    //能否向左滑动
    BOOL _canPanLeft;
    //能否向右滑动
    BOOL _canPanRight;
    
    //能否允许滑动
    BOOL _panEnabel;
    
    //滑动手势
    UIPanGestureRecognizer* _panGesture;
    
    //点击手势
    UITapGestureRecognizer* _tapGesture;
    
    //当前显示的是哪个页面状态
    ZYMenuControllerState _state;
}

@end

@implementation ZYMenuController

- (void)dealloc {
    self.changeLeftView = nil;
    self.changeRightView = nil;
    self.changeRootView = nil;
    
	[super dealloc];
}

#pragma mark - Overwrite

- (void)viewDidLoad {
    [self.view addSubview:_leftViewController.view];
    [self.view addSubview:_rightViewController.view];
    [self.view addSubview:_rootViewController.view];
    
    //为MenuController添加滑动手势
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    _panGesture.enabled = _panEnabel;
    
    _panGesture.delegate = self;
    
    [self.view addGestureRecognizer:_panGesture];
    
    [_panGesture release];
    
    //为MenuController添加点击手势
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    
    _tapGesture.enabled = NO;
    
    _tapGesture.delegate = self;
    
    [self.view addGestureRecognizer:_tapGesture];
    
    [_tapGesture release];
}

#pragma mark - Public

- (instancetype)initWithRootViewController:(UIViewController* )rootViewController leftViewController:(UIViewController* )leftViewController rightViewController:(UIViewController* )rightViewController {
    
    if (self = [super init]) {
        _rootViewController = rootViewController;
        _leftViewController = leftViewController;
        _rightViewController = rightViewController;
        
        [self addViewController:_rootViewController];
        //右滑显示左界面
        _canPanRight = [self addViewController:_leftViewController];
        //左滑显示右界面
        _canPanLeft = [self addViewController:_rightViewController];
        
        _maxLeftOffset = 220;
        _maxRightOffset = 220;
        
        _panEnabel = YES;
        
        self.transitionStyle = ZYMenuControllerStateNormal;
        
        _duration = 0.3f;
    }
    
    return self;
}

- (void)setPanEnabel:(BOOL)panEnabel {
    _panEnabel = panEnabel;
    
    if (_panGesture) {
        _panGesture.enabled = _panEnabel;
    }
}

- (void)setTransitionStyle:(ZYTransitionStyle)transitionStyle {
    _transitionStyle = transitionStyle;
    
    __block UIViewController* root = _rootViewController;
    __block UIViewController* left = _leftViewController;
    __block UIViewController* right = _rightViewController;
    
    switch (transitionStyle) {
        case ZYTransitionStyleNormal:{
            self.changeRootView = ^(CGFloat x) {
                CGRect frame = root.view.frame;
                frame.origin.x = x;
                root.view.frame = frame;
            };
        }
            break;
        case ZYTransitionStyleZoomRoot:{
            self.changeRootView = ^(CGFloat x) {
                //0.7 - 1.0f
                CGFloat zoomCoefficient = 1.0f - 3 * (labs(x) / (320.0f * 10));
                root.view.layer.transform = CATransform3DScale(CATransform3DIdentity, zoomCoefficient, zoomCoefficient, 1.0f);
                
                CGRect frame = root.view.frame;
                frame.origin.x = x;
                root.view.frame = frame;
            };
            
            self.changeLeftView = nil;
            self.changeRightView = nil;
        }
            break;
        case ZYTransitionStyleZoomSidebar:{
            self.changeLeftView = ^(CGFloat x) {
                //0.9 - 1.0f
                CGFloat zoomCoefficient = 0.9 + (labs(x) / (_maxRightOffset * 10));
                left.view.transform = CGAffineTransformMakeScale( zoomCoefficient, zoomCoefficient);
            };
            
            self.changeRightView = ^(CGFloat x) {
                //0.9 - 1.0f
                CGFloat zoomCoefficient = 0.9 + (labs(x) / (_maxLeftOffset * 10));
                right.view.transform = CGAffineTransformMakeScale( zoomCoefficient, zoomCoefficient);
            };
        }
            break;
        case ZYTransitionStyleQQ:{
            self.changeRootView = ^(CGFloat x) {
                //0.7 - 1.0f
                CGFloat zoomCoefficient = 1.0 - 3 * (labs(x) / (320.0f * 10));
                root.view.transform = CGAffineTransformMakeScale( zoomCoefficient, zoomCoefficient);
                
                CGRect frame = root.view.frame;
                frame.origin.x = x;
                root.view.frame = frame;
            };
            
            self.changeLeftView = ^(CGFloat x) {
                //0.5 - 1.0f
                CGFloat zoomCoefficient = 0.7 + 3 *  (labs(x) / (_maxRightOffset * 10));
                left.view.transform = CGAffineTransformMakeScale( zoomCoefficient, zoomCoefficient);
                
                CGRect frame = left.view.frame;
                frame.origin.x = (x - _maxRightOffset) / 5;
                left.view.frame = frame;
            };
            
            self.changeRightView = ^(CGFloat x) {
                //0.5 - 1.0f
                CGFloat zoomCoefficient = 0.7 + 3 *  (labs(x) / (_maxLeftOffset * 10));
                right.view.transform = CGAffineTransformMakeScale( zoomCoefficient, zoomCoefficient);
                
                CGRect frame = right.view.frame;
                frame.origin.x = (x + _maxLeftOffset) / 5;
                right.view.frame = frame;
            };
        }
            break;
        default:
            break;
    }
}

- (BOOL)panEnabel {
    return _panEnabel;
}

- (void)showRootViewController:(BOOL)animated {
    _state = ZYMenuControllerStateNormal;
    
    [self moveRootViewWithState:_state end:0.0f scale:1.0f animated:YES];
}

- (void)showLeftViewController:(BOOL)animated {
    if ([self canPanRight]) {
        [self moveRootViewWithState:_state end:_maxRightOffset scale:1.0f animated:YES];
    }
}

- (void)showRightViewController:(BOOL)animated {
    if ([self canPanLeft]) {
        [self moveRootViewWithState:_state end:-_maxLeftOffset scale:1.0f animated:YES];
    }
}

#pragma mark - Private

/**
 *  把一个viewController添加到MenuController
 *
 *  @param viewController viewController
 *
 *  @return viewController是否添加成功
 */
- (BOOL)addViewController:(UIViewController* )viewController {
    if (viewController) {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)canPanRight {
    if (_canPanRight) {//允许能向右滑动显示左侧边栏
        if (_state != ZYMenuControllerStateLeft) {
            //当前没有显示左侧边栏
            
            //那么就显示左侧边栏
            _state = ZYMenuControllerStateLeft;
            
            //隐藏右边，显示左边
            _leftViewController.view.hidden = NO;
            _rightViewController.view.hidden = YES;
        }
    }
    
    return _canPanRight;
}

- (BOOL)canPanLeft {
    if (_canPanLeft) {//允许能向左滑动显示右侧边栏
        if (_state != ZYMenuControllerStateRight) {
            //当前没有显示右侧边栏
            
            //那么就显示右侧边栏
            _state = ZYMenuControllerStateRight;
            
            //隐藏左边，显示右边
            _leftViewController.view.hidden = YES;
            _rightViewController.view.hidden = NO;
        }
    }
    
    return _canPanLeft;
}

- (void)updateRootViewOriginX:(CGFloat)x {
    if (_changeRootView) {
        _changeRootView(x);
    }
    
    if (_canPanLeft && _changeRightView) {
        _changeRightView(x);
    }
    
    if (_canPanRight && _changeLeftView) {
        _changeLeftView(x);
    }
}

//end = 终点
//scale = 据终点的长度 ／ 总共移动需要的长度
- (void)moveRootViewWithState:(ZYMenuControllerState)state end:(CGFloat)end scale:(CGFloat)scale animated:(BOOL)animated {
    CGFloat duration = 0.0f;//动画持续时间
    
    if (animated) {//如果需要动画，算出移动剩余的距离需要的时间
        //        duration = scale * _duration ;
        duration = _duration;
    }
    
    //UIViewAnimationOptionCurveEaseIn先慢后快
    //UIViewAnimationOptionCurveEaseOut先快后慢
    
    //UINavigationController
    //push的时候先慢后快
    //pop的时候先快后慢
    
    UIViewAnimationOptions animationOptions = UIViewAnimationOptionCurveLinear;
    
    if (_state == ZYMenuControllerStateNormal) {
        //返回正常状态
        animationOptions = UIViewAnimationOptionCurveEaseOut;
    }else {
        animationOptions = UIViewAnimationOptionCurveEaseIn;
    }
    
    [UIView animateWithDuration:duration delay:0.0f options:animationOptions animations:^{
        [self updateRootViewOriginX:end];
    } completion:^(BOOL finished) {
        if (_state == ZYMenuControllerStateNormal) {
            _tapGesture.enabled = NO;
            
            _rootViewController.view.userInteractionEnabled = YES;
        }else {
            _tapGesture.enabled = YES;
            
            _rootViewController.view.userInteractionEnabled = NO;
        }
    }];
}

#pragma mark - UIGestureRecognizer

- (void)panGestureRecognizer:(UIPanGestureRecognizer* )panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        
    }else if (panGesture.state == UIGestureRecognizerStateChanged) {//每次滑动
        
        //本次移动的距离
        CGFloat width = [panGesture translationInView:panGesture.view].x;
        
        //假如中间界面能够移动，那么经过本次移动后，中间界面的x坐标
        CGFloat x = _rootViewController.view.frame.origin.x + width;
        
        //中间界面能否跟随本次手势移动
        BOOL canPan = NO;
        
        if (x > 0) {//说明是向右滑动，显示的是左侧边栏
            canPan = [self canPanRight];
        }else {//说明是向左滑动，显示的是右侧边栏
            canPan = [self canPanLeft];
        }
        
        //如果能够滑动，那么移动中间的界面
        if (canPan) {
            [self updateRootViewOriginX:x];
        }
        
        //清空每次移动的距离
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
    }else if (panGesture.state == UIGestureRecognizerStateEnded) {//手势结束
        //滑动停止的时候，中间页面的x坐标
        CGFloat x = _rootViewController.view.frame.origin.x;
        
        //终点
        CGFloat end = 0.0f;
        //移动到终点需要多远的距离
        CGFloat scale = 0.0f;
        
        switch (_state) {
            case ZYMenuControllerStateNormal:{
                //显示中间
            }
                break;
            case ZYMenuControllerStateLeft:{
                //显示的左边
                if (x < _maxRightOffset / 2) {//显示左边，向右滑动，x为正数
                    //如果最终坐标小于显示距离的一半
                    //就不显示侧边栏
                    
                    _state = ZYMenuControllerStateNormal;
                    
                    //返回原点，终点即原点
                    //                    scale = x / _maxRightOffset;//移动回原点的距离 / 总长度
                }else {
                    end = _maxRightOffset;
                    
                    //移动到终点的距离 / 总长度
                    //                    scale = (_maxRightOffset - x) / _maxRightOffset;
                }
            }
                break;
            case ZYMenuControllerStateRight:{
                //显示的右边
                if (x > -_maxLeftOffset / 2) {//显示右边，向左滑动，x为负数
                    //如果最终坐标小于显示距离的一半
                    //就不显示侧边栏
                    
                    _state = ZYMenuControllerStateNormal;
                    
                    //返回原点，终点即原点
                    //                    scale = -x / _maxLeftOffset;//移动到原点的距离 / 总长度
                }else {
                    end = -_maxLeftOffset;
                    
                    //移动到终点的距离 / 总长度
                    //                    scale = (x + _maxLeftOffset) / _maxLeftOffset;
                }
            }
                break;
            default:
                break;
        }
        
        //把中间的页面移动到最终的位置
        [self moveRootViewWithState:_state end:end scale:scale animated:YES];
    }
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer* )tapGesture {
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        [self showRootViewController:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];
    
    return CGRectContainsPoint(_rootViewController.view.frame, point);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] && gestureRecognizer == _tapGesture) {
        return NO;
    }
    
    return  YES;
}

@end

@implementation UIViewController (ZYMenuController)

- (ZYMenuController* )menuController {
    if (self.parentViewController == nil) {
        return nil;
    }else if ([self.parentViewController isKindOfClass:[ZYMenuController class]]) {
        return (ZYMenuController* )self.parentViewController;
    }else {
        return self.parentViewController.menuController;
    }
}

@end
