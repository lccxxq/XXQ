//
//  CQFriendCircleViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/27.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQFriendCircleViewController.h"
#import "CQFriendTableViewCell.h"
#import "SDRefresh.h"
#import "SDRefreshView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface CQFriendCircleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SDRefreshFooterView * _refreshFooter;
    SDRefreshHeaderView * _refreshHeader;
}
@property (nonatomic,strong)NSMutableArray * modelArray;
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation CQFriendCircleViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self creatModelsWithCount:10];
    [self creatTableView];
    
    
    __weak typeof(self)weakSelf=self;
    _refreshFooter=[SDRefreshFooterView refreshView];
    [_refreshFooter addToScrollView:_tableView];
    
    _refreshHeader=[SDRefreshHeaderView refreshView];
    [_refreshHeader addToScrollView:_tableView];
    
    [_refreshHeader beginRefreshingAction];
    //下拉刷新
    __weak typeof(_refreshHeader)weakRefreshHeader=_refreshHeader;
    _refreshHeader.beginRefreshingOperation=^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf creatModelsWithCount:2];
//            [weakSelf.tableView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    //上拉加载
    __weak typeof(_refreshFooter)weakRefreshFooter=_refreshFooter;
    _refreshFooter.beginRefreshingOperation=^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf creatModelsWithCount:10];
            [weakSelf.tableView reloadData];
            [weakRefreshFooter endRefreshing];
            
        });
    };
}

- (void)creatTableView{
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}
- (void)creatModelsWithCount:(NSInteger)count{
    if (!_modelArray) {
        _modelArray=[[NSMutableArray alloc]init];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"lcc_iOS",
                            @"风口上的人",
                            @"当今世界网名都不好起了",
                            @"我叫陆晨晨",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     ];
    
    for (int i=0; i<count; i++) {
        int iconRandomIndex=arc4random_uniform(5);
        int nameRandomIndex=arc4random_uniform(5);
        int contentRandomIndex=arc4random_uniform(5);
        int picRandomIndex=arc4random_uniform(5);
        
        CQFriendModel * friend=[[CQFriendModel alloc]init];
        friend.iconName=[iconImageNamesArray objectAtIndex:iconRandomIndex];
        friend.name=[namesArray objectAtIndex:nameRandomIndex];
        friend.content=[textArray objectAtIndex:contentRandomIndex];
        
        //模拟有或者没有图片
        int random=arc4random_uniform(100);
        if (random <=80) {
            friend.picName=[picImageNamesArray objectAtIndex:picRandomIndex];
        }
        [self.modelArray addObject:friend];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤1 * >>>>>>>>>>>>>>>>>>>>>>>>
    [_tableView startAutoCellHeightWithCellClass:[CQFriendTableViewCell class] contentViewWidth:_WIDTH_];
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQFriendTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[CQFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.model=self.modelArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [_tableView cellHeightForIndexPath:indexPath model:self.modelArray[indexPath.row] keyPath:@"model"];
}

@end
