//
//  CQLastViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/4.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQLastViewController.h"
#import "CQNextViewController.h"
#import "AFNetworking.h"
#import "CQItemsControlView.h"

@interface CQLastViewController ()<UIScrollViewDelegate>{
    CQItemsControlView * _itemsControlView;
}

@end

@implementation CQLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    [self monitoringNetworkChange];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * array=@[@"新闻",@"房产",@"体育",@"美女",@"文化",@"历史",@"故事",@"汽车",@"房产",@"体育",@"美女"];
    
    UIScrollView * scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 108.5, _WIDTH_, _HEIGHT_-108.5-49)];
//    scroll.backgroundColor=[UIColor yellowColor];
    scroll.delegate=self;
    scroll.pagingEnabled=YES;
    scroll.contentSize=CGSizeMake(_WIDTH_*array.count, 0);
    
//    for (int i=0; i<array.count; i++) {
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_WIDTH_*i, -64, _WIDTH_, _HEIGHT_-108-54)];
//        label.text = array[i];
//        label.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
//        label.textAlignment = NSTextAlignmentCenter;
//        [scroll addSubview:label];
//    }
    
    
    [self.view addSubview:scroll];
    
    
    CQItems * items=[[CQItems alloc]init];
    items.itemWidth=_WIDTH_/4.0;
    _itemsControlView=[[CQItemsControlView alloc]initWithFrame:CGRectMake(0, 64.5, _WIDTH_, 44)];
    _itemsControlView.items=items;
    _itemsControlView.titleArray=array;    
    _itemsControlView.tapItemWithIndex=^(NSInteger index){
        [scroll scrollRectToVisible:CGRectMake(scroll.frame.size.width*index, 0, scroll.frame.size.width, scroll.frame.size.height) animated:YES];
    };
    [self.view addSubview:_itemsControlView];
}

#pragma mark---UIScrollowViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   float offSet=[self scroll:scrollView];
    [_itemsControlView moveToIndex:offSet];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float offSet=[self scroll:scrollView];
    [_itemsControlView endMoveToIndex:offSet];
}

- (float)scroll:(UIScrollView *)scrollView {
    float offset=scrollView.contentOffset.x;
    offset=offset/CGRectGetWidth(scrollView.frame);
    return offset;
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

/**
 *跳转下一页
 */

/*
- (IBAction)buttonClick:(id)sender {
    CQNextViewController * nextVC=[[CQNextViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
}
 */

- (void)monitoringNetworkChange{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                //                [MHAsiNetworkHandler sharedInstance].networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    [mgr startMonitoring];
}

@end
