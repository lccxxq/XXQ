//
//  CQProduceQRcodeViewController.m
//  TestQQ
//
//  Created by LiDongfeng on 15/12/29.
//  Copyright © 2015年 LuChenChen. All rights reserved.
//

#import "CQProduceQRcodeViewController.h"

@interface CQProduceQRcodeViewController ()
@property (nonatomic,strong)UIImageView * imageView;
@end

@implementation CQProduceQRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"二维码展示";
    self.view.backgroundColor=[UIColor whiteColor];
    // 1.创建一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.设置默认的属性
    [filter setDefaults];
    
    // 3.给滤镜设置数据
    //https://itunes.apple.com/cn/app/shen-tong-de-tie-zhi-jia/id954200369?mt=8
//    NSString *string = @"http://www.baidu.com";
    
    NSData *data = [self.metadataObjectString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取出输出的数据
    CIImage *outputImage = [filter outputImage];
    
    // 5.设置到imageView上面
    // self.imageView.image = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];

}

- (UIImageView*)imageView{
    if (! _imageView ) {
        _imageView=[[UIImageView alloc]init];
        _imageView.center=self.view.center;
        _imageView.bounds=CGRectMake(0, 0, 150, 150);
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
