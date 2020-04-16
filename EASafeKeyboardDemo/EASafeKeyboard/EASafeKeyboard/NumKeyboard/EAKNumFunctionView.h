//
//  EASKNumFunctionView.h
//  CoinApp
//
//  Created by eAssh on 2019/9/2.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 键盘回收回调 */
typedef void(^DismissBlock)(void);
/** 确定回调 */
typedef void(^ConfirmBlock)(void);

@interface EAKNumFunctionView : UIView

@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end

NS_ASSUME_NONNULL_END
