//
//  CQMovieConctroller.m
//  TestQQ
//
//  Created by LiDongfeng on 16/2/23.
//  Copyright © 2016年 LuChenChen. All rights reserved.
//

#import "CQMovieConctroller.h"
#import "NetworkSingleton.h"
#import "ZWCollectionViewFlowLayout.h"
#import "HeaderConst.h"
#import "MJExtension.h"
#import "ITemModel.h"

@interface CQMovieConctroller()<ZWwaterFlowDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * _collectionView;
}
@property (nonatomic,strong)NSMutableArray * dataArray1;
@property (nonatomic,strong)NSMutableArray * dataArray2;
@property (nonatomic,strong)NSMutableArray * dataArray3;
@end

@implementation CQMovieConctroller

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadDataOne];
    [self creatUI];
    
}
/**
 *  懒加载
 *
 *  @return 返回数据的数组
 */
- (NSMutableArray*)dataArray1{
    if (!_dataArray1) {
        self.dataArray1=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray1;
}
- (NSMutableArray*)dataArray2{
    if (!_dataArray2) {
        self.dataArray2=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray2;
}
- (NSMutableArray*)dataArray3{
    if (!_dataArray3) {
        self.dataArray3=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray3;
}
/**
 *  加载数据
 */
- (void)loadDataOne{
    [[NetworkSingleton sharedManager]getResultWithParameter:nil url:@"http://api2.jxvdy.com/search_list?model=video&zone=23&order=random&count=6&attr=2" successBlock:^(id responseBody) {
        NSLog(@"---res=%@",responseBody);
        
      _dataArray1=[ITemModel objectArrayWithKeyValuesArray:responseBody];
        
        NSLog(@"dataArray===%@",self.dataArray1);
        
    } failureBlock:^(NSString *error) {
        
    }];
}
- (void)loadDataTwo{
    [[NetworkSingleton sharedManager]getResultWithParameter:nil url:@"http://api2.jxvdy.com/search_list?model=video&count=6&order=time&direction=1&attr=2" successBlock:^(id responseBody) {
        NSLog(@"---res=%@",responseBody);
        
        _dataArray2=[ITemModel objectArrayWithKeyValuesArray:responseBody];
        
        NSLog(@"dataArray===%@",self.dataArray2);
        
    } failureBlock:^(NSString *error) {
        
    }];
}
- (void)loadDataThird{
    [[NetworkSingleton sharedManager]getResultWithParameter:nil url:@"http://api2.jxvdy.com/search_list?model=video&zone=24&order=random&count=6&attr=2" successBlock:^(id responseBody) {
        NSLog(@"---res=%@",responseBody);
        
        _dataArray3=[ITemModel objectArrayWithKeyValuesArray:responseBody];
        
        NSLog(@"dataArray===%@",self.dataArray3);
         
    } failureBlock:^(NSString *error) {
        
    }];

}
/**
 *  创建collectionView
 */
- (void)creatUI{
    
    ZWCollectionViewFlowLayout * flowLayout=[[ZWCollectionViewFlowLayout alloc]init];
    flowLayout.colCount=2;
    flowLayout.colMagrin=5;
    flowLayout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.degelate=self;
    
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, SpaceHeight, _WIDTH_, _HEIGHT_-SpaceHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.bounces=NO;
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if(section==1){
        return 6;
    }else{
        return 6;
    }

}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

@end
