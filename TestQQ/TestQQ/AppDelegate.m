//
//  AppDelegate.m
//  TestQQ
//
//  Created by LiDongfeng on 15/10/23.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYMenuController.h"
#import "CQLeftViewController.h"
#import "CQCustomMenuController.h"
#import "Reachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIStoryboard * storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * tabController=storyboard.instantiateInitialViewController;
    
    CQLeftViewController * leftVC=[[CQLeftViewController alloc]init];
    
    
    ZYMenuController * menu=[[CQCustomMenuController alloc]initWithRootViewController:tabController leftViewController:leftVC rightViewController:nil];
    menu.transitionStyle=ZYTransitionStyleQQ;
    menu.maxRightOffset = 250.0f;
    menu.panEnabel=YES;
    self.window.rootViewController=menu;

    //监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                                 name:@"kNetworkReachabilityChangedNotification" object:nil];
    
    
    /**
     *  多线程啦！
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self methodA];
        });
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self methodB];
        });
    });
    
    
    
    /**
     *  多个请求完成后再执行某一个请求
     */
    dispatch_group_async(dispatch_group_create(),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //加载图片1；
    });
    
    dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //加载图片2；
    });
    dispatch_group_notify(dispatch_group_create(), dispatch_get_main_queue(), ^{
        //合并图片1，2；
    });

    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
    

    //判断先前我们设置的唯一标识
    if([shortcutItem.type isEqualToString:@"com.cqjr.TestQQ"]){
        NSArray *arr = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
    }
}

//禁用第三方键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    return NO;
}
//通知网络状态
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currentReach = [note object];
    NSParameterAssert([currentReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [currentReach currentReachabilityStatus];
    
    if (status == NotReachable)
    {
        NSLog(@"没网络");
//        UIAlert *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AppName",nil)
//                                                    message: NSLocalizedString (@"NotReachable",nil);
//                                                   delegate:nil cancelButtonTitle:@"YES"
//                                          otherButtonTitles:nil];
//        
//        [alert show];
//        [alert release];
        
    }
}
+ (BOOL)isEnableWIFI

{
    
//    return ([[Reachability reachabiliyForLocalWIFI] currentReachabilityStatus] != NotReachable);
    return YES;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   
}

@end
