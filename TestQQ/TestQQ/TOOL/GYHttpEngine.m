//
//  GYHttpEngine.m
//  PeiCheBaoApp
//
//  Created by 钢源网络 on 15/5/14.
//  Copyright (c) 2015年 GangYuan. All rights reserved.
//

#import "GYHttpEngine.h"
#import "AFNetworking.h"


//#define TEST1 @"http://test1.gougang.com"
//#define TEST56 @"http://56test.gougang.com"
//#define IPADRESS @"http://192.168.1.199:8002/"
//
//#define TEST1_URL [NSString stringWithFormat:@"%@/common/ajax.aspx",TEST1]
//#define TEST1_PORT_URL [NSString stringWithFormat:@"%@:8088/common/ajax.aspx",TEST1]
//#define TEST1_URL_UPLOAD [NSString stringWithFormat:@"%@/common/upload.aspx",TEST1]
//#define TEST1_URL_MERBER [NSString stringWithFormat:@"%@/common/ajax_member.aspx",TEST1]
//
//
//#define TEST56_URL [NSString stringWithFormat:@"%@/api/ajax.aspx",TEST56]
//#define TEST56_URL_MERBER [NSString stringWithFormat:@"%@/api/ajax_member.aspx",TEST56]
//#define TEST56_PORT_URL_MERBER [NSString stringWithFormat:@"%@:8099/api/ajax_member.aspx",TEST56]
//#define TEST56_PORT_URL [NSString stringWithFormat:@"%@:8099/api/ajax.aspx",TEST56]



@implementation GYHttpEngine

//get请求
+(void)getRequestUrl:(NSString*)urlString success:(requestBackData)succ fail:(requestFail)fail{
    
//    int iscon=[self isConnectionAvailable];
//    if (iscon==ConnectionNetworkTypeNotReachable) {
//        [UIAlertView alertViewWithMessage:@"没有网络"];
//        return;
//    }
    AFHTTPRequestOperationManager *manager=[self manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succ(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

+(AFHTTPRequestOperationManager*)manager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html", nil];
    return manager;
}

+(void)postRequestUrl:(NSString*)urlString args:(NSDictionary *)args complete:(complete)complete
{
//    int iscon=[self isConnectionAvailable];
//    if (iscon==ConnectionNetworkTypeNotReachable) {
//        [UIAlertView alertViewWithMessage:@"没有网络"];
//        return;
//    }

    AFHTTPRequestOperationManager * manager=[self manager];
    [manager POST:urlString parameters:args success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complete) {
            complete(error);
        }
    }];
}

//+(void)getUserMessageWithComplete:(complete)complete
//{
//    [self getRequestUrl:[NSString stringWithFormat:@"http://56test.gougang.com/api/ajax_member.aspx?action=getuser&signature=%@",[GYSignatureManager signature]] success:^(NSDictionary *dic) {
//        
//        if (complete) {
//            complete(dic);
//        }
//    } fail:^(NSError *error) {
//
//    }];
//}


//+(ConnectionNetworkType)isConnectionAvailable
//{
//    int isExistenceNetwork = ConnectionNetworkTypeNotReachable;
//    //Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    Reachability *reach = [Reachability reachabilityForInternetConnection];
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            isExistenceNetwork = ConnectionNetworkTypeNotReachable;
//            //     NSLog(@"notReachable");
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = ConnectionNetworkTypeWIFI;
//            //    NSLog(@"WIFI");
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = ConnectionNetworkType3G;
//            //      NSLog(@"3G");
//            break;
//    }
//    return isExistenceNetwork;
//}


@end
