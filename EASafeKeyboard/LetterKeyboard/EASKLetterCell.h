//
//  EASKNumCell.h
//  CoinApp
//
//  Created by hym on 2019/8/30.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 字母键盘控件类型

 - EAWorldKeyType: 字母
 - EACapitalKeyType: 大写按钮
 - EADeleteKeyType: 删除按钮
 */
typedef NS_ENUM(NSInteger,EALetterKeyType) {
    EAWorldKeyType = 0,
    EACapitalKeyType = 1,
    EADeleteKeyType = 2
};

/**
 点击字母回调

 @param letter 字母
 @param keyType 控件类型
 */
typedef void(^LetterBlock)(NSString *letter,EALetterKeyType keyType);

@interface EASKLetterCell : UICollectionViewCell

/** 显示的标题 */
@property (nonatomic, strong) NSString *title;

/** 点击字母回调 */
@property (nonatomic, copy) LetterBlock letterBlock;

/** 大写开关 */
@property (nonatomic, assign) BOOL isCapital;

@end

NS_ASSUME_NONNULL_END
