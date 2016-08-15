//
//  UIColor+NSStringValue.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/11.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "UIColor+NSStringValue.h"

@implementation UIColor (NSStringValue)

+ (UIColor *)colorWithStringValue:(NSString *)stringValue{
    NSMutableString * color=[[NSMutableString alloc]initWithString:stringValue];
    
    // 转换成标准16进制数
    [color replaceCharactersInRange:[color rangeOfString:@"#" ] withString:@"0x"];
    
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    
    //string转color
    UIColor * wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return wordColor;
}

@end
