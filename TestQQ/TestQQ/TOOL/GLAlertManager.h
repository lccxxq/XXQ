//
//  GLAlertManager.h
//  123
//
//  Created by MacBook Pro on 15/11/3.
//  Copyright © 2015年 LCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^sureBlock)();

/** 
 *
 弹出框类型
 */
typedef NS_ENUM(NSInteger, GLAlertStyle) {
    GLAlertStyleAlert,   //普通警告框
    GLAlertStyleActionSheet
};
@interface GLAlertManager : NSObject

@property(nonatomic,copy)sureBlock block;
+(instancetype)sharedAlertManager;
/** 
 *弹出框(适应不同版本)
 */
-(void)alertWithMessage:(NSString *)message alertCancel:(NSString *)cancleTitle alertSure:(NSString *)sureTitle viewController:(UIViewController *)viewController alertViewControllerStyle:(GLAlertStyle)alertStyle;
@end
