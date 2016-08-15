//
//  CQItemsControlView.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/23.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQItemsControlView.h"

@implementation CQItems

- (id)init{
    self=[super init];
    if (self) {
        self.itemWidth=0;
        self.itemFont=[UIFont boldSystemFontOfSize:16];
        self.textColor=[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1];
        self.selectedColor=[UIColor colorWithRed:61/255.0 green:209/255.0 blue:165/255.0 alpha:1];
        self.linePercent=0.8;
        self.lineHeight=2.5;
    }
    return self;
}

@end

@interface CQItemsControlView ()
@property(nonatomic,strong)UIView * line;
@end

@implementation CQItemsControlView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = YES;
        self.tapAnimation = YES;
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray=titleArray;
    if (!_items) {
        NSLog(@"请先设置item");
        return;
    }
    float x=0;
    float y=0;
    float width=_items.itemWidth;
    float height=self.frame.size.height;
    for (int i=0; i<titleArray.count; i++) {
        x=_items.itemWidth * i;
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(x, y, width, height);
        button.tag=100+i;
        button.titleLabel.font=_items.itemFont;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:_items.textColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i==0) {
            [button setTitleColor:_items.selectedColor forState:UIControlStateNormal];
            _currentIndex=0;
            self.line=[[UIView alloc]initWithFrame:CGRectMake(_items.itemWidth*(1-_items.linePercent)/2.0, CGRectGetHeight(self.frame)-_items.lineHeight, _items.itemWidth*_items.linePercent, _items.lineHeight)];
            self.line.backgroundColor=_items.selectedColor;
            [self addSubview:_line];
        }
    }
    self.contentSize=CGSizeMake(width*titleArray.count, height);
}

#pragma mark - 点击事件
- (void)itemButtonClicked:(UIButton *)btn{
    _currentIndex=btn.tag-100;
    if (_tapAnimation) {
        
        //有动画，由call is scrollView 带动线条，改变颜色.感觉来装逼用的 哈哈
        
    }else{
        [self changeItemColor:_currentIndex];
        [self changeItemLine:_currentIndex];
    }
    
    if (_tapItemWithIndex) {
        _tapItemWithIndex(_currentIndex);
    }
}
#pragma mark---改变焦点
//改变文字焦点
- (void)changeItemColor:(NSInteger)index{
    for (int i=0; i<_titleArray.count; i++) {
        UIButton * btn=(UIButton*)[self viewWithTag:i+100];
        [btn setTitleColor:_items.textColor forState:UIControlStateNormal];
        if (index+100==btn.tag) {
            [btn setTitleColor:_items.selectedColor forState:UIControlStateNormal];
        }
    }
}
//改变线条焦点
- (void)changeItemLine:(float)index{
    CGRect rect=_line.frame;
    rect.origin.x=_items.itemWidth*index+_items.itemWidth*(1-_items.linePercent)/2.0;
    _line.frame=rect;
}

//向上取整
- (NSInteger)changeProgressToInteger:(float)x{
    float max=_titleArray.count;
    float min=0;
    NSInteger index=0;
    if (x<min+0.5) {
        index=min;
    }else if (x>=max-0.5) {
        index=max;
    }else{
        index=(x+0.5)/1;
    }
    return index;
}
//移动scrollowView
- (void)changeScrollOfSet:(NSInteger)index{
    float halfWidth=CGRectGetWidth(self.frame)/2.0;
    float scrollWidth=self.contentSize.width;
    float leftSpace=_items.itemWidth*index-halfWidth+_items.itemWidth/2.0;
    if (leftSpace<0) {
        leftSpace=0;
    }
    if (leftSpace>scrollWidth-2*halfWidth) {
        leftSpace=scrollWidth-2*halfWidth;
    }
//    NSLog(@"=====%f",leftSpace);
    [self setContentOffset:CGPointMake(leftSpace, 0) animated:YES];
}
#pragma mark--scrollowViewDelegate中回调

- (void)moveToIndex:(float)x{
    [self changeItemLine:x];
    NSInteger tempIndex=[self changeProgressToInteger:x];
    if (tempIndex !=_currentIndex) {
        [self changeItemColor:tempIndex];
    }
    _currentIndex=tempIndex;
//    NSLog(@"x==%f tempIndex=%ld",x,tempIndex);
    [self changeScrollOfSet:tempIndex];
}

- (void)endMoveToIndex:(float)x{
    [self changeItemColor:x];
    [self changeItemLine:x];
    _currentIndex=x;
    [self changeScrollOfSet:x];
}

@end
