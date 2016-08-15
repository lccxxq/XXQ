//
//  CQTabBarController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/3.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQTabBarController.h"
#import "CQSkinManager.h"

@interface CQTabBarController ()

@end

@implementation CQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tabBarController监听ZYSkinManager的currentSkin属性
    
    //NSKeyValueObservingOptionInitial
    //设置监听成功后，立即响应一次监听事件

    [[CQSkinManager sharedSkinManager]addObserver:self forKeyPath:@"currentSkin" options:NSKeyValueObservingOptionInitial context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.tabBar.backgroundImage=[UIImage skinImageWithName:@"tabbar_bg_ios7.png"];
    
    NSInteger count=[self.viewControllers count];
    for (int i=0; i<count; i++) {
        UIViewController * vc=self.viewControllers[i];
        
        switch (i) {
            case 0:
            {
                UITabBarItem * tabBarItem=[[UITabBarItem alloc]initWithTitle:@"" image:[[UIImage skinImageWithName:@"tab_recent_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage skinImageWithName:@"tab_recent_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                
                tabBarItem.badgeValue=@"10";
                vc.tabBarItem=tabBarItem;
            }
                break;
                
            case 1:
            {
                UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage skinImageWithName:@"tab_buddy_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage skinImageWithName:@"tab_buddy_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                
                vc.tabBarItem = tabBarItem;
            }
                break;
                
            case 2:
            {
                UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage skinImageWithName:@"tab_qworld_nor.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage skinImageWithName:@"tab_qworld_press.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                
                vc.tabBarItem = tabBarItem;
            }
                break;
            default:
                break;
        }
         
    }
}
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
