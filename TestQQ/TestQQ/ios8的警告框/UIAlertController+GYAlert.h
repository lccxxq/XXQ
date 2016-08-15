//
//  UIAlertController+GYAlert.h
//  导航手势
//
//  Created by LCC on 15/9/22.
//  Copyright © 2015年 GangYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sureBlock)();

@interface UIAlertController (GYAlert)
/**
 *ios8 警告框
 */
+(void)alertControllerWithMessage:(NSString *)message viewController:(UIViewController *)viewController sureBlock:(sureBlock)sureBlock;

@end
