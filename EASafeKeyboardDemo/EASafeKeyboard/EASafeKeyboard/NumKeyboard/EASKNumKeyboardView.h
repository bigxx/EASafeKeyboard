//
//  EASKNumKeyboardView.h
//  CoinApp
//
//  Created by hym on 2019/9/2.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EASKNumKeyboardDelegate <NSObject>

@optional
/** 切换字母键盘 */
- (void)didSwitchLetterPad;
/**
 点击了数字键

 @param letter 数字字母
 */
- (void)didNumKeyboardClick:(NSString *)letter;

/** 点击了数字键盘的删除键 */
- (void)didNumKeyboardDelete;
/** 点击了数字键盘的收回键 */
- (void)didNumKeyboardClickDismiss;

@end

@interface EASKNumKeyboardView : UIView

@property (nonatomic, assign) id<EASKNumKeyboardDelegate>nkDelegate;

@end

NS_ASSUME_NONNULL_END
