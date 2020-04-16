
//
//  EASKNumberCell.m
//  CoinApp
//
//  Created by eAssh on 2019/8/30.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "EASKNumberCell.h"
#import "EASafeKeyboardHelp.h"

@interface EASKNumberCell ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) EANumKeyType keyType;

@end

@implementation EASKNumberCell
#pragma mark - Constant
static NSString *DeleteKey = @"删除";

#pragma mark - Life
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setMainUI];
    }
    return self;
}

#pragma mark - Set Up
- (void)setMainUI {
    [self.contentView addSubview:self.button];
}

#pragma mark - Property
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
        [_button setTitleColor:EASKTitleColor forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:22];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        _button.layer.cornerRadius = EASKLayerRadius;
        _button.layer.borderColor = EASKSpaceColor.CGColor;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - Set/Get
- (void)setTitle:(NSString *)title {
    // 设置显示的标题
    _title = title;
    // 默认控件类型为数字字母
    self.keyType = EANumberKeyType;
    // 标题为 ABC，设置控件类型为 切换按钮
    if ([self.title isEqualToString:@"ABC"]) {
        self.keyType = EASwitchKeyType;
    }
    // 标题为 删除，设置控件类型为 删除按钮
    if ([self.title isEqualToString:DeleteKey]) {
        self.keyType = EANumberDeleteKeyType;
    }
    
    // 设置按钮
    [self setButton];
}

#pragma mark - UI Help
- (void)setButton {
    // 重置按钮
    self.button.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [_button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [self.button setTitle:@"" forState:UIControlStateNormal];
    
    if ([_title isEqualToString:DeleteKey]) {
        UIImage *image = [EASafeKeyboardHelp convertViewToImage:@"keyboard_shurushanchu" rect:self.button.frame imageSize:CGSizeMake(22, 16)];
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        // 设置按钮标题
        [self.button setTitle:_title forState:UIControlStateNormal];
        if ([_title isEqualToString:@"ABC"]) {
            self.button.titleLabel.font = [UIFont systemFontOfSize:19];
        } else {
            self.button.titleLabel.font = [UIFont systemFontOfSize:22];
        }
    }
}

#pragma mark - Action
// MARK:按钮点击事件
- (void)clickAction {
    // 数字回调
    if (self.numberBlock) {
        self.numberBlock(self.title,self.keyType);
    }
}

@end
