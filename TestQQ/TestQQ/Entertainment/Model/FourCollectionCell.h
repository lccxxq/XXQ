//
//  FourCollectionCell.h
//  TestQQ
//
//  Created by LiDongfeng on 15/12/31.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChanelData.h"
#import "OnlineModel.h"

@interface FourCollectionCell : UICollectionViewCell

@property (nonatomic,strong)OnlineModel * onlineData;

@property (nonatomic,strong)ChanelData * data;

@end
