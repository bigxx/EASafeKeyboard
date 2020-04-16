//
//  EASKNumCell.m
//  CoinApp
//
//  Created by eAssh on 2019/8/30.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "EASKLetterCell.h"
#import "EASafeKeyboardHelp.h"

@interface EASKLetterCell ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) EALetterKeyType keyType;

@end

@implementation EASKLetterCell
#pragma mark - Constant
static NSString *DeleteKey = @"删除";
static NSString *CapitalKey = @"大写";

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
        _button.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [_button setTitleColor:EASKTitleColor forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
        _button.titleLabel.font = [UIFont systemFontOfSize:22];
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
    // 设置默认的控件类型为字母
    self.keyType = EAWorldKeyType;
    // 标题为 大写，设置控件类型为 大写按钮
    if ([_title isEqualToString:CapitalKey]) {
        self.keyType = EACapitalKeyType;
    }
    // 标题为 删除，设置控件类型为 删除按钮
    if ([_title isEqualToString:DeleteKey]) {
        self.keyType = EAWorldDeleteKeyType;
    }
    // 设置按钮
    [self setButton];
}

- (void)setIsCapital:(BOOL)isCapital {
    // 设置大写开关
    _isCapital = isCapital;
    if (isCapital) {
        _title = [_title uppercaseString];
    } else {
        _title = [_title lowercaseString];
    }
    [self setButton];
}

#pragma mark - UI Help
- (void)setButton {
    // 重置按钮
    self.button.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [_button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [self.button setTitle:@"" forState:UIControlStateNormal];
    
    if ([_title isEqualToString:CapitalKey]) {
        UIImage *image = [EASafeKeyboardHelp convertViewToImage:@"keyboard_daxie" rect:self.button.frame imageSize:CGSizeMake(19, 19)];
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
    } else if ([_title isEqualToString:DeleteKey]) {
        UIImage *image = [EASafeKeyboardHelp convertViewToImage:@"keyboard_shurushanchu" rect:self.button.frame imageSize:CGSizeMake(22, 16)];
        [self.button setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        // 设置button标题
        [self.button setTitle:_title forState:UIControlStateNormal];
    }
}

#pragma mark - Action
// MARK:点击事件
- (void)clickAction {
    // 字母回调
    if (self.letterBlock) {
        self.letterBlock(self.title,self.keyType);
    }
}

@end
