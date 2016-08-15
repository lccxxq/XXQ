//
//  CQLeftViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/3.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQLeftViewController.h"
#import "CQSkinViewController.h"
#import "ZYMenuController.h"
#import "CQFriendCircleViewController.h"
#import "CQSettingViewController.h"
#import "CQEntertainmentViewController.h"
#import "CQScanLifeViewController.h"

@interface CQLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     NSArray* _titlesAndImages;
}
@end

@implementation CQLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatUI];
}
- (void)creatUI{
    _titlesAndImages = @[@[@"开通会员", @"sidebar_vip.png"], @[@"QQ钱包", @"sidebar_purse.png"], @[@"网上营业厅", @"sidebar_business.png"], @[@"个性装饰", @"sidebar_decoration.png"], @[@"我的朋友圈", @"sidebar_favorit.png"], @[@"我的相册", @"sidebar_album.png"], @[@"我的娱乐", @"sidebar_file.png"],@[@"   我的设置", @"sidebar_setting.png"]];
    
    self.view.backgroundColor=[UIColor clearColor];
    UIImageView * headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 74, 64, 64)];
    headImageView.image=[UIImage imageNamed:@"aio_face_manage_cover_default.png"];
    headImageView.layer.cornerRadius=32;
    headImageView.clipsToBounds=YES;
    [self.view addSubview:headImageView];
    
    UILabel * nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+10, 94, 64, 30)];
    nameLabel.text=@"lcc";
    nameLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UIButton * scanLifeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    scanLifeButton.frame=CGRectMake(CGRectGetMaxX(nameLabel.frame)+5, 90, 60, 40);
    [scanLifeButton setTitle:@"二维码" forState:UIControlStateNormal];
    [scanLifeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scanLifeButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [scanLifeButton addTarget:self action:@selector(scanLifeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanLifeButton];
    
    UIView * lineView1=[[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(headImageView.frame)+5, self.view.bounds.size.width-150, 0.5)];
    lineView1.backgroundColor=[UIColor colorWithRed:41.0f / 255.0f green:66.0f / 255.0f blue:81.0f / 255.0f alpha:0.9f];
    [self.view addSubview:lineView1];
    UITextField * signature=[[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(lineView1.frame)+1, self.view.bounds.size.width-150, 30)];
    signature.borderStyle=UITextBorderStyleNone;
    signature.placeholder=@"请编辑个性签名";
    [signature setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [signature setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    signature.textColor=[UIColor whiteColor];
    [self.view addSubview:signature];
    UIView * lineView2=[[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(signature.frame)+1, self.view.bounds.size.width-150, 0.5)];
    lineView2.backgroundColor=[UIColor colorWithRed:41.0f / 255.0f green:66.0f / 255.0f blue:81.0f / 255.0f alpha:0.9f];
    [self.view addSubview:lineView2];
    
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(lineView2.frame)+1, self.view.bounds.size.width-150, self.view.bounds.size.height-CGRectGetMaxY(lineView2.frame)-89) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator=NO;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titlesAndImages count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.textColor=[UIColor whiteColor];
        UIView * view=[[UIView alloc]initWithFrame:CGRectMake(25, 0, _WIDTH_-150, 0.5)];
        view.backgroundColor=[UIColor colorWithRed:48.0f / 255.0f green:54.0f / 255.0f blue:58.0f / 255.0f alpha:1.0f];
        view.tag = 1;
        [cell.contentView addSubview:view];
        
        UIView * seleceBackgroundView=[[UIView alloc]initWithFrame:CGRectZero];
        seleceBackgroundView.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.5];
        cell.selectedBackgroundView=seleceBackgroundView;
    }
    UIView * view=[cell.contentView viewWithTag:1];
    if (indexPath.row==4) {
        view.hidden=NO;
    }else{
        view.hidden=YES;
    }
    
    cell.textLabel.text=_titlesAndImages[indexPath.row][0];
    cell.imageView.image=[UIImage imageNamed:_titlesAndImages[indexPath.row][1]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        CQSkinViewController * skinVC=[[CQSkinViewController alloc]init];
        skinVC.hidesBottomBarWhenPushed=YES;
        [self findTabBarViewController:skinVC];
    }
    if (indexPath.row==4) {
        CQFriendCircleViewController * friendVC=[[CQFriendCircleViewController alloc]init];
        friendVC.hidesBottomBarWhenPushed=YES;
        [self findTabBarViewController:friendVC];
    }
    if (indexPath.row==6) {
        CQEntertainmentViewController * entertainmentVC=[[CQEntertainmentViewController alloc]init];
        entertainmentVC.hidesBottomBarWhenPushed=YES;
        [self findTabBarViewController:entertainmentVC];
    }
    if (indexPath.row==7) {
        CQSettingViewController * settingVC=[[CQSettingViewController alloc]init];
        settingVC.hidesBottomBarWhenPushed=YES;
        [self findTabBarViewController:settingVC];
    }
}
- (void)findTabBarViewController:(UIViewController *)viewController{
    ZYMenuController * mc=self.menuController;
    UITabBarController * tab=(UITabBarController*)mc.rootViewController;
    UINavigationController * nav=(UINavigationController*)tab.selectedViewController;
    [nav pushViewController:viewController animated:YES];
    [mc showRootViewController:YES];

}
- (void)scanLifeButtonClick{
    CQScanLifeViewController * scanVC=[[CQScanLifeViewController alloc]init];
    scanVC.hidesBottomBarWhenPushed=YES;
    [self findTabBarViewController:scanVC];
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
