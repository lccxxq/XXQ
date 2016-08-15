//
//  CQEntertainmentViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/15.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQEntertainmentViewController.h"
#import "NetworkSingleton.h"
#import "SDRotationLoopProgressView.h"
#import "URL.h"
#import "NSString+Times.h"
#import "CQchanleData.h"
#import "NSObject+MJKeyValue.h"
#import "NewShowViewCell.h"
#import "TOPdata.h"
#import "SDCycleScrollView.h"
#import "RecommendHeadView.h"
#import "CQMoreViewController.h"
#import "NewShowData.h"
#import "RecommendTableCell.h"
#import "GYHttpEngine.h"

@interface CQEntertainmentViewController()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIGestureRecognizerDelegate,RecommendTableCellDelegate>{
    
    SDCycleScrollView * _headView;
    SDRotationLoopProgressView * _loadView;
    NSMutableArray * _ChanelDatas;
    NSMutableArray * _ChanelDataArray;
    NSMutableArray * _topDataArray;
    NSMutableArray *_imageArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_newDataArray;
    RecommendHeadView *_cellHeadView;
}
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation CQEntertainmentViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self loadChanelData];
    [self loadTopData];
    [self loadNewShowData];
    
    
    [self initHeadView];
    [self initTableView];
    
    _ChanelDatas=[NSMutableArray array];
    _ChanelDataArray=[[NSMutableArray alloc]init];
    _topDataArray=[NSMutableArray array];
    _imageArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    _newDataArray=[NSMutableArray array];
}

- (void)initTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH_, _HEIGHT_-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableHeaderView=_headView;
//    [self.view addSubview:self.tableView];
}
//滑动的顶部scrollow
- (void)initHeadView{
    _headView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _WIDTH_, 200*KWidth_Scale) imagesGroup:_imageArray];
    _headView.titlesGroup=_titleArray;
    _headView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _headView.delegate=self;
    _headView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _headView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    _headView.titleLabelTextFont=[UIFont systemFontOfSize:17];
}
//加载前的load
- (void)showLoadView{
    _loadView=[SDRotationLoopProgressView progressView];
    _loadView.frame=CGRectMake(0, 0, 100*KWidth_Scale, 100*KWidth_Scale);
    _loadView.center=self.view.center;
    [self.view addSubview:_loadView];
}
- (void)hideLoadView{
    [UIView animateWithDuration:0.3 animations:^{
//        [_loadView dismiss];
        [_loadView removeFromSuperview];
    }];
}
- (void)loadChanelData{
//    [self showLoadView];
    NSString *url=[NSString stringWithFormat:@"%@%@",CHANEL_URl,[NSString GetNowTimes]];
    NSLog(@"url===%@",url);
    [[NetworkSingleton sharedManager]getResultWithParameter:nil url:url successBlock:^(id responseBody) {
        NSLog(@"responseBody====%@",responseBody);

        _ChanelDatas=[responseBody objectForKey:@"data"];
        for (NSDictionary * dic in _ChanelDatas) {
            NSMutableArray * array=[NSMutableArray array];
            [array addObject:dic[@"title"]];
            [array addObject:dic[@"cate_id"]];
            [array addObject:[CQchanleData objectArrayWithKeyValuesArray:dic[@"roomlist"]]];
            [_ChanelDataArray addObject:array];
        }
        [self hideLoadView];

        [self.view addSubview:_tableView];
        
    } failureBlock:^(NSString *error) {
         NSLog(@"error==%@",error);
    }];
    
    [GYHttpEngine getRequestUrl:url success:^(NSDictionary *dic) {
        NSLog(@"json====%@",dic);
    } fail:^(NSError *error) {
        NSLog(@"错误===%@",error);
    }];
}
//加载顶部数据
- (void)loadTopData{
    NSDictionary * parameteDic=@{@"aid":@"ios",@"auth":@"97d9e4d3e9dfab80321d11df5777a107",@"client_sys":@"ios",@"time":[NSString GetNowTimes]};
    [[NetworkSingleton sharedManager]getResultWithParameter:parameteDic url:TOP_URl successBlock:^(id responseBody) {
        _topDataArray=[TOPdata objectArrayWithKeyValuesArray:[responseBody objectForKey:@"data"]];
        
        for (TOPdata * topdata in _topDataArray) {
            [_titleArray addObject:topdata.title];
            [_imageArray addObject:topdata.pic_url];
        }
        _headView.imageURLStringsGroup=_imageArray;
        _headView.titlesGroup=_titleArray;
    } failureBlock:^(NSString *error) {
        
    }];
}
//星秀推荐
- (void)loadNewShowData{
    NSString * url=[NSString stringWithFormat:@"%@%@",NEW_URl,[NSString GetNowTimes]];
    [[NetworkSingleton sharedManager]getResultWithParameter:nil url:url successBlock:^(id responseBody) {
        
        _newDataArray=[NewShowData objectArrayWithKeyValuesArray:responseBody[@"data"]];
        NSIndexPath * index=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
    } failureBlock:^(NSString *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_ChanelDataArray.count) {
        NSLog(@"_ChanelDataArray.count==%d",_ChanelDataArray.count);
        return _ChanelDataArray.count;
    }else{
        
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        return 145;
    }else{
        
        return 280*KWidth_Scale;
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString * indentifier=@"NewShowViewCell";
        NewShowViewCell * cell=[tableView dequeueReusableCellWithIdentifier:indentifier];
        if (!cell) {
            cell=[[NewShowViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        [cell setContentView:_newDataArray];
        return cell;
    }else{
        static NSString * identifient=@"RecommendTableCell";
        RecommendTableCell * cell=[tableView dequeueReusableCellWithIdentifier:identifient];
        if (!cell) {
            cell=[[RecommendTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifient];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSArray * array=_ChanelDataArray[indexPath.section-1];
        cell.modelArray=array[2];
        cell.delegate=self;
        cell.tags=(int)indexPath.section-1;
        return cell;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
//区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _cellHeadView=[[RecommendHeadView alloc]init];
    _cellHeadView.tag=section;
    if (section==0) {
        _cellHeadView.more.hidden=YES;
        _cellHeadView.moreImage.hidden=YES;
    }else{
        NSArray * array=_ChanelDataArray[section-1];
        _cellHeadView.title.text=[array firstObject];
        UITapGestureRecognizer * tapHeadView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadView:)];
        tapHeadView.delegate=self;
        [_cellHeadView addGestureRecognizer:tapHeadView];
    }
    return _cellHeadView;
}
- (void)tapHeadView:(UIGestureRecognizer*)sender{
    NSArray * array=_ChanelDataArray[sender.view.tag-1];
    CQMoreViewController * moreVC=[[CQMoreViewController alloc]init];
    moreVC.title=array[0];
    moreVC.cate_id=[array objectAtIndex:1];
    [self.navigationController pushViewController:moreVC animated:YES];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isMemberOfClass:[UIButton class]]) {
        return YES;
    }
    return YES;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

#pragma mark--RecommendTableCellDelegate
- (void)TapRecommendTableCellDelegate:(ChanelData *)chaneldata{
    
}
@end
