//
//  CQCustomMenuController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/3.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQCustomMenuController.h"
#import "CQSkinManager.h"

@interface CQCustomMenuController (){
    UIImageView * _topImageView;
    UIImageView * _bottomImageView;
}

@end

@implementation CQCustomMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,_HEIGHT_, 200)];
    [self.view addSubview:_topImageView];
    [self.view sendSubviewToBack:_topImageView];
    
    _bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, _HEIGHT_, self.view.bounds.size.height-60)];
    [self.view addSubview:_bottomImageView];
    [self.view insertSubview:_bottomImageView aboveSubview:_topImageView];
    
    [[CQSkinManager sharedSkinManager]addObserver:self forKeyPath:@"currentSkin" options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    _topImageView.image=[UIImage skinImageWithName:@"sidebar_bg.jpg"];
    UIImage * image=[UIImage skinImageWithName:@"sidebar_bg_mask.png"];
    _bottomImageView.image=[image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height-1];
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
