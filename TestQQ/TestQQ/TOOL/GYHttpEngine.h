//
//  GYHttpEngine.h
//  PeiCheBaoApp
//
//  Created by 钢源网络 on 15/5/14.
//  Copyright (c) 2015年 GangYuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestBackData)(NSDictionary *dic);
typedef void(^requestFail)(NSError* error);
typedef void(^complete)(id json);

typedef enum {
    /** 没有打开网络 */
    ConnectionNetworkTypeNotReachable,
    /** wifi打开 */
    ConnectionNetworkTypeWIFI,
    /** 3G打开 */
    ConnectionNetworkType3G,
} ConnectionNetworkType;

@interface GYHttpEngine : NSObject

//get请求
+(void)getRequestUrl:(NSString*)urlString success:(requestBackData)succ fail:(requestFail)fail;

//post请求
+(void)postRequestUrl:(NSString*)urlString args:(NSDictionary *)args complete:(complete)complete;

+(void)getUserMessageWithComplete:(complete)complete;

+(ConnectionNetworkType)isConnectionAvailable;

@end
