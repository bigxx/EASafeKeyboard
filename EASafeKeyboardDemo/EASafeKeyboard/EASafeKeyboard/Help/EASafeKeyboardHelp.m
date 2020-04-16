//
//  EASafeKeyboardHelp.m
//  CoinApp
//
//  Created by eAssh on 2019/9/2.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "EASafeKeyboardHelp.h"

@implementation EASafeKeyboardHelp

#pragma mark - Method
// MARK:获取标签栏安全区域高度
+ (CGFloat)getTabbarSaveAreaHeight {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    BOOL isIphoneX = screenWidth >= 375.0f && screenHeight >= 812.0f;
    CGFloat saveAreaHeight = 0;
    if (isIphoneX) {
        saveAreaHeight = 34;
    }
    return saveAreaHeight;
}

// MARK:图片按照规定大小添加到视图，并转为UIImage格式
+ (UIImage *)convertViewToImage:(NSString *)image rect:(CGRect)rect imageSize:(CGSize)size {
    // 向上取整，防止有小数时计算偏差
    rect.size.width = ceilf(rect.size.width);
    rect.size.height = ceilf(rect.size.height);
    // 图片容器
    UIView *containView = [[UIView alloc] initWithFrame:rect];
    containView.backgroundColor = [UIColor whiteColor];

    // 获取图片
    UIImage *bundleImg = [self getImageFromBundle:image];
    
    // UIImageView
    CGFloat orignX = (rect.size.width-size.width)/2;
    CGFloat orignY = (rect.size.height-size.height)/2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(orignX, orignY, size.width, size.height)];
    imageView.image = bundleImg;
    [containView addSubview:imageView];
    
    // 转换为UIImage
    UIImage *imageRet = [[UIImage alloc]init];
    // UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(containView.frame.size, YES, [UIScreen mainScreen].scale);
    [containView.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}

// MARK:从bundle获取图片
+ (UIImage *)getImageFromBundle:(NSString *)imgStr {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EASafeKeyboard" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString *imagePath = [bundle pathForResource:imgStr ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
