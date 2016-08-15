//
//  CQScanLifeViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/29.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQScanLifeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRView.h"
#import "GLAlertManager.h"
#import "CQProduceQRcodeViewController.h"

@interface CQScanLifeViewController ()<AVCaptureMetadataOutputObjectsDelegate,QRViewDelegate>

@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureMetadataOutput *outPut;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@property(nonatomic,strong)QRView *qrRectView;


@end

@implementation CQScanLifeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开启定时器
    [self.qrRectView startTimer];
    //延迟加载
    [self performSelector:@selector(scanQRcode) withObject:nil afterDelay:0.1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)scanQRcode
{
    //1.创建捕捉会话
    self.session=[[AVCaptureSession alloc]init];
    //2.创建输入源
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil)
    {
        GLAlertManager *manager=[GLAlertManager sharedAlertManager];
        manager.block=^(){
            NSLog(@"确认");
        };
        [manager alertWithMessage:@"未检测到相机" alertCancel:@"取消" alertSure:@"确定" viewController:self alertViewControllerStyle:GLAlertStyleAlert];

        return;
    }
    AVCaptureDeviceInput *input=[AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if ([self.session canAddInput:input])
    {
        [self.session addInput:input];
    }
    //3.创建输出源
    _outPut=[[AVCaptureMetadataOutput alloc]init];
    [ _outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([self.session canAddOutput:_outPut])
    {
        [self.session addOutput:_outPut];
    }
    //设置条码类型，一定要在addOutput后面设置此属性，否则crash
    [_outPut setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //4.创建预览图层
    _preview=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    [_preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    _preview.frame=self.view.bounds;
    [self.view.layer addSublayer:_preview];
    //5.开始扫描
    [self.session startRunning];
    
    /*  下面是中间透明的view，以及上下移动的line，且设置可扫描区域为中间区域*/
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    _qrRectView = [[QRView alloc] initWithFrame:screenRect];
    _qrRectView.transparentArea = CGSizeMake(200, 200);
    _qrRectView.backgroundColor = [UIColor clearColor];
    _qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    _qrRectView.delegate = self;
    [self.view addSubview:_qrRectView];
    //修正扫描区域
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat screenWidth = self.view.frame.size.width;
    CGRect cropRect = CGRectMake((screenWidth - _qrRectView.transparentArea.width) / 2,
                                 (screenHeight - _qrRectView.transparentArea.height) / 2,
                                 _qrRectView.transparentArea.width,
                                 _qrRectView.transparentArea.height);
    
    [_outPut setRectOfInterest:CGRectMake(cropRect.origin.y / screenHeight,
                                          cropRect.origin.x / screenWidth,
                                          cropRect.size.height / screenHeight,
                                          cropRect.size.width / screenWidth)];
    //创建一个闪光灯按钮
    UIButton *lightOn=[UIButton buttonWithType:UIButtonTypeCustom];
    [lightOn setTitle:@"开启闪光灯" forState:UIControlStateNormal];
    lightOn.frame=CGRectMake(self.view.center.x-50, self.view.center.y+200, 100, 30);
    [lightOn addTarget:self action:@selector(openOrCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightOn];
}
#pragma mark -闪光灯点击事件
-(void)openOrCloseClick
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //先判断是否有闪光灯
    if (![device hasTorch]) {
        NSLog(@"no torch");
    }else{ //lockForConfiguration跟unlockForConfiguration是配对的API
        //呼叫lockForConfiguration就可以控制硬件了
        [device lockForConfiguration:nil];
        if (device.torchMode==AVCaptureTorchModeOff) {
            [device setTorchMode: AVCaptureTorchModeOn];
        }
        else
        {
            [device setTorchMode: AVCaptureTorchModeOff];
        }
        //控制完毕后要呼叫unlockForConfiguration
        [device unlockForConfiguration];
    }
}
#pragma mark QRViewDelegate
-(void)scanTypeConfig:(QRItem *)item {
    
    if (item.type == QRItemTypeQRCode) {
        _outPut.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        
    } else if (item.type == QRItemTypeOther) {
        
        //设置扫描类型为条形码
        _outPut.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
                                            AVMetadataObjectTypeEAN8Code,
                                        AVMetadataObjectTypeCode128Code,
                                        AVMetadataObjectTypeQRCode];
    }
}
#pragma mark---输出源代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *getString=nil;
    if ([metadataObjects count]>0)
    {
        AVMetadataMachineReadableCodeObject *metadataObject=metadataObjects[0];
        NSLog(@"stringValue===%@",metadataObject.stringValue);
        getString=metadataObject.stringValue;
        
        CQProduceQRcodeViewController * produceVC=[[CQProduceQRcodeViewController alloc]init];
        produceVC.metadataObjectString=getString;
        [self.navigationController pushViewController:produceVC animated:YES];
        
        [self.session stopRunning];
        [self.qrRectView removeTimer];
        //[self.myLayer removeFromSuperlayer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
