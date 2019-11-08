//
//  EASafeTextField.h
//  CoinApp
//
//  Created by hym on 2019/9/2.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 安全键盘自定义UITextField

 - EASKTextFieldSystemKeyboard: 系统键盘
 - EASKTextFieldSafeKeyboard: 安全键盘
 */
typedef NS_ENUM(NSInteger,EASKTextFieldKeyboardType) {
    EASKTextFieldSystemKeyboard = 0,
    EASKTextFieldSafeKeyboard = 1
};

@interface EASafeTextField : UITextField

/** 自定义键盘类型 */
@property (nonatomic, assign) EASKTextFieldKeyboardType eKeyboardType;

@end

NS_ASSUME_NONNULL_END
