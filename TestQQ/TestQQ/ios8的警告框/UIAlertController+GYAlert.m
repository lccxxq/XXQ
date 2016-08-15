//
//  UIAlertController+GYAlert.m
//  导航手势
//
//  Created by LCC on 15/9/22.
//  Copyright © 2015年 GangYuan. All rights reserved.
//

#import "UIAlertController+GYAlert.h"

@implementation UIAlertController (GYAlert)

+(void)alertControllerWithMessage:(NSString *)message viewController:(UIViewController *)viewController sureBlock:(sureBlock)sureBlock
{
    UIAlertController * alertController=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * ok=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:sureBlock];
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
