//
//  CQSkinManager.m
//  TestQQ
//
//  Created by LiDongfeng on 15/11/4.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQSkinManager.h"


@implementation CQSkinManager

+ (instancetype)sharedSkinManager{
    static CQSkinManager * skinManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        skinManager=[[CQSkinManager alloc]init];
    });
    return skinManager;
}

- (id)init{
    self=[super init];
    if (self) {
        NSUserDefaults * userDefefaults=[NSUserDefaults standardUserDefaults];
        _currentSkin=[userDefefaults integerForKey:@"skin"];
        
        if (_currentSkin==0) {
            _currentSkin=1111;
        }
    }

    return self;
}

@end


@implementation UIImage (Skin)

+ (instancetype)skinImageWithName:(NSString *)name{
    NSInteger bundle=[CQSkinManager sharedSkinManager].currentSkin;
    NSString * path=[NSString stringWithFormat:@"%ld.bundle/%@",bundle,name];
    
    return [UIImage imageNamed:path];
}

@end