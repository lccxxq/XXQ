//
//  GLAlertManager.m
//  123
//
//  Created by MacBook Pro on 15/11/3.
//  Copyright © 2015年 LCC. All rights reserved.
//

#import "GLAlertManager.h"

@interface GLAlertManager ()<UIAlertViewDelegate,UIActionSheetDelegate>


@end

@implementation GLAlertManager
+(instancetype)sharedAlertManager
{
    static GLAlertManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[GLAlertManager alloc]init];
    });
    return manager;
}
-(void)alertWithMessage:(NSString *)message alertCancel:(NSString *)cancleTitle alertSure:(NSString *)sureTitle viewController:(UIViewController *)viewController alertViewControllerStyle:(GLAlertStyle)alertStyle
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED>=80000
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
         UIAlertController * alertController=[UIAlertController alertControllerWithTitle:alertStyle==GLAlertStyleActionSheet ? nil :@"提示" message:message preferredStyle:alertStyle==GLAlertStyleActionSheet ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert];
         if (cancleTitle) {
             UIAlertAction * cancel=[UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:nil];
             [alertController addAction:cancel];
         }
         if (sureTitle) {
             UIAlertAction * ok=[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:_block ? _block : nil];
             [alertController addAction:ok];
         }
         [viewController presentViewController:alertController animated:YES completion:nil];
         _block=nil;
    }else
    {
        if (alertStyle==GLAlertStyleActionSheet) {
            UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:message delegate:self cancelButtonTitle:cancleTitle destructiveButtonTitle:sureTitle otherButtonTitles:nil, nil];
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        }else
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:sureTitle, nil];
            [alertView show];
        }
    }
    
#else
    if (alertStyle==GLAlertStyleActionSheet) {
        UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:message delegate:self cancelButtonTitle:cancleTitle destructiveButtonTitle:sureTitle otherButtonTitles:nil, nil];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:sureTitle, nil];
        [alertView show];
    }
#endif
}
#pragma mark---UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView numberOfButtons]==0) {
        return;
    }
    //点击了确认
    if (buttonIndex==[alertView numberOfButtons]-1) {
        if (_block) {
            _block();
        }
        _block=nil;
    }
}
#pragma mark---UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //点击了确认
    if (buttonIndex==0) {
        if (_block) {
            _block();
        }
         _block=nil;
    }
}
@end
