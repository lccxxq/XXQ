//
//  CQSkinViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/19.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQSkinViewController.h"
#import "CQSkinManager.h"

@interface CQSkinViewController()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger _lastIndexPath;
}

@end

@implementation CQSkinViewController{
    NSArray* _titlesBundlesAndImages;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
//    _lastIndexPath=1000;
    _titlesBundlesAndImages = @[@[@"默认", @"1111", @"theme_icon.png"], @[@"海洋", @"1110", @"theme_icon_sea.png"], @[@"外星人", @"1114", @"theme_icon_universe.png"], @[@"小黄鸭", @"1108", @"theme_icon_yellowduck.png"], @[@"企鹅", @"1098", @"theme_icon_penguin.png"]];
    UITableView * tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titlesBundlesAndImages count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if ([_titlesBundlesAndImages[indexPath.row][1] integerValue]==[CQSkinManager sharedSkinManager].currentSkin) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            _lastIndexPath=indexPath.row;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    cell.imageView.image=[UIImage imageNamed:_titlesBundlesAndImages[indexPath.row][2]];
    cell.textLabel.text=_titlesBundlesAndImages[indexPath.row][0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_lastIndexPath inSection:0]];
    cell.accessoryType=UITableViewCellAccessoryNone;
    UITableViewCell * cell1=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    cell1.accessoryType=UITableViewCellAccessoryCheckmark;
    _lastIndexPath=indexPath.row;
    
    NSInteger currentSkin=[_titlesBundlesAndImages[indexPath.row][1]integerValue];
    [CQSkinManager sharedSkinManager].currentSkin=currentSkin;
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:currentSkin forKey:@"skin"];
    [userDefaults synchronize];
}
@end
