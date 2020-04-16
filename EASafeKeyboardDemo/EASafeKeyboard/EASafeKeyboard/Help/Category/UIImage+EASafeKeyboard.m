//
//  UIImage+EASafeKeyboard.m
//  EASafeKeyboard
//
//  Created by eAssh on 2019/11/8.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "UIImage+EASafeKeyboard.h"

@implementation UIImage (EASafeKeyboard)

// MARK:根据颜色生成图片
+ (UIImage*)imageWithColor:(UIColor*)color {
    return [self imageWithColor:color andSize:CGSizeMake(1.0f, 1.0f)];
}

// MARK:根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
