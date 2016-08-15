//
//  RecommendTableCell.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/25.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "RecommendTableCell.h"
#import "ZWCollectionViewFlowLayout.h"
#import "FourCollectionCell.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface RecommendTableCell()<ZWwaterFlowDelegate>
{
    ZWCollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
}

@end

@implementation RecommendTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView{
    _flowLayout=[[ZWCollectionViewFlowLayout alloc]init];
    _flowLayout.colCount=2;
    _flowLayout.colMagrin=5;
    _flowLayout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    _flowLayout.degelate=self;
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _WIDTH_, 280*KWidth_Scale) collectionViewLayout:_flowLayout];
    
    //注册显示cell的类型
    UINib * cellNib=[UINib nibWithNibName:@"FourCollectionCell" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.bounces=NO;
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_collectionView];
    
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 280*KWidth_Scale, _WIDTH_, 1)];
    lineView.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [self addSubview:lineView];	
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FourCollectionCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.data=self.modelArray[indexPath.item];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ChanelData * chanelDataID=self.modelArray[indexPath.item];
    if (_delegate && [_delegate respondsToSelector:@selector(TapRecommendTableCellDelegate:)]) {
        [_delegate TapRecommendTableCellDelegate:chanelDataID];
    }
    NSLog(@"cc:%ld--%ld--%@",(long)indexPath.section,indexPath.item,chanelDataID.room_id);
}
@end
