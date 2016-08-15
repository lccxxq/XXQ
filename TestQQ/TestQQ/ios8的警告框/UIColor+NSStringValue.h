//
//  UIColor+NSStringValue.h
//  TestQQ
//
//  Created by LiDongfeng on 15/11/11.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NSStringValue)
/**
 *颜色值 # 转 成RGB的方法
 */
+ (UIColor *)colorWithStringValue:(NSString *)stringValue;
@end
