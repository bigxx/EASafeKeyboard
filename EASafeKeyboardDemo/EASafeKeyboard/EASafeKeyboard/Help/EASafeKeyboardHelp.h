//
//  EASafeKeyboardHelp.h
//  CoinApp
//
//  Created by hym on 2019/9/2.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+EASafeKeyboard.h"

NS_ASSUME_NONNULL_BEGIN
// 键盘背景色
#define EASKBackgroundColor [UIColor colorWithRed:237/255.0 green:236/255.0 blue:241/255.0 alpha:1.0]

// 文字颜色
#define EASKTitleColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
// 按钮背景色
#define EASKButtonBackgroundColor [UIColor colorWithRed:29/255.0 green:150/255.0 blue:227/255.0 alpha:1.0]
// 间隔、线条颜色
#define EASKSpaceColor [UIColor colorWithRed:230/255.0 green:236/255.0 blue:241/255.0 alpha:1.0]

// 键盘统一圆角
#define EASKLayerRadius 5

@interface EASafeKeyboardHelp : NSObject 

/**
 获取标签栏安全区域高度

 @return 安全区域高度
 */
+ (CGFloat)getTabbarSaveAreaHeight;


/**
 图片按照规定大小添加到视图，并转为UIImage格式

 @param image 图片名称
 @param rect 视图大小
 @param size 图片大小
 @return 图片
 */
+ (UIImage *)convertViewToImage:(NSString *)image rect:(CGRect)rect imageSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
