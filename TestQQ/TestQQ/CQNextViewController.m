//
//  CQNextViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/5.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQNextViewController.h"
#import "GLAlertManager.h"
#import "UIColor+NSStringValue.h"
#import "UIAlertController+GYAlert.h"

#define UIColorFromRGB(rgbValue,alpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)alpha]

@interface CQNextViewController ()

@end

@implementation CQNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    int  rgbValue;
//    float alpha;
//    UIColor * color=[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)alpha];
    
   
//    self.view.backgroundColor=[UIColor colorWithStringValue:@"#FF0000"];

    //异步
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //切回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"3333");
//            [UIAlertController alertControllerWithMessage:@"退出重启应用" viewController:self sureBlock:^{
//                //退出程序
////                 exit(0);
//            }];
            
         });
    });
   
    
//    dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"------>1");
//        NSLog(@"------>1");
//        NSLog(@"------>1");
//    });
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    GLAlertManager *manager=[GLAlertManager sharedAlertManager];
//    manager.block=^(){
//        NSLog(@"确认");
//    };
//    [manager alertWithMessage:@"测试测试测试测试测试试测试测试测试测试试测试测试测试测试测试测试" alertCancel:@"取消" alertSure:@"确定" viewController:self alertViewControllerStyle:GLAlertStyleAlert];
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
