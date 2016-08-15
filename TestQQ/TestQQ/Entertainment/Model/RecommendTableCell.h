//
//  RecommendTableCell.h
//  TestQQ
//
//  Created by LiDongfeng on 15/12/25.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChanelData;

@protocol RecommendTableCellDelegate <NSObject>

- (void)TapRecommendTableCellDelegate:(ChanelData *)chaneldata;

@end

@interface RecommendTableCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *modelArray;

@property(nonatomic,assign)int  tags; //所在section

@property(nonatomic,assign)id delegate;

@end
