//
//  EASKNumberCell.h
//  CoinApp
//
//  Created by eAssh on 2019/8/30.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 字母键盘控件类型

 - EANumberKeyType: 数字
 - EASwitchKeyType:切换到字母键盘
 - EANumberDeleteKeyType: 删除按钮
*/
typedef NS_ENUM(NSInteger,EANumKeyType) {
    EANumberKeyType = 0,
    EASwitchKeyType = 1,
    EANumberDeleteKeyType = 2
};

/**
 点击数字回调

 @param selectNumber 选中的数字
 @param keyType 控件类型
 */
typedef void(^NumerBlock)(NSString *selectNumber,EANumKeyType keyType);

@interface EASKNumberCell : UICollectionViewCell

/** 显示的标题 */
@property (nonatomic, strong) NSString *title;

/** 数字回调 */
@property (nonatomic, copy) NumerBlock numberBlock;

@end

NS_ASSUME_NONNULL_END
