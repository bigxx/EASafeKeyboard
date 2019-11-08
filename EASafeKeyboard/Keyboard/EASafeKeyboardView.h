//
//  EASafeKeyboardView.h
//  CoinApp
//
//  Created by hym on 2019/8/30.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 安全键盘类型

 - EASKLetterKeyboardType: 字母键盘
 - EASKNumKeyboardyType: 数字键盘
 */
typedef NS_ENUM(NSInteger,EASafeKeyboardType){
    EASKLetterKeyboardType = 0,
    EASKNumKeyboardyType = 1,
};

@protocol EASafeKeyboardDelegate <NSObject>

@optional

/**
 点击了键盘字母/数字

 @param text 字母/数字
 */
- (void)didKeyboardClick:(NSString *)text;

/** 点击了键盘删除键 */
- (void)didKeyboardDelete;

/** 点击了键盘回收键 */
- (void)didKeyboardDismiss;

@end

@interface EASafeKeyboardView : UIView

@property (nonatomic, assign) EASafeKeyboardType keyboardType;
@property (nonatomic, assign) id<EASafeKeyboardDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
