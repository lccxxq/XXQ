//
//  QRItem.h
//  QRWeiXinDemo
//
//  Created by MacBook Pro on 15/9/1.
//  Copyright (c) 2015年 haoshenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, QRItemType) {
    QRItemTypeQRCode = 0,
    QRItemTypeOther,
};


@interface QRItem : UIButton

@property (nonatomic, assign) QRItemType type;

- (instancetype)initWithFrame:(CGRect)frame
                       titile:(NSString *)titile;
@end
