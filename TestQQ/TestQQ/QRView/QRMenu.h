//
//  QRMenu.h
//  QRWeiXinDemo
//
// Created by MacBook Pro on 15/9/1.
//  Copyright (c) 2015年 haoshenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRItem.h"


typedef void(^QRMenuDidSelectedBlock)(QRItem *item);

@interface QRMenu : UIView

@property (nonatomic, copy) QRMenuDidSelectedBlock didSelectedBlock;

- (instancetype)initWithFrame:(CGRect)frame;
@end
