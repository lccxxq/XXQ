//
//  CQRootRrightViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/10/28.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQRootRrightViewController.h"

@interface CQRootRrightViewController ()
{
    UIView * _bg;
}
@end

@implementation CQRootRrightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * bgView=[[UIView alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
    bgView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:bgView];
    _bg=bgView;
        
    [self viewAnimation];
    
    [self creatTextField];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [super viewWillAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self viewAnimation];
}

-(void)viewAnimation
{
    [UIView animateWithDuration:2   delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAutoreverse |  UIViewAnimationOptionRepeat |  UIViewAnimationOptionBeginFromCurrentState) animations:^{
        _bg.center=self.view.center;
    } completion:^(BOOL finished) {
        _bg.frame=CGRectMake(50, 100, 50, 50);
    }];

}
-(void)applicationDidEnterBackground
{
   [_bg.layer removeAllAnimations];
}

-(void)applicationWillEnterForeground
{
    [self viewAnimation];
}

-(void)creatTextField
{
    UITextField * textField=[[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-150, 100, 100, 30)];
    textField.borderStyle=UITextBorderStyleRoundedRect;
    
    
    [self.view addSubview:textField];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
