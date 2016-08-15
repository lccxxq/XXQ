//
//  QRView.h
//  QRWeiXinDemo
//
//  Created by MacBook Pro on 15/9/1.
//  Copyright (c) 2015年 haoshenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRMenu.h"

@protocol QRViewDelegate <NSObject>

-(void)scanTypeConfig:(QRItem *)item;

@end
@interface QRView : UIView


@property (nonatomic, weak) id<QRViewDelegate> delegate;
/**
 *  透明的区域
 */
@property (nonatomic, assign) CGSize transparentArea;
/*  移除定时器*/
-(void)removeTimer;
/*  暂停定时器*/
-(void)pauseTimer;
/*  开始定时器*/
-(void)startTimer;
@end
