//
//  EASKLetterFunctionView.h
//  CoinApp
//
//  Created by hym on 2019/9/2.
//  Copyright © 2019 xfg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 切换数字键盘回调 */
typedef void(^SwitchNumPadBlock)(void);

/** 确认回调 */
typedef void(^ConfirmBlock)(void);

@interface EASKLetterFunctionView : UIView

@property (nonatomic, copy) SwitchNumPadBlock switchNumPadBlock;
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end

NS_ASSUME_NONNULL_END
