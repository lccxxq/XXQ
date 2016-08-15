//
//  CQSkinManager.h
//  TestQQ
//
//  Created by LiDongfeng on 15/11/4.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

@interface CQSkinManager : NSObject

/**
 * 创建一个单例
 */
+ (instancetype)sharedSkinManager;

@property (nonatomic,assign)NSInteger currentSkin;

@end

@interface UIImage (Skin)
/**
 * 添加一个类别，选图片的路径
 */
+ (instancetype)skinImageWithName:(NSString *)name;

@end