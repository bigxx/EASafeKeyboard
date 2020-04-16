//
//  UIImage+EASafeKeyboard.h
//  EASafeKeyboard
//
//  Created by eAssh on 2019/11/8.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (EASafeKeyboard)

/**
 根据颜色生成图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
