//
//  CQItemsControlView.h
//  TestQQ
//
//  Created by LiDongfeng on 15/11/23.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQItems : NSObject

@property(nonatomic,assign)float itemWidth;
@property(nonatomic,assign)float linePercent;
@property(nonatomic,assign)float lineHeight;
@property(nonatomic,strong)UIFont * itemFont;
@property(nonatomic,strong)UIColor * textColor;
@property(nonatomic,strong)UIColor * selectedColor;

@end

typedef void(^CQItemsControlViewBlock)(NSInteger index);

@interface CQItemsControlView : UIScrollView

@property(nonatomic,strong)CQItems * items;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,assign)BOOL tapAnimation;
@property(nonatomic,readonly)NSInteger currentIndex;
@property(nonatomic,copy)CQItemsControlViewBlock tapItemWithIndex;

- (void)moveToIndex:(float)x;

- (void)endMoveToIndex:(float)x;

@end
