//
//  EASKLetterKeyboardView.h
//  CoinApp
//
//  Created by eAssh on 2019/9/2.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EASKLetterKeyboardDelegate <NSObject>

@optional

/** 切换数字键盘 */
- (void)didSwitchNumPad;

/**
 点击了字母

 @param letter 字母
 */
- (void)didLetterKeyboardClick:(NSString *)letter;

/** 点击了字母键盘的删除键 */
- (void)didLetterKeyboardDelete;

/** 点击了字母键盘的键盘回收 */
- (void)didLetterKeyboardClickDismiss;

@end

@interface EASKLetterKeyboardView : UIView

@property (nonatomic, assign) id<EASKLetterKeyboardDelegate>lkDelegate;

@end

NS_ASSUME_NONNULL_END
