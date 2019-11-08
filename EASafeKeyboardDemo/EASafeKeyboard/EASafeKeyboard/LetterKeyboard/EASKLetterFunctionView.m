//
//  EASKLetterFunctionView.m
//  CoinApp
//
//  Created by hym on 2019/9/2.
//  Copyright © 2019 xfg. All rights reserved.
//

#import "EASKLetterFunctionView.h"
#import "EASafeKeyboardHelp.h"

@interface EASKLetterFunctionView ()

@property (nonatomic, strong) UIButton *switchNumBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UILabel *titLab;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation EASKLetterFunctionView
#pragma mark - Constant
// 边距
static const CGFloat Margin = 17;
// logo大小
static const CGFloat IconWidth = 15;

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
}

- (void)setMainUI {
    self.backgroundColor = EASKBackgroundColor;
    
    [self addSubview:self.switchNumBtn];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.titLab];
}

#pragma mark - Property
- (UIButton *)switchNumBtn {
    if (!_switchNumBtn) {
        _switchNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchNumBtn.frame = CGRectMake(Margin, 0, 78, 42);
        [_switchNumBtn setTitle:@"123" forState:UIControlStateNormal];
        [_switchNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_switchNumBtn setBackgroundColor:[UIColor whiteColor]];
        _switchNumBtn.layer.cornerRadius = EASKLayerRadius;
        _switchNumBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        [_switchNumBtn addTarget:self action:@selector(switchNumAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchNumBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(self.frame.size.width-Margin-78, 0, 78, 42);
        [_confirmBtn setTitle:@"OK" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:EASKButtonBackgroundColor];
        _confirmBtn.layer.cornerRadius = EASKLayerRadius;
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:19];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UILabel *)titLab {
    if (!_titLab) {
        CGFloat orignX = CGRectGetMaxX(self.switchNumBtn.frame)+5;
        CGFloat width = CGRectGetMinX(self.confirmBtn.frame)-orignX;
        _titLab = [[UILabel alloc] initWithFrame:CGRectMake(orignX, 0, width, CGRectGetHeight(self.switchNumBtn.frame))];
        _titLab.font = [UIFont systemFontOfSize:12];
        _titLab.textColor = EASKTitleColor;
        _titLab.textAlignment = NSTextAlignmentCenter;
        _titLab.text = @"安全键盘";
        [_titLab addSubview:self.iconView];
    }
    return _titLab;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        CGRect textRect = [_titLab textRectForBounds:_titLab.frame limitedToNumberOfLines:0];
        CGFloat orignX = (_titLab.frame.size.width-textRect.size.width)/2-IconWidth-2;
        CGFloat orignY = (_titLab.frame.size.height-IconWidth)/2;
        
        _iconView = [[UIImageView alloc] init];
        _iconView.frame = CGRectMake(orignX, orignY, IconWidth, IconWidth);
        _iconView.backgroundColor = [UIColor lightGrayColor];
    }
    return _iconView;
}

#pragma mark - Action
- (void)switchNumAction {
    if (self.switchNumPadBlock) {
        self.switchNumPadBlock();
    }
}

- (void)confirmAction {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

@end
