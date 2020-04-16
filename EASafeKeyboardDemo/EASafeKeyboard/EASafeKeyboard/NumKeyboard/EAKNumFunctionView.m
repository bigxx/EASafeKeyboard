//
//  EASKNumFunctionView.m
//  CoinApp
//
//  Created by eAssh on 2019/9/2.
//  Copyright © 2019 eAssh. All rights reserved.
//

#import "EAKNumFunctionView.h"
#import "EASafeKeyboardHelp.h"

@interface EAKNumFunctionView ()

@property (nonatomic, strong) UIButton *dismissBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, assign) CGFloat itemHeight;

@end

@implementation EAKNumFunctionView
#pragma mark - Constant
// 边距
static const CGFloat Margin = 10;
// 控件间距
static const CGFloat ItemSpace = 10;

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self setMainUI];
    }
    return self;
}

#pragma mark - Set Up
- (void)initData {
    // 设置控件高度
    self.itemHeight = [self getNumPadItemHeight];
}

- (void)setMainUI {
    self.backgroundColor = EASKBackgroundColor;
    
    [self addSubview:self.dismissBtn];
    [self addSubview:self.confirmBtn];
}

#pragma mark - Property
- (UIButton *)dismissBtn {
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissBtn.frame = CGRectMake(0, Margin, CGRectGetWidth(self.frame)-Margin, self.itemHeight);
        [_dismissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dismissBtn setBackgroundColor:[UIColor whiteColor]];
        _dismissBtn.layer.cornerRadius = EASKLayerRadius;
        _dismissBtn.layer.masksToBounds = YES;
        [_dismissBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *image = [EASafeKeyboardHelp convertViewToImage:@"keyboard_shouqijianpan" rect:_dismissBtn.frame imageSize:CGSizeMake(21, 20)];
        [_dismissBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    return _dismissBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        CGFloat height = self.itemHeight * 3 + ItemSpace * 2;
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(0, CGRectGetHeight(self.frame)-height-Margin, CGRectGetWidth(self.frame)-Margin, height);
        [_confirmBtn setTitle:@"OK" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:EASKButtonBackgroundColor];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        _confirmBtn.layer.cornerRadius = EASKLayerRadius;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

#pragma mark - Action
// MARK:键盘回收事件
- (void)dismissAction {
    // 键盘回收回调
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

// MARK:确认事件
- (void)confirmAction {
    // 确认回调
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

// MAKR:获取数字控件高度
- (CGFloat)getNumPadItemHeight {
    CGFloat lineSpace = 10;
    NSInteger items = 4;
    CGFloat height = (CGRectGetHeight(self.frame) - lineSpace * (items + 1)) / items;
    return height;
}

@end
